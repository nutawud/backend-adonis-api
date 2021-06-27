'use strict'
const _ = require('lodash');
const Logger = use('Logger')
const Status = use('App/Models/Status')
const Helpers = use('Helpers')
const fs = Helpers.promisify(require('fs'))
const {
  v4: uuidv4
} = require('uuid');

class BaseController {
  status = {
    $ACTIVE: 1,
    $INACTIVE: 2,
    $DELETED: 3,
    $WAITING: 4,
    $QUEUED: 5,
    $PENDING: 6,
    $PROCESSING: 7,
    $DRAFT: 8,
  }

  resMsgCode = {
    error: {
      occurred: 'ERROR_OCCURRED',
      not_found: 'DATA_NOT_FOUND',
      save: 'FAIL_TO_SAVE_DATA',
      delete: 'FAIL_TO_DELETE_DATA',
      missing_param: 'MISSING_PARAMETER'
    },
    success: {
      save: 'SUCCESS_TO_SAVE_DATA',
      delete: 'SUCCESS_TO_DELETE_DATA'
    }
  }

  constructor(model) {
    this.model = model;
  }

  responseSuccess(context, data) {
    return context.response.json({
      'status': 'success',
      'data': data
    }, 200)
  }

  responseError(context, data, logging = false, msg = null) {
    if (logging) {
      const user_id = (context.auth.user) ? context.auth.user.id : null

      if (msg) msg = msg.toString();
      Logger.error(`date_time: [${new Date()}][user_id: ${user_id}]: ${msg}`)
    }

    return context.response.json({
      'status': 'error',
      'error': data
    }, 200)
  }

