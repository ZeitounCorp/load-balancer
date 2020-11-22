// Utility to make http requests
const axios = require('axios').default;
require('dotenv').config();

const environnement = '__DEV__'; // || __PROD__

const baseURL = environnement === '__DEV__'
  ? 'http://35.180.27.64:3000'
  : 'http://real.server.address:port'

const BackEnd = axios.create({ 
  baseURL,
  headers: { 'API_KEY': process.env.API_KEY }
});

console.log(BackEnd);

exports.ControllerConf = BackEnd
