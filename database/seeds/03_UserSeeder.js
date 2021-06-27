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
    await Factory.model('App/Models/User')
      .createMany(1, [{
        id: 1,
        email: 'super_admin@email.com',
        password: '123456',
        fullname: 'Super Admin'
      }])
  }
}

module.exports = UserSeeder
