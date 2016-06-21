var express = require('express'),
    app = express()
    path = require('path'),
    hogan = require('hogan-express'),
    sequelze = require('sequelize'),
    cookieParser = require('cookie-parser'),
    session = require('express-session'),
    env = process.env.NODE_ENV || 'development',
    winston = require('winston'),
    GLOBAL.helper = require('./helpers/helper'),
    redis = require('redis'),
    redisStore = require('connect-redis')(session),
    bodyParser = require('body-parser'),
    client = redis.createClient(),
    mysql = require('mysql'),
    GLOBAL.appConfig =  require('./config/config.js')(env),
    GLOBAL.db = require('./models/index'),
    passport = require('passport'),
    LocalStrategy = require('passport-local').Strategy,
    bcrypt = require('bcrypt'),
    flash=require("connect-flash");


//Logger configuration
 GLOBAL.logger = new winston.Logger({
    level: 'info',
    transports: [
        new (winston.transports.Console)(),
        new (winston.transports.File)({ filename: 'Detailed Log.log' })
    ]
});


app.set('views', path.join(__dirname,'views'));
app.engine('html', hogan);
app.set('view engine','html');
app.set('layout', 'layout/layout');
app.set('partials', {header: "includes/header", footer: "includes/footer"});
app.use(express.static(path.join(__dirname,'public')));
app.use(cookieParser());
app.use(flash());
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());
app.use(session(
    {
        secret:'liteBreeze',
        cookie: { maxAge: 60000 },
        store: new redisStore({
            host: 'localhost',
            port: 6379,
            client: client,
            ttl: 260
        }),
        resave: true,
        saveUninitialized: true
    }
));

/** Database Sync**/
GLOBAL.db.sequelize.sync({
    // force: true,
}).then(function(){
    console.log('Database Sync finished');
});

helper.hashPassword('qwerty87','$2a$10$lh6oTMzYYEphJ1bHN/oveO',function(err, hash){
    console.log(hash);
});


/** Passport JS **/
app.use(passport.initialize());
app.use(passport.session());
require('./auth/passportAuth')(passport, LocalStrategy);


/** routes **/
require('./routes/auth.js')(express,app);
require('./routes/routes.js')(express,app);
require('./routes/user.js')(express,app);

app.listen(3000,function(){
    console.log('The app has started');
});