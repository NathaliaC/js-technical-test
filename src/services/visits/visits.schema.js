import { resolve, getValidator, querySyntax } from '@feathersjs/schema'
import { dataValidator, queryValidator } from '../../validators.js'

// Main data model schema
export const visitsSchema = {
  $id: 'Visits',
  type: 'object',
  additionalProperties: false,
  required: ['id', 'website', 'visits'],
  properties: {
    id: { type: 'string' },
    website: { type: 'string' },
    visits: { type: 'number' },
  }
}
export const visitsValidator = getValidator(visitsSchema, dataValidator)
export const visitsResolver = resolve({})

export const visitsExternalResolver = resolve({})

// Schema for creating new data
export const visitsDataSchema = {
  $id: 'VisitsData',
  type: 'object',
  additionalProperties: false,
  required: ['website', 'visits'],
  properties: {
    ...visitsSchema.properties
  }
}
export const visitsDataValidator = getValidator(visitsDataSchema, dataValidator)
export const visitsDataResolver = resolve({})

// Schema for updating existing data
export const visitsPatchSchema = {
  $id: 'VisitsPatch',
  type: 'object',
  additionalProperties: false,
  required: [],
  properties: {
    ...visitsSchema.properties
  }
}
export const visitsPatchValidator = getValidator(visitsPatchSchema, dataValidator)
export const visitsPatchResolver = resolve({})

// Schema for allowed query properties
export const visitsQuerySchema = {
  $id: 'VisitsQuery',
  type: 'object',
  additionalProperties: false,
  properties: {
    ...querySyntax(visitsSchema.properties)
  }
}
export const visitsQueryValidator = getValidator(visitsQuerySchema, queryValidator)
export const visitsQueryResolver = resolve({})
