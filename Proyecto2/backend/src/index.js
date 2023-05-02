const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const app = express();
app.use(cors());

// imports
const getMysqlRoute = require('./routes/MysqlRoute.js');
// mongodb
const getMongoDbRoute = require('./routes/MongoDBRoute.js');
// cassandra
// redis
const config = require('./config/env.js');

// settings
app.set('port', config.PORT);

// Middleware -- Intercambio de información entre aplicaciones.
app.use(morgan(config.NODE_ENV));               // Para desarrollador.
app.use(express.json());                        // Las peticiones las va a devolver en formato json.
app.use(express.urlencoded({extended:false}));  // Sirve para enviar fotos o videos, en este caso utilizaremos texto por eso es falso.

// Routes
app.use(getMysqlRoute);
// mongodb
app.use(getMongoDbRoute);
// cassandra
// redis

//Run
app.listen(app.get('port'), ()=>{
    console.log(`Server on Port ${config.PORT}`);
    console.log(`App Listening on http://${config.HOST}:${config.PORT}`);
 
});
