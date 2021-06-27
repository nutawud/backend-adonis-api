'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class UserUserTypeSchema extends Schema {
  up() {
    this.create('user_user_type', (table) => {
      table.increments()
      table.integer('user_id').unsigned().references('id').inTable('user')
      table.integer('user_type_id').unsigned().references('id').inTable('user_type')
      table.integer('status_id').unsigned().references('id').inTable('status').notNullable().defaultTo(1)
      table.timestamps()
    })
  }

  down() {
    this.drop('user_user_type')
  }
}

module.exports = UserUserTypeSchema
