'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class UserTypeSchema extends Schema {
  up() {
    this.create('user_type', (table) => {
      table.increments()
      table.string('name', 128).notNullable()
      table.integer('status_id').unsigned().references('id').inTable('status').notNullable().defaultTo(1)
      table.timestamps()
    })
  }

  down() {
    this.drop('user_type')
  }
}

module.exports = UserTypeSchema
