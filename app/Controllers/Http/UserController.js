'use strict'
const _ = require('lodash');
const Encryption = use('Encryption')
const Mail = use('Mail')
const Hash = use('Hash')
const Env = use('Env')
const BaseController = use('BaseController')
const Status = use('App/Models/Status')
const User = use('App/Models/User')
const UserType = use('App/Models/UserType')
const UserUserType = use('App/Models/UserUserType')
const Token = use('App/Models/Token')
const ForgotPassword = use('App/Models/ForgotPassword')

class UserController extends BaseController {
  constructor() {
    super(User)
    this.setResMsgCode()
  }

  setResMsgCode() {
    this.resMsgCode.error.user_not_found = 'USER_NOT_FOUND'
    this.resMsgCode.error.data_invalid = 'DATA_INVALID'
    this.resMsgCode.error.email_duplicate = 'EMAIL_DUPLICATE'
    this.resMsgCode.error.code_expired = 'CODE_EXPIRED'
  }

  async login(context) {
    try {
      const request = context.request.all()

      if (request.email && request.password) {
        let user = await this.model.query()
          .where('email', request.email)
          .where('status_id', Status.$ACTIVE)
          .first()

        if (!_.isEmpty(user)) {
          if (await context.auth.attempt(request.email, request.password)) {
            await this.updateRevokedToken(user)

            let accessToken = await context.auth.withRefreshToken().generate(user)

            user = user.toJSON()
            user.user_type_id = await this.getUserUserTypeId(user.id)
            user.userType = await this.getUserType(user.user_type_id)

            return this.responseSuccess(context, { accessToken, user })
          }
        }
      }

      return this.responseError(context, this.resMsgCode.error.user_not_found)
    } catch (error) {
      if (error.name === 'UserNotFoundException' || error.name === 'PasswordMisMatchException') {
        return this.responseError(context, this.resMsgCode.error.user_not_found)
      } else {
        return this.responseError(context, this.resMsgCode.error.occurred, true, error);
      }
    }
  }

