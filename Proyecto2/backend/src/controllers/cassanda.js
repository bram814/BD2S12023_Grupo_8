const cassandra = require('cassandra-driver');
const auth = new cassandra.auth.PlainTextAuthProvider('cassandra', 'cassandra');
const client = new cassandra.Client({
    contactPoints: ['34.125.1.220'],
    localDataCenter: 'datacenter1',
    authProvider: auth,
    protocolOptions: { port: 9042 },
    keyspace: 'proyecto',
    socketOptions: { readTimeout: 0 }
});

async function executeC(query) {
    const options = { prepare: true , fetchSize: 1000000 };
    return await (await client.execute(query,"",options))
}

const consulta1 = async (req, res) => {
    try {
        let pacientes = [
            { Categoria: "PEDIATRICO", Total_paciente: await (await executeC(`select count(*) from Paciente where edad < 18 ALLOW FILTERING`)).rows[0]['count'].low },
            { Categoria: "MEDIANA EDAD", Total_paciente: await (await executeC(`select count(*) from Paciente where edad >= 18 ALLOW FILTERING`)).rows[0]['count'].low },
            { Categoria: "GERIATRICO", Total_paciente: await (await executeC(`select count(*) from Paciente where edad > 64 ALLOW FILTERING`)).rows[0]['count'].low }
        ];     
        let json = JSON.stringify(pacientes);

        res.status(200).json({
            'data': json
        }); 
    } catch (error) {
        res.status(200).json({ 'success': false, 'message': 'Existe un error inesperado' })
    }
    
}

const consulta2 = async (req, res) => {
    try {
        let pacientes = [
            { Categoria: "PEDIATRICO", Total_paciente: await (await executeC(`select count(*) from Paciente where edad < 18 ALLOW FILTERING`)).rows[0]['count'].low },
            { Categoria: "MEDIANA EDAD", Total_paciente: await (await executeC(`select count(*) from Paciente where edad >= 18 ALLOW FILTERING`)).rows[0]['count'].low },
            { Categoria: "GERIATRICO", Total_paciente: await (await executeC(`select count(*) from Paciente where edad > 64 ALLOW FILTERING`)).rows[0]['count'].low }
        ];     
        let json = JSON.stringify(pacientes);

        res.status(200).json({
            'data': json
        }); 
    } catch (error) {
        res.status(200).json({ 'success': false, 'message': 'Existe un error inesperado' })
    }
    
}
const consulta3 = async (req, res) => {
    try {
        let pacientes = [
            { GENERO: "FEMENINO", Total_paciente: await (await executeC(`select count(*) from Paciente where genero ='Femenino' ALLOW FILTERING`)).rows[0]['count'].low },
            { GENERO: "MASCULINO", Total_paciente: await (await executeC(`select count(*) from Paciente where genero ='Masculino' ALLOW FILTERING`)).rows[0]['count'].low },
            { GENERO: "OTRO", Total_paciente: await (await executeC(`select count(*) from Paciente where genero ='Otro' ALLOW FILTERING`)).rows[0]['count'].low }
        ];     
        let json = JSON.stringify(pacientes);

        res.status(200).json({
            'data': json
        }); 
    } catch (error) {
        res.status(200).json({ 'success': false, 'message': 'Existe un error inesperado' })
    }
    
}

const consulta4 = async (req, res) => {
    try {
        let consulta = (await executeC(`SELECT edad FROM paciente`)).rows;
        let cantidadArray = consulta.map(obj => obj.edad);
        
        let edad_frecuencia = cantidadArray.reduce((obj, valor) => {
          if (valor in obj) {
            obj[valor]++;
          } else {
            obj[valor] = 1;
          }
          return obj;
        }, {});
        
        let frecuencia_ordenada = Object.entries(edad_frecuencia).sort(
            (a, b) => b[1] - a[1]
          );
          
          console.log(frecuencia_ordenada);
        let pacientes = [
             { edad: frecuencia_ordenada[0][0],count:frecuencia_ordenada[0][1]},
             { edad: frecuencia_ordenada[1][0],count:frecuencia_ordenada[1][1]},
             { edad: frecuencia_ordenada[2][0],count:frecuencia_ordenada[2][1]},
             { edad: frecuencia_ordenada[3][0],count:frecuencia_ordenada[3][1]},
             { edad: frecuencia_ordenada[4][0],count:frecuencia_ordenada[4][1]},
        ];     
        let json = JSON.stringify(pacientes);

        res.status(200).json({
            'data': json
        }); 
    } catch (error) {
        res.status(200).json({ 'success': false, 'message': 'Existe un error inesperado',error })
    }
    
}

