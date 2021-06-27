'use strict'

/*
|--------------------------------------------------------------------------
| Factory
|--------------------------------------------------------------------------
|
| Factories are used to define blueprints for database tables or Lucid
| models. Later you can use these blueprints to seed your database
| with dummy data.
|
*/

/** @type {import('@adonisjs/lucid/src/Factory')} */
const Factory = use('Factory')

Factory.blueprint('App/Models/Status', (faker, i, data) => {
  return {
    id: data[i].id,
    name: data[i].name,
  }
})

Factory.blueprint('App/Models/UserType', async (faker, i, data) => {
  return {
    id: data[i].id,
    name: data[i].name,
  }
})

Factory.blueprint('App/Models/User', async (faker, i, data) => {
  return {
    id: data[i].id,
    email: data[i].email,
    password: data[i].password, //Hash auto from model addHook()
    fullname: data[i].fullname,
  }
})

Factory.blueprint('App/Models/UserUserType', async (faker, i, data) => {
  return {
    user_id: data[i].user_id,
    user_type_id: data[i].user_type_id,
  }
})
