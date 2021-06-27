'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class TokensSchema extends Schema {
  up() {
    this.create('token', (table) => {
      table.increments()
      table.integer('user_id').unsigned().references('id').inTable('user')
      table.string('token', 255).notNullable().index()
      table.string('type', 128).notNullable()
      table.boolean('is_revoked').defaultTo(false)
      table.timestamps()
    })
  }

  down() {
    this.drop('token')
  }
}

module.exports = TokensSchema
