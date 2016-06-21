// Generated by CoffeeScript 1.9.3
(function() {
  'use strict';
  module.exports = {
    up: function(queryInterface, Sequelize) {
      queryInterface.bulkInsert('users', [
        {
          'first_name': 'Praveesh',
          'last_name': 'A'
        }
      ]);

      /*
        Add altering commands here.
        Return a promise to correctly handle asynchronicity.
      
        Example:
        return queryInterface.bulkInsert('Person', [{
          name: 'John Doe',
          isBetaMember: false
        }], {});
       */
    },
    down: function(queryInterface, Sequelize) {
      queryInterface.bulkDelete('users', null, {});

      /*
        Add reverting commands here.
        Return a promise to correctly handle asynchronicity.
      
        Example:
        return queryInterface.bulkDelete('Person', null, {});
       */
    }
  };

}).call(this);
