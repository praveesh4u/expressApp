var express = require('express'),
    app = express()
    path = require('path'),
    hogan = require('hogan-express'),
    sequelze = require('sequelize'),
    cookieParser = require('cookie-parser'),
    session = require('express-session'),
    env = process.env.NODE_ENV || 'development',
    winston = require('winston'),
    helper = require('./helpers/helper'),
    redis = require('redis'),
    redisStore = require('connect-redis')(session),
    bodyParser = require('body-parser'),
    client = redis.createClient();
//Logger configuration
var logger = new winston.Logger({
    level: 'info',
    transports: [
        new (winston.transports.Console)(),
        new (winston.transports.File)({ filename: 'Detailed Log.log' })
    ]
});

GLOBAL.appConfig =  require('./config/config.js')(env);
logger.info(helper);
app.set('views', path.join(__dirname,'views'));
app.engine('html', hogan);
app.set('view engine','html');
app.use(express.static(path.join(__dirname,'public')));
app.use(cookieParser());
app.use(session(
    {
        secret:'liteBreeze',
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


require('./routes/routes.js')(express,app);
require('./routes/user.js')(express,app);


app.listen(3000,function(){
    console.log('The app has started');
});