module.exports = (express,app)->
  router = express.Router()

  router.get '/user',(req,res,next)->
    res.locals = {
      'message' : 'LiteBreeze',
      'data' : [
        {
          'name': 'Praveesh',
          'id' : 2
        },
        {
          'name': 'Praveen',
          'id' : 10
        },
        {
          'name': 'Akhil',
          'id' : 15
        }

      ]
    }
    res.render 'user-list',{
    }


  app.use '/', router