  async register(context) {
    try {
      const request = context.request.all()

      let user = await this.model.query()
        .where('email', request.email)
        .where('status_id', Status.$ACTIVE)
        .first();

      if (_.isEmpty(user)) {
        user = await new this.model();
        user.email = request.email.trim()
        user.fullname = request.fullname
        user.phone_number = request.phone_number
        user.password = request.password.trim()

        if (await user.save()) {
          let userUserType = new UserUserType();

          userUserType.user_id = user.id
          userUserType.user_type_id = UserType.$USER
          await userUserType.save()

          if (await context.auth.attempt(request.email, request.password)) {
            await this.updateRevokedToken(user)

            let accessToken = await context.auth.withRefreshToken().generate(user)

            user = user.toJSON()
            user.user_type_id = userUserType.user_type_id
            user.userType = await this.getUserType(user.user_type_id)

            return this.responseSuccess(context, { accessToken, user })
          }
        }

        return this.responseError(context, this.resMsgCode.error.save)
      } else {
        return this.responseError(context, this.resMsgCode.error.email_duplicate)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async verify(context) {
    try {
      const { refreshToken } = context.request.all()
      let token = await Token.query()
        .where('token', Encryption.decrypt(refreshToken))
        .where('type', 'jwt_refresh_token')
        .last()

      if (!_.isEmpty(token)) {
        let user = await this.model.query()
          .where('id', token.user_id)
          .where('status_id', Status.$ACTIVE)
          .first()

        if (!_.isEmpty(user)) {
          let accessToken = await context.auth.generateForRefreshToken(refreshToken);

          user = user.toJSON()
          user.user_type_id = await this.getUserUserTypeId(user.id)
          user.userType = await this.getUserType(user.user_type_id)

          if (!_.isEmpty(accessToken)) {
            return this.responseSuccess(context, { accessToken, user })
          }
        }
      }

      return this.responseError(context, this.resMsgCode.error.user_not_found);
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async refreshToken(context) {
    try {
      const { refreshToken } = context.request.all()
      let token = await Token.query()
        .where('token', Encryption.decrypt(refreshToken))
        .where('type', 'jwt_refresh_token')
        .last()

      if (!_.isEmpty(token)) {
        let user = await this.model.query()
          .where('id', token.user_id)
          .where('status_id', Status.$ACTIVE)
          .first()

        if (!_.isEmpty(user)) {
          let accessToken = await context.auth.generateForRefreshToken(refreshToken);

          return this.responseSuccess(context, { accessToken })
        }
      }

      return this.responseError(context, 'Missing or invalid api token')
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.email_duplicate)
    }
  }

  async logout(context) {
    try {
      const user = await this.model.find(context.auth.user.id)

      if (!_.isEmpty(user)) {
        if (await context.auth.authenticator('jwt').revokeTokensForUser(user)) {
          return this.responseSuccess(context, 'Logout')
        } else {
          return this.responseError(context, this.resMsgCode.error.data_invalid, true, 'Error revoke tokens');
        }
      } else {
        return this.responseError(context, this.resMsgCode.error.user_not_found)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async getProfile(context) {
    try {
      let user = await this.model.query()
        .where('id', context.auth.user.id)
        .where('status_id', Status.$ACTIVE)
        .first()

      if (!_.isEmpty(user)) {
        return this.responseSuccess(context, user)
      } else {
        return this.responseError(context, this.resMsgCode.error.user_not_found)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async updateProfile(context) {
    try {
      const request = context.request.all()
      let user = await this.model.query()
        .where('id', context.auth.user.id)
        .where('status_id', Status.$ACTIVE)
        .first()

      if (!_.isEmpty(user)) {
        let userEmailCheck = await User.query()
          .where('email', request.email)
          .where('id', '!=', context.auth.user.id)
          .first()

        if (_.isEmpty(userEmailCheck)) {
          user.email = request.email.trim()
          user.fullname = request.fullname
          user.phone_number = request.phone_number

          if (await user.save()) {
            return this.responseSuccess(context, user)
          } else {
            return this.responseSuccess(context, this.resMsgCode.error.save)
          }
        } else {
          return this.responseError(context, this.resMsgCode.error.email_duplicate)
        }
      } else {
        return this.responseError(context, this.resMsgCode.error.user_not_found)
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async forgotPassword(context) {
    try {
      const request = context.request.all()
      let user = await this.model.query()
        .where('email', request.email)
        .where('status_id', Status.$ACTIVE)
        .first()

      if (!_.isEmpty(user)) {
        await ForgotPassword.query()
          .where('user_id', user.id)
          .where('email', user.email)
          .update({
            status_id: Status.$DELETED
          })

        const code = Math.random().toString(36).substring(2, 8);
        let forgotPassword = await new ForgotPassword();

        forgotPassword.user_id = user.id
        forgotPassword.email = request.email
        forgotPassword.code = code

        if (await forgotPassword.save()) {
          await Mail.send('emails.forgotPassword', { code: code }, (message) => {
            message
              .to(request.email)
              .from(Env.get('MAIL_USERNAME'))
              .subject('Forgot password')
          })

          return this.responseSuccess(context, this.resMsgCode.success.save)
        } else {
          return this.responseError(context, this.resMsgCode.error.save)
        }
      }

      return this.responseError(context, this.resMsgCode.error.user_not_found);
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async newPassword(context) {
    try {
      const request = context.request.all()
      let forgotPassword = await ForgotPassword.query()
        .where('code', request.code)
        .where('status_id', Status.$ACTIVE)
        .last()

      if (!_.isEmpty(forgotPassword)) {
        let currentDateTime = new Date().getTime();
        let forgotPasswordDateTime = new Date(forgotPassword.created_at).getTime();
        let diffMs = (currentDateTime - forgotPasswordDateTime);
        let diffMins = Math.round(((diffMs % 86400000) % 3600000) / 60000);

        if (diffMins < 3) {
          await this.model.query()
            .where('id', forgotPassword.user_id)
            .where('status_id', Status.$ACTIVE)
            .update({
              password: await Hash.make(request.new_password)
            })

          await ForgotPassword.query()
            .where('user_id', forgotPassword.user_id)
            .where('email', forgotPassword.email)
            .update({
              status_id: Status.$DELETED
            })

          return this.responseSuccess(context, this.resMsgCode.success.save)
        } else {
          return this.responseError(context, this.resMsgCode.error.code_expired);
        }
      } else {
        return this.responseError(context, this.resMsgCode.error.user_not_found);
      }
    } catch (error) {
      return this.responseError(context, this.resMsgCode.error.occurred, true, error);
    }
  }

  async changePassword(context) {
    try {
      const request = context.request.all()
      let user = await this.model.query()
        .where('id', context.auth.user.id)
        .where('status_id', Status.$ACTIVE)
        .first()

      if (!_.isEmpty(user)) {
        if (await context.auth.validate(user.email, request.old_password)) {
          user.password = request.new_password

          if (await user.save()) {
            return this.responseSuccess(context, this.resMsgCode.success.save)
          } else {
            return this.responseError(context, this.resMsgCode.error.save)
          }
        } else {
          return this.responseError(context, this.resMsgCode.error.data_invalid)
        }
      } else {
        return this.responseError(context, this.resMsgCode.error.user_not_found)
      }
    } catch (error) {
      if (error.name === 'UserNotFoundException') {
        return this.responseError(context, this.resMsgCode.error.user_not_found)
      } else if (error.name === 'PasswordMisMatchException') {
        return this.responseError(context, this.resMsgCode.error.data_invalid)
      } else {
        return this.responseError(context, this.resMsgCode.error.occurred, true, error);
      }
    }
  }

  // Internal function
  async updateRevokedToken(user) {
    return await Token.query()
      .where('user_id', user.id)
      .where('type', 'jwt_refresh_token')
      .update({
        is_revoked: true
      })
  }

  async updateUserUserTypeId(userId, userTypeId) {
    let data = await UserUserType.query()
      .where('user_id', userId)
      .where('status_id', Status.$ACTIVE)
      .first()
    if (!_.isEmpty(data) && data["id"]) {
      data.user_type_id = userTypeId
      await data.save()
      return true;
    }
    return false;
  }

  async getUserUserTypeId(userId) {
    let userUserType = await UserUserType.query()
      .where('user_id', userId)
      .where('status_id', Status.$ACTIVE)
      .first()

    return userUserType.user_type_id
  }

  async getUserType(id) {
    return await UserType.find(id)
  }

  async pagination({ request, auth, response }) {
    try {

      let modelQuery = this.model.query()
      modelQuery.whereIn("user.status_id", [this.status.$ACTIVE, this.status.$INACTIVE])
      const queryParams = request.get()
      if (queryParams) {
        let page = queryParams.page
        let perPage = queryParams.perPage
        let orderBy = queryParams.orderBy
        let direction = queryParams.isDesc == "true" ? "desc" : "asc"
        // sort
        if (orderBy && direction) {
          modelQuery.orderBy(orderBy, direction)
        } else {
          modelQuery.orderBy("user.updated_at", "desc")
        }
        // search
        if (queryParams.filterBy && queryParams.filter) {
          let filterBy = queryParams.filterBy.split(',')
          let filter = queryParams.filter
          modelQuery.where((builder) => {
            for (const iterator of filterBy) {
              if (filter) builder.orWhere(iterator, 'LIKE', '%' + filter + '%')
            }
          })
        }
        // select
        if (queryParams.select) {
          modelQuery.select(queryParams.select.split(","))
        }
        // include model
        if (queryParams.include) {
          let include = queryParams.include.split(',')
          for (const iterator of include) {
            modelQuery.with(iterator, builder => {
              builder.where('status_id', 1)
            })
          }
        }
        modelQuery.where("user.id", "!=", auth.user.id)
        let datas = await modelQuery.paginate(page, perPage)
        if (!_.isEmpty(datas)) {
          return response.json({ 'status': 'success', 'data': datas }, 200)
        }
        return response.json({ 'status': 'error', 'error': "DATA_NOT_FOUND" }, 200)
      }
    } catch (error) {
      return response.json({ 'status': 'error', 'error': error.toString() }, 200)
    }
  }

  async get({ request, auth, response }) {
    try {
      const id = request.params.id
      let modelQuery = this.model.query()
      modelQuery.join("user_user_type", "user_user_type.user_id", "user.id")
      modelQuery.join("user_type", "user_type.id", "user_user_type.user_type_id")
      modelQuery.with('user_user_type', (builder) => {
        builder.where('status_id', this.status.$ACTIVE)
      })
      modelQuery.select(['user.*'])
      modelQuery.where('user.id', id)
      modelQuery.whereIn("user.status_id", [this.status.$ACTIVE, this.status.$INACTIVE])
      let data = await modelQuery.first()
      return response.json({ 'status': 'success', 'data': data }, 200)
    } catch (error) {
      return response.json({ 'status': 'error', 'error': error.toString() }, 200)
    }
  }

  async updateStatus({ request, auth, response }) {
    try {
      const id = request.params.id
      let body = request.all()
      let model = await this.model.find(id)
      model["status_id"] = body.status_id
      if (await model.save()) {
        await Token.query().where("user_id", id).where("type", "jwt_refresh_token").update({ is_revoked: true })
        return response.json({ 'status': 'success', 'data': "SUCCESS_TO_SAVE_DATA" }, 200)
      } else {
        return response.json({ 'status': 'error', 'error': "FAIL_TO_SAVE_DATA" }, 200)
      }
    } catch (error) {
      return response.json({ 'status': 'error', 'error': error.toString() }, 200)
    }
  }

  async updatePassword({ request, auth, response }) {
    try {
      const id = request.params.id
      let body = request.all()
      let model = await this.model.find(id)
      if (!_.isEmpty(model) && model["email"]) {

        if (await auth.validate(model["email"], body["old_password"])) {
          model["password"] = body["new_password"];
          if (await model.save()) {
            return response.json({ 'status': 'success', 'data': "SUCCESS_TO_SAVE_DATA" }, 200)
          }
        }
      }
      return response.json({ 'status': 'error', 'error': "DATA_INVALID" }, 200)
    } catch (error) {
      if (error.name === 'UserNotFoundException' || error.name === 'PasswordMisMatchException') {
        return response.json({ 'status': 'error', 'error': "USER_NOT_FOUND" }, 200)
      }
      return response.json({ 'status': 'error', 'error': error.toString() }, 200)
    }
  }

  async create({ request, auth, response }) {
    try {
      let model = await new this.model();
      let body = request.all()
      body["fullname"] = body["fullname"].trim()

      let modelQuery = this.model.query()
      modelQuery.where('email', body.email)
      modelQuery.whereIn("status_id", [this.status.$ACTIVE, this.status.$INACTIVE])
      let data = await modelQuery.first();
      if (!_.isEmpty(data) && data["id"]) {
        if (data["status_id"] == this.status.$ACTIVE) {
          return response.json({ 'status': 'error', 'error': "EMAIL_DUPICATE" }, 200)
        } else {
          model = await this.model.find(data["id"])
        }
      }
      Object.keys(body).forEach((value) => {
        Object.values(model.$visible).forEach((value_visible) => {
          if (value == value_visible) {
            model[value] = body[value]
          }
        })
      })
      model["password"] = body["password"]
      model["status_id"] = this.status.$ACTIVE
      if (await model.save()) {

        // create user user type
        let userUserType = new UserUserType();

        userUserType.user_id = model.id
        userUserType.user_type_id = body["user_type_id"]
        if (await userUserType.save()) {
          return response.json({ 'status': 'success', 'data': "SUCCESS_TO_SAVE_DATA" }, 200)
        } else {
          return response.json({ 'status': 'error', 'error': "FAIL_TO_SAVE_DATA" }, 200)
        }
      } else {
        return response.json({ 'status': 'error', 'error': "FAIL_TO_SAVE_DATA" }, 200)
      }
    } catch (error) {
      return response.json({ 'status': 'error', 'error': error.toString() }, 200)
    }
  }

  async update({ request, auth, response }) {
    try {
      const id = request.params.id
      let body = request.all()
      body["fullname"] = body["fullname"].trim()
      let model = await this.model.find(id)
      if (!_.isEmpty(model)) {

        delete body["email"];
        let modelQuery = this.model.query()
        modelQuery.whereIn("status_id", [this.status.$ACTIVE, this.status.$INACTIVE])
        Object.keys(body).forEach((value) => {
          Object.values(model.$visible).forEach((value_visible) => {
            if (value == value_visible) {
              modelQuery.where(value, body[value])
            }
          })
        })
        let data = await modelQuery.first();
        if (!_.isEmpty(data)) {
          return response.json({ 'status': 'error', 'error': "DATA_DUPICATE" }, 200)
        }
        Object.keys(body).forEach((value) => {
          Object.values(model.$visible).forEach((value_visible) => {
            if (value == value_visible) {
              model[value] = body[value]
            }
          })
        })
        await model.save()
        if (await this.updateUserUserTypeId(model.id, body["user_type_id"])) {
          return response.json({ 'status': 'success', 'data': "SUCCESS_TO_SAVE_DATA" }, 200)
        } else {
          return response.json({ 'status': 'error', 'error': "FAIL_TO_SAVE_DATA" }, 200)
        }
      }
      return response.json({ 'status': 'error', 'error': "DATA_INVALID" }, 200)
    } catch (error) {
      return response.json({ 'status': 'error', 'error': error.toString() }, 200)
    }
  }

}

module.exports = UserController
