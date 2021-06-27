'use strict'

/*
|--------------------------------------------------------------------------
| UserTypeSeeder
|--------------------------------------------------------------------------
|
| Make use of the Factory instance to seed database with dummy data or
| make use of Lucid models directly.
|
*/

/** @type {import('@adonisjs/lucid/src/Factory')} */
const Factory = use('Factory')

class UserTypeSeeder {
  async run() {
    await Factory.model('App/Models/UserType')
      .createMany(1, [{
        id: 1,
        name: 'Platform admin',
      }])
  }
}

module.exports = UserTypeSeeder
