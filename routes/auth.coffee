module.exports = (express, app)->
  router = express.Router()

  router.get '/login',(req, res, next)->
    console.log req.flash 'error'
    console.log req.flash 'info'
    console.log req.flash 'warning'
    res.render('auth/login',{})

#  router.post '/login', passport.authenticate('local-db',{
#      failureRedirect: '/login'
#      successRedirect: '/user'
#  }), (req, res, next)->
#
#    res.render('/',{})
  router.post('/login', passport.authenticate('local-db', {
    successRedirect: '/',
    failureRedirect: '/login',
    failureFlash: true
  }));

  router.get '/logout', (req,res,next)->
    req.logout()
    res.redirect('/')

  app.use '/', router
