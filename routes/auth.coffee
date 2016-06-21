module.exports = (express, app)->
  router = express.Router()

  router.get '/login',(req, res, next)->
    res.redirect '/' if req.user
    req.flash 'error', 'Flash is back!'
    req.flash 'info', 'Flash is back!'
    res.render 'auth/login',{
      test : 'qwqwqwqwqw',
      messages: req.flash 'error'
      tt: ['test','55555','77777']
    }

  router.post '/login', passport.authenticate('local-db',{
      failureRedirect: '/login'
      successRedirect: '/'
      failureFlash : true
  }), (req, res, next)->

    res.render('/index',{
      'test': 'test'
    })

  router.get '/logout', (req,res,next)->
    req.logout()
    res.redirect('/')

  app.use '/', router
