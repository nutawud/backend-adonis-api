'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class UserSchema extends Schema {
  up() {
    this.create('user', (table) => {
      table.increments()
      table.string('email', 128).notNullable()
      table.string('password', 64).notNullable()
      table.string('fullname', 256).notNullable()
      table.string('phone_number', 64)
      table.integer('status_id').unsigned().references('id').inTable('status').notNullable().defaultTo(1)
      table.timestamps()
    })
  }

  down() {
    this.drop('user')
  }
}

module.exports = UserSchema
