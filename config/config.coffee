module.exports = (env)->
  config = require(__dirname + '/../config/config.json')
  config[env]