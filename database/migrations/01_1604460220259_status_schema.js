'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class StatusSchema extends Schema {
  up () {
    this.create('status', (table) => {
      table.increments()
      table.string('name', 128).notNullable().unique()
      table.timestamps()
    })
  }

  down () {
    this.drop('status')
  }
}

module.exports = StatusSchema
