

exports.test = ()->
  console.log 'Test Helper function called'

exports.test2 = ()->
  console.log 'Test 2 was called'

exports.hashPassword = (plainPassword, salt,cb=()->)->
  bcrypt.hash plainPassword, salt,(err,hash)->
    return cb(err,null) if err
    cb null, hash

