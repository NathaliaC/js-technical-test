import { authenticate } from '@feathersjs/authentication'

import { hooks as schemaHooks } from '@feathersjs/schema'
import {
  usersDataValidator,
  usersQueryValidator,
  usersResolver,
  usersExternalResolver,
  usersDataResolver,
  usersQueryResolver
} from './users.schema.js'
import { UsersService, getOptions } from './users.class.js'

export const usersPath = 'users'
export const usersMethods = ['find', 'get', 'create']

export * from './users.class.js'
export * from './users.schema.js'

export const users = (app) => {
  app.use(usersPath, new UsersService(getOptions(app)), {
    methods: usersMethods,
    events: []
  })
  app.service(usersPath).hooks({
    around: {
      all: [schemaHooks.resolveExternal(usersExternalResolver), schemaHooks.resolveResult(usersResolver)],
      find: [authenticate('jwt')],
      get: [authenticate('jwt')],
      create: []
    },
    before: {
      all: [schemaHooks.validateQuery(usersQueryValidator), schemaHooks.resolveQuery(usersQueryResolver)],
      all: [],
      find: [],
      get: [],
      create: [schemaHooks.validateData(usersDataValidator), schemaHooks.resolveData(usersDataResolver)]
    },
    after: {
      all: []
    },
    error: {
      all: []
    }
  })
}