  async pagination(context) {
    try {
      const queryParams = context.request.get()

      if (!_.isEmpty(queryParams)) {
        let page = queryParams.page
        let perPage = queryParams.perPage
        let orderBy = queryParams.orderBy
        let direction = queryParams.isDesc == 'true' ? 'desc' : 'asc'
        let modelQuery = this.model.query()
          .whereIn('status_id', [Status.$ACTIVE, Status.$INACTIVE])

        if (orderBy && direction) {
          modelQuery.orderBy(orderBy, direction)
        } else {
          modelQuery.orderBy('updated_at', 'desc')
        }

        if (queryParams.filterBy && queryParams.filter) {
          let filterBy = queryParams.filterBy.split(',')
          let filter = queryParams.filter

          modelQuery.where((builder) => {
            for (const field of filterBy) {
              if (filter) builder.orWhere(field, 'LIKE', '%' + filter + '%')
            }
          })
        }

        if (queryParams.select) {
          modelQuery.select(queryParams.select.split(','))
        }

        if (queryParams.include) {
          let include = queryParams.include.split(',')

          for (const table of include) {
            modelQuery.with(table, builder => {
              builder.where('status_id', Status.$ACTIVE)
            })
          }
        }

        let data = await modelQuery.paginate(page, perPage)

        if (!_.isEmpty(data)) {
          return this.responseSuccess(context, data)
        } else {
          return this.responseError(context, this.resMsgCode.error.not_found)
        }
      } else {
        return this.responseError(context, this.resMsgCode.error.missing_param)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async list({
    request,
    auth,
    response
  }) {
    try {
      let modelQuery = this.model.query()
      modelQuery.where('status_id', 1)
      modelQuery.orderBy("updated_at", "desc")
      let datas = await modelQuery.fetch();
      if (!_.isEmpty(datas)) {
        return response.json({
          'status': 'success',
          'data': datas
        }, 200)
      }
      return response.json({
        'status': 'error',
        'error': "DATA_NOT_FOUND"
      }, 200)
    } catch (error) {
      return response.json({
        'status': 'error',
        'error': "ข้อมูลเกิดข้อผิดพลาด"
      }, 200)
    }
  }

  async get(context) {
    try {
      let data = await this.model.query()
        .where('status_id', Status.$ACTIVE)
        .orderBy('updated_at', 'desc')
        .fetch();

      if (!_.isEmpty(data)) {
        return this.responseSuccess(context, data)
      } else {
        return this.responseError(context, this.resMsgCode.error.not_found)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async find(context) {
    try {
      const id = context.request.params.id
      let data = await this.model.query()
        .where('id', id)
        .where('status_id', Status.$ACTIVE)
        .first();

      if (!_.isEmpty(data)) {
        return this.responseSuccess(context, data)
      } else {
        return this.responseError(context, this.resMsgCode.error.not_found)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async findIgnoreStatus(context) {
    try {
      const id = context.request.params.id
      let data = await this.model.query()
        .where('id', id)
        .first();

      if (!_.isEmpty(data)) {
        return this.responseSuccess(context, data)
      } else {
        return this.responseError(context, this.resMsgCode.error.not_found)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async create(context) {
    try {
      let body = context.request.all()
      let model = await new this.model();

      for (const key in body) {
        for (const field of model.$visible) {
          if (key == field) {
            if (typeof body[field] === 'string' || body[field] instanceof String) {
              model[field] = body[field].trim()
            } else {
              model[field] = body[field]
            }
          }
        }
      }

      if (await model.save()) {
        return this.responseSuccess(context, this.resMsgCode.success.save)
      } else {
        return this.responseSuccess(context, this.resMsgCode.error.save)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async update(context) {
    try {
      const id = context.request.params.id
      let body = context.request.all()
      let model = await this.model.find(id);

      for (const key in body) {
        for (const field of model.$visible) {
          if (key == field) {
            if (typeof body[field] === 'string' || body[field] instanceof String) {
              model[field] = body[field].trim()
            } else {
              model[field] = body[field]
            }
          }
        }
      }

      if (await model.save()) {
        return this.responseSuccess(context, this.resMsgCode.success.save)
      } else {
        return this.responseSuccess(context, this.resMsgCode.error.save)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async updateStatus({
    request,
    response
  }) {
    try {
      const id = request.params.id
      let body = request.all()
      let model = await this.model.find(id)
      model["status_id"] = body.status_id
      if (await model.save()) {
        return response.json({
          'status': 'success',
          'data': "SUCCESS_TO_SAVE_DATA"
        }, 200)
      } else {
        return response.json({
          'status': 'error',
          'error': "FAIL_TO_SAVE_DATA"
        }, 200)
      }
    } catch (error) {
      return response.json({
        'status': 'error',
        'error': error.toString()
      }, 200)
    }
  }

  async saveImage(
    modelId,
    imageFile,
    imageLength,
    ImageModel,
    dirPath,
    subImagePath,
    imageField) {

    try {
      if (!_.isEmpty(imageFile)) {
        if (imageLength == 1) {
          let name;
          if (!_.isEmpty(imageFile.extname)) {
            name = `${subImagePath}${uuidv4()}.${imageFile.extname}`;
          } else {
            name = `${subImagePath}${uuidv4()}.jpeg`;
          }
          await imageFile.move(dirPath, {
            name: name,
            overwrite: true,
          });
          let imageModel = new ImageModel()
          imageModel[imageField] = modelId;
          imageModel.image_path = name;
          imageModel.save();
          if (!imageFile.moved()) {
            return false;
          }

        } else {
          await imageFile.moveAll(dirPath, (file) => {
            let name;
            if (!_.isEmpty(imageFile.extname)) {
              name = `${subImagePath}${uuidv4()}.${imageFile.extname}`;
            } else {
              name = `${subImagePath}${uuidv4()}.jpeg`;
            }
            let imageModel = new ImageModel()
            imageModel[imageField] = modelId;
            imageModel.image_path = name;
            imageModel.save()
            return {
              name: name
            }
          })
          if (!imageFile.movedAll()) {
            return false;
          }
        }

      } else {
        return false;
      }

    } catch {
      return false;
    }
    return true;
  }


  async deleteImage(
    ImageModel,
    deleteIdList,
  ) {
    try {
      if (!_.isEmpty(deleteIdList)) {
        let _JSON = deleteIdList.toJSON()
        for (let i = 0; i < _JSON.length; i++) {
          const imageModel = await ImageModel.find(_JSON[i].id)
          await imageModel.delete()
          await fs.unlink(Helpers.publicPath(_JSON[i].image_path))
        }
      }
    } catch {
      return false;
    }
  }



  async delete(context) {
    try {
      const id = context.request.params.id
      let model = await this.model.find(id)

      model['status_id'] = Status.$DELETED

      if (await model.save()) {
        return this.responseSuccess(context, this.resMsgCode.success.delete)
      } else {
        return this.responseSuccess(context, his.resMsgCode.error.delete)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async dateTimeFrom() {
    const now = new Date();
    let get_month = '';

    if ((now.getMonth() + 1) < 10) {
      get_month = '0' + (now.getMonth() + 1)
    } else {
      get_month = (now.getMonth() + 1)
    }

    const date_from = now.getFullYear() + '-' + get_month + '-' + now.getDate();
    return date_from
  }

  async dateTimeTo() {
    const now = new Date();
    let get_month = '';

    if ((now.getMonth() + 1) < 10) {
      get_month = '0' + (now.getMonth() + 1)
    } else {
      get_month = (now.getMonth() + 1)
    }
    const date_to = now.getFullYear() + '-' + get_month + '-' + now.getDate() + ' ' + '23:59:59.993';

    return date_to
  }
}

module.exports = BaseController