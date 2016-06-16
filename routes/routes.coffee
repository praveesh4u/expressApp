module.exports = (express, app)->
  router = express.Router()

  router.get '/',(req,res,next)->
    res.render 'index'
  router.get '/about', (req,res,next)->
    res.send('<h1> About Express</h1>')
  app.use '/', router
