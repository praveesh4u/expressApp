// Generated by CoffeeScript 1.9.3
(function() {
  module.exports = function(express, app) {
    var router;
    router = express.Router();
    router.get('/user', function(req, res, next) {
      return res.render('user-list');
    });
    return app.use('/', router);
  };

}).call(this);