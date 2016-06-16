#exports.test = ()->
#  console.log 'Test Helper function called'
#
#exports.test2 = ()->
#  console.log 'Test 2 was called'

module.exports = (()->
  obj =
    test1:()->
      console.log 'Test 1 was called'
    test2:()->
      console.log 'Test 2 was called'
)()

