import { visits } from './visits/visits.js'
import { users } from './users/users.js'

export const services = (app) => {
  app.configure(visits)
  app.configure(users)
}
