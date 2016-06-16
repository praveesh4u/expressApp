module.exports = (express,app)->
  router = express.Router()

  router.get '/user',(req,res,next)->
    res.render('user-list');

  app.use '/', router