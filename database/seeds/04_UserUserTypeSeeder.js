'use strict'

/*
|--------------------------------------------------------------------------
| UserSeeder
|--------------------------------------------------------------------------
|
| Make use of the Factory instance to seed database with dummy data or
| make use of Lucid models directly.
|
*/

/** @type {import('@adonisjs/lucid/src/Factory')} */
const Factory = use('Factory')

class UserSeeder {
  async run() {
    await Factory.model('App/Models/UserUserType')
      .createMany(1, [{
        id: 1,
        user_id: 1,
        user_type_id: 1,
      }])
  }
}

module.exports = UserSeeder
