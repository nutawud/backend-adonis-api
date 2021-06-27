'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class ForgotPasswordSchema extends Schema {
  up() {
    this.create('forgot_password', (table) => {
      table.increments()
      table.integer('user_id').unsigned().references('id').inTable('user')
      table.string('email', 254).notNullable()
      table.string('code', 6).notNullable()
      table.integer('status_id').unsigned().references('id').inTable('status').notNullable().defaultTo(1)
      table.timestamps()
    })
  }

  down() {
    this.drop('forgot_password')
  }
}

module.exports = ForgotPasswordSchema
