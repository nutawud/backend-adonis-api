'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class UserType extends Model {
  static $ADMIN = 1
  static $USER = 2

  static get table() {
    return 'user_type'
  }
}

module.exports = UserType
