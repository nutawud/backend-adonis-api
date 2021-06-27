'use strict'

/*
|--------------------------------------------------------------------------
| StatusSeeder
|--------------------------------------------------------------------------
|
| Make use of the Factory instance to seed database with dummy data or
| make use of Lucid models directly.
|
*/

/** @type {import('@adonisjs/lucid/src/Factory')} */
const Factory = use('Factory')

class StatusSeeder {
  async run() {
    await Factory.model('App/Models/Status')
      .createMany(8, [{
        id: 1,
        name: 'ACTIVE',
      }, {
        id: 2,
        name: 'INACTIVE',
      }, {
        id: 3,
        name: 'DELETED',
      }, {
        id: 4,
        name: 'WAITING',
      }, {
        id: 5,
        name: 'QUEUED',
      }, {
        id: 6,
        name: 'PENDING',
      }, {
        id: 7,
        name: 'PROCESSING',
      }, {
        id: 8,
        name: 'DRAFT',
      }])
  }
}

module.exports = StatusSeeder
