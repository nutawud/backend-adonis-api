'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class Status extends Model {
  static $ACTIVE = 1
  static $INACTIVE = 2
  static $DELETED = 3
  static $WAITING = 4
  static $QUEUED = 5
  static $PENDING = 6
  static $PROCESSING = 7
  static $DRAFT = 8

  static get table() {
    return 'status'
  }
}

module.exports = Status