const consulta5 = async (req, res) => {
    try {
        let consulta = (await executeC(`SELECT edad FROM paciente`)).rows;
        let cantidadArray = consulta.map(obj => obj.edad);
        
        let edad_frecuencia = cantidadArray.reduce((obj, valor) => {
          if (valor in obj) {
            obj[valor]++;
          } else {
            obj[valor] = 1;
          }
          return obj;
        }, {});
        
        let frecuencia_ordenada = Object.entries(edad_frecuencia).sort(
            (a, b) => (a[1] - b[1]) || (a[0] - b[0])
          );
          
        console.log(frecuencia_ordenada);
        let pacientes = [
             { edad: frecuencia_ordenada[0][0],count:frecuencia_ordenada[0][1]},
             { edad: frecuencia_ordenada[1][0],count:frecuencia_ordenada[1][1]},
             { edad: frecuencia_ordenada[2][0],count:frecuencia_ordenada[2][1]},
             { edad: frecuencia_ordenada[3][0],count:frecuencia_ordenada[3][1]},
             { edad: frecuencia_ordenada[4][0],count:frecuencia_ordenada[4][1]},
        ];     
        let json = JSON.stringify(pacientes);

        res.status(200).json({
            'data': json
        }); 
    } catch (error) {
        res.status(200).json({ 'success': false, 'message': 'Existe un error inesperado',error })
    }
    
}

const consulta6 = async (req, res) => {
    try {
        let consulta = (await executeC(`SELECT * FROM logActividad`)).rows;
       
        let cantidadArray = consulta.map(obj => obj.idhabitacion);
        
        let edad_frecuencia = cantidadArray.reduce((obj, valor) => {
          if (valor in obj) {
            obj[valor]++;
          } else {
            obj[valor] = 1;
          }
          return obj;
        }, {});
        
        let frecuencia_ordenada = Object.entries(edad_frecuencia).sort(
            (a, b) => b[1] - a[1]
          );
        
        frecuencia_ordenada=frecuencia_ordenada.slice(0,5)

        let r=[]
        for(let i=0; i<frecuencia_ordenada.length; i++){
            r.push((await executeC(`SELECT * FROM habitacion where idhabitacion=`+frecuencia_ordenada[i][0])).rows)
        }
        
        console.log(r);
        let habitaciones = [
            { idhabitacion: r[0][0],habitacion:r[0][1],count:frecuencia_ordenada[0][1]},
            { idhabitacion: r[1][0],habitacion:r[1][1],count:frecuencia_ordenada[0][1]},
            { idhabitacion: r[2][0],habitacion:r[2][1],count:frecuencia_ordenada[0][1]},
            { idhabitacion: r[3][0],habitacion:r[3][1],count:frecuencia_ordenada[0][1]},
            { idhabitacion: r[4][0],habitacion:r[4][1],count:frecuencia_ordenada[0][1]},
       ];       
        let json = JSON.stringify(habitaciones);

        res.status(200).json({
            'data': json
        }); 
    } catch (error) {
        res.status(200).json({ 'success': false, 'message': 'Existe un error inesperado',error })
    }
    
}

const consulta7 = async (req, res) => {
    try {
        let consulta = (await executeC(`SELECT * FROM logActividad`)).rows;
       
        let cantidadArray = consulta.map(obj => obj.idhabitacion);
        
        let edad_frecuencia = cantidadArray.reduce((obj, valor) => {
          if (valor in obj) {
            obj[valor]++;
          } else {
            obj[valor] = 1;
          }
          return obj;
        }, {});
        
        let frecuencia_ordenada = Object.entries(edad_frecuencia).sort(
            (a, b) => (a[1] - b[1]) || (a[0] - b[0])
          );
        
        frecuencia_ordenada=frecuencia_ordenada.slice(0,5)

        let r=[]
        for(let i=0; i<frecuencia_ordenada.length; i++){
            r.push((await executeC(`SELECT * FROM habitacion where idhabitacion=`+frecuencia_ordenada[i][0])).rows)
        }
        
        console.log(r);
        let habitaciones = [
             { idhabitacion: r[0][0],habitacion:r[0][1],count:frecuencia_ordenada[0][1]},
             { idhabitacion: r[1][0],habitacion:r[1][1],count:frecuencia_ordenada[0][1]},
             { idhabitacion: r[2][0],habitacion:r[2][1],count:frecuencia_ordenada[0][1]},
             { idhabitacion: r[3][0],habitacion:r[3][1],count:frecuencia_ordenada[0][1]},
             { idhabitacion: r[4][0],habitacion:r[4][1],count:frecuencia_ordenada[0][1]},
        ];     
        let json = JSON.stringify(habitaciones);

        res.status(200).json({
            'data': json
        }); 
    } catch (error) {
        res.status(200).json({ 'success': false, 'message': 'Existe un error inesperado',error })
    }
    
}
//cassandraQuery()
module.exports = { consulta1,consulta2,consulta3,consulta4, consulta5, consulta6, consulta7};