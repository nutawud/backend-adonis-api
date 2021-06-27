'use strict'
const BaseController = use('BaseController')
const UserType = use('App/Models/UserType')
const _ = require('lodash');
const Logger = use('Logger')

class UserTypeController extends BaseController {
  constructor() {
    super(UserType)
  }

  async list({ request, auth, response }){
    try {
      let modelQuery = this.model.query()
      modelQuery.where('status_id', 1)
      modelQuery.orderBy("updated_at","desc")
      let datas = await modelQuery.fetch();
      if(!_.isEmpty(datas)){
        return response.json({'status': 'success', 'data': datas}, 200)
      }
      return response.json({'status': 'error', 'error': "Data not found"}, 200)
    } catch (error) {
      return response.json({ 'status': 'error', 'error': "ข้อมูลเกิดข้อผิดพลาด"}, 200)
    }
  }

}

module.exports = UserTypeController
