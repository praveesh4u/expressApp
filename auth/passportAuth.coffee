module.exports = (passport, LocalStrategy)->
  passport.use 'local-db', new LocalStrategy {
    usernameField: 'email',
    passwordField: 'password'
  },(email, password, done)->
    GLOBAL.db.User.findByEmail email, (user)->
      return done(null, false, { message: 'Incorrect email.' }) if not user
      user.isValidPassword password, (err,status)->
        return done(null, false, { message: 'Incorrect password.' }) if status is false
        return done(null, user) if status is true

  passport.serializeUser (user, done)->
    done(null, user.id)
  passport.deserializeUser (id, done)->
    GLOBAL.db.User.findById id, done
  return




    