/*
   ----------------------------------------------
   -             Conexión en MySql              -
   - Pool: Son un conjunto de conexiones que se -
   -            están reciclando                -
   ----------------------------------------------
*/  

const config = require('./env.js');
const mysqldb = require('mysql')

db = {
    host:       config.DB_HOST,
    user:       config.DB_USER,
    password:   config.DB_PASS,
    database:   config.DB_NAME,
    port:       config.DB_PORT
}

var pool = mysqldb.createPool(db);

/*** =============== POOL DE CONEXIONES =============== ***/
function open(insertQuery, data, callback){
    try {
        pool.getConnection(function (err, connection) {
            if (err){
                console.log("Error en la conexión, ", err)
                callback(err);

            } else {
            
                var query = mysqldb.format(insertQuery, data)

                connection.query(query, function (err2, result){
                    if (err2) {
                        console.log("Error en el query, ", err2)
                        callback(err2);
                    } else {
                        callback(result);
                    }

                    connection.release();
                });
            }
        });
    } catch (e) {
        console.log("Error ", e);
    }

}

exports.QUERY = open;
