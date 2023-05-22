import AWS from 'aws-sdk';
import errors from '@feathersjs/errors';
import axios from 'axios';
import http from 'http';

const API_URL = 'https://api.countapi.xyz';
const TABLE_NAME = 'ton-dynamodb-visits-table';
const DYNAMODB_ID = 'visits';
const WEBSITE = 'ton.com.br';

const axiosInstance = axios.create({
  httpAgent: new http.Agent({ keepAlive: false }),
  timeout: 3000,
});

const dynamoDb = new AWS.DynamoDB.DocumentClient();

export class VisitsService {
  constructor(options) {
    this.options = options || {};
    this.initializeTable();
  }

  async initializeTable() {
    return this.saveVisitsToDatabase(0)
      .catch(this._handleError('Erro ao inicializar a tabela de visitas.'));
  }

  async find() {
    try {
      const response = await this._getApiResponse('/get');
      await this.saveVisitsToDatabase(response.data.value);
    } catch (error) {
      console.error('Erro ao obter total de visitas:', error);
    }

    return this.getSavedVisitsFromDatabase()
      .catch(this._handleError('Erro ao obter visitas da tabela local'));
  }

  async patch() {
    try {
      const response = await this._getApiResponse('/hit');
      await this.saveVisitsToDatabase(response.data.value);
    } catch (error) {
      console.error('Erro ao incrementar visitas:', error);
    }

    return this.getSavedVisitsFromDatabase()
      .catch(this._handleError('Erro ao obter visitas da tabela local'));
  }

  async getSavedVisitsFromDatabase() {
    try {
      const result = await dynamoDb.get({
        TableName: TABLE_NAME,
        Key: { id: DYNAMODB_ID },
      }).promise();
      
      if (result.Item) {
        return result.Item;
      } else {
        throw new errors.BadRequest('Visitas não encontradas');
      }
    } catch (error) {
      console.error('Erro ao obter visitas da tabela local:', error);
      throw new errors.BadRequest('Erro ao obter visitas da tabela local');
    }
  }

  async saveVisitsToDatabase(visitsTotal) {
    try {
      await dynamoDb.put({
        TableName: TABLE_NAME,
        Item: { 
          id: DYNAMODB_ID,
          website: WEBSITE,
          visits: visitsTotal,
        },
      }).promise();
    } catch (error) {
      console.error('Erro ao salvar visitas na tabela local:', error);
      throw new errors.BadRequest('Erro ao salvar visitas na tabela local');
    }
  }

  _getApiResponse(path) {
    return axiosInstance.get(`${API_URL}${path}/${WEBSITE}/visits`);
  }

  _handleError(message) {
    return error => {
      console.error(message, error);
      throw new errors.GeneralError(message);
    };
  }
}

export const getOptions = (app) => {
  return { app };
};