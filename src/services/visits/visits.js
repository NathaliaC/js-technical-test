import { hooks as schemaHooks } from '@feathersjs/schema';
import {
  visitsQueryValidator,
  visitsResolver,
  visitsExternalResolver,
  visitsQueryResolver
} from './visits.schema.js';
import { VisitsService, getOptions } from './visits.class.js';

export const visitsPath = 'visits';
export const visitsMethods = ['find', 'patch'];

export * from './visits.class.js';
export * from './visits.schema.js';

export const visits = (app) => {
  app.use(visitsPath, new VisitsService(getOptions(app)), {
    // A list of all methods this service exposes externally
    methods: visitsMethods,
    // You can add additional custom events to be sent to clients here
    events: []
  });
  // Initialize hooks
  app.service(visitsPath).hooks({
    around: {
      all: [schemaHooks.resolveExternal(visitsExternalResolver), schemaHooks.resolveResult(visitsResolver)],
      patch: []
    },
    before: {
      all: [schemaHooks.validateQuery(visitsQueryValidator), schemaHooks.resolveQuery(visitsQueryResolver)],
      patch: []
    },
    after: {
      all: []
    },
    error: {
      all: []
    }
  });
};
