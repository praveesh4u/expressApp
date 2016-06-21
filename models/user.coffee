'use strict'
bcrypt = require('bcrypt')
saltRounds = 10
phonetic = require('phonetic')
_         = require "underscore"
helper = GLOBAL.helper

module.exports = (sequelize, DataTypes) ->
  User = sequelize.define('User', {
    first_name:
      type: DataTypes.STRING
      length: 255
      allowNull: false
    email:
      type: DataTypes.STRING
      length: 255
      allowNull: false
    last_name:
      type: DataTypes.STRING
      length: 255
      allowNull: true
    bio:
      type: DataTypes.TEXT
      length: 24000
      allowNull: false
    password:
      type: DataTypes.STRING
      length: 255
      allowNull: false
    salt:
      type: DataTypes.STRING
  },
  underscored: true,
  timestamps: true,
  tableName: 'users'
  classMethods:
    associate: (models) ->
    # associations can be defined here
      return
    findByEmail: (email,cb=()->)->
      User.find({where:{email: email}})
      .then cb
    findById: (id,cb=()->)->
      User.find({where:{id: id}})
      .then cb


    passwordMeetsRequirements: (password = "")->
      return false if password.length < 8           # min 8 characters
      return false if not /[0-9]/.test(password)    # at least one number
      return true
    hashPassword: (plainPassword, salt,cb=()->)->
      bcrypt.hash plainPassword, salt,(err,hash)->
        return cb(err,null) if err
        cb null, hash
    genSalt: (saltRounds,cb=()->)->
      bcrypt.genSalt saltRounds, (err, salt)->
        return cb(err,null) if err
        cb null, salt
    createNewUser: (data, callback)->
      userData = _.extend({}, data)
      console.log userData
      if not User.passwordMeetsRequirements(userData.password)
        return callback "Your password doest not meet the minimum requirements. It must be at least 8 characters and contain at least one one number.", null
      console.log 'passed'
      User.genSalt saltRounds, (err, hash)->
        return callback(err,null) if err
        helper.hashPassword userData.password, hash, (err, hashedPassword)->
          userData.password = hashedPassword
          userData.salt = hash
          User.create(userData).then callback

    generateUsername: (seed)->
      phonetic.generate
        seed: seed


  instanceMethods :
    isValidPassword: (password, cb = ()->)->
      helper.hashPassword password, @salt,(err, hashedPassword)=>
        return cb(err, null) if err
        if hashedPassword is @password
          status =true
        else
          status = false
        cb null, status





    hashPassword: (plainPassword, salt,cb=()->)->
      bcrypt.hash plainPassword, salt,(err,hash)->
        return cb(err,null) if err
        cb null, hash

  )
  User
