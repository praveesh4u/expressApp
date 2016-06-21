'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.bulkInsert 'users', [
      {
        'first_name' : 'Praveesh',
        'last_name'  : 'A',
      }
    ]

    ###
      Add altering commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      return queryInterface.bulkInsert('Person', [{
        name: 'John Doe',
        isBetaMember: false
      }], {});
    ###

    return
  down: (queryInterface, Sequelize) ->
    queryInterface.bulkDelete('users',null, {})
    ###
      Add reverting commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      return queryInterface.bulkDelete('Person', null, {});
    ###

    return
