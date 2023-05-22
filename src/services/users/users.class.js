import AWS from 'aws-sdk';
import errors from '@feathersjs/errors';
import { v4 as uuidv4 } from 'uuid';

const dynamoDb = new AWS.DynamoDB.DocumentClient();
const tableName = 'ton-dynamodb-users-table';

export class UsersService {
  constructor(options) {
    this.options = options || {};
  }

  async find(_params) {    
    const { query } = _params;
    const result = await dynamoDb.query({
      TableName: tableName,
      IndexName: "email-index", 
      KeyConditionExpression: "email = :email", 
      ExpressionAttributeValues: {
        ":email": query.email,
      },
    }).promise();
  
    return result.Items;
  }

  async get(uuid, _params) {
    const result = await dynamoDb.get({
      TableName: tableName,
      Key: { uuid }
    }).promise();

    if (result.Item) {
      return result.Item;
    } else {
      throw new errors.NotFound('Usuário não encontrado');
    }
  }

  async create(data, params) {
    const user = {
      uuid: uuidv4(),
      name: data.name,
      email: data.email,
      password: data.password
    };

    await dynamoDb.put({
      TableName: tableName,
      Item: user
    }).promise();

    return user;
  }
}

export const getOptions = (app) => {
  return { app }
}
