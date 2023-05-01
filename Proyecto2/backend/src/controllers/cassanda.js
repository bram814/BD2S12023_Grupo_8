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
        // Obtener los datos de Cassandra
        let consulta = (await executeC(`SELECT * FROM logActividad`)).rows;

        // Objeto para almacenar los conteos por habitación
        let conteos = {};

        // Iterar por las filas de la consulta
        for (let fila of consulta) {
        // Obtener el id de la habitación y el id del paciente
            let idhabitacion = fila.idhabitacion;
            let idpaciente = fila.idpaciente;

            // Verificar si la habitación ya ha sido contada
            if (idhabitacion in conteos) {
                // Si la habitación ya ha sido contada, incrementar el conteo de pacientes
                conteos[idhabitacion]++;
            } else {
                // Si la habitación no ha sido contada, iniciar el conteo con 1
                conteos[idhabitacion] = 1;
            }
        }

     
        let r=[]
        for(let idhabitacion in conteos){
            r.push((await executeC(`SELECT * FROM habitacion where idhabitacion=`+ idhabitacion)).rows)
        }

        console.log(r)
        let habitaciones = [
            { habitacion:r[0][0].habitacion,count:conteos[1]},
            { habitacion:r[1][0].habitacion,count:conteos[2]},
            { habitacion:r[2][0].habitacion,count:conteos[3]},
            { habitacion:r[3][0].habitacion,count:conteos[4]},
            { habitacion:r[4][0].habitacion,count:conteos[5]},
            { habitacion:r[5][0].habitacion,count:conteos[6]},
            { habitacion:r[6][0].habitacion,count:conteos[7]},
            { habitacion:r[7][0].habitacion,count:conteos[8]},
            { habitacion:r[8][0].habitacion,count:conteos[9]},
            { habitacion:r[9][0].habitacion,count:conteos[10]},
            { habitacion:r[10][0].habitacion,count:conteos[11]},
            { habitacion:r[11][0].habitacion,count:conteos[12]},
            { habitacion:r[12][0].habitacion,count:conteos[13]},
            { habitacion:r[13][0].habitacion,count:conteos[14]},
            { habitacion:r[14][0].habitacion,count:conteos[15]},
       ];       
        let json = JSON.stringify(habitaciones);

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
        console.log(consulta);
       
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
        
        
        let habitaciones = [
            { habitacion:r[0][0].habitacion,count:frecuencia_ordenada[0][1]},
            { habitacion:r[1][0].habitacion,count:frecuencia_ordenada[1][1]},
            { habitacion:r[2][0].habitacion,count:frecuencia_ordenada[2][1]},
            { habitacion:r[3][0].habitacion,count:frecuencia_ordenada[3][1]},
            { habitacion:r[4][0].habitacion,count:frecuencia_ordenada[4][1]},
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
            { habitacion:r[0][0].habitacion,count:frecuencia_ordenada[0][1]},
            { habitacion:r[1][0].habitacion,count:frecuencia_ordenada[1][1]},
            { habitacion:r[2][0].habitacion,count:frecuencia_ordenada[2][1]},
            { habitacion:r[3][0].habitacion,count:frecuencia_ordenada[3][1]},
            { habitacion:r[4][0].habitacion,count:frecuencia_ordenada[4][1]},
       ];        
        let json = JSON.stringify(habitaciones);

        res.status(200).json({
            'data': json
        }); 
    } catch (error) {
        res.status(200).json({ 'success': false, 'message': 'Existe un error inesperado',error })
    }
    
}

const insertLogHabitacion = async (req, res) => {
    const info = req.body;

    try {
        const fecha = new Date();
        const dia = fecha.getDate();
        const mes = fecha.getMonth() + 1; // Los meses comienzan desde 0
        const anio = fecha.getFullYear();
        const hora = fecha.getHours();
        const minutos = fecha.getMinutes();
        const segundos = fecha.getSeconds();
        const min = 34619;
        const max = 100000; // Puedes ajustar este valor para obtener un número aleatorio mayor o menor.

        const numAleatorio = Math.floor(Math.random() * (max - min + 1)) + min;
        const fechaActual = `${dia}/${mes}/${anio} ${hora}:${minutos}:${segundos}`;
        let consulta = (await executeC(`INSERT INTO logHabitacion(timestampx, statusx, idhabitacion, id) values('${fechaActual}','${info.statusx}',${info.idhabitacion},${numAleatorio}) `)).rows;
        res.status(200).json({
            'data': consulta
        }); 
    } catch (error) {
        res.status(200).json({ 'success': false, 'message': 'Existe un error inesperado',error })
    }
    
}

const insertLogActividad = async (req, res) => {
    const info = req.body;

    try {
        const fecha = new Date();
        const dia = fecha.getDate();
        const mes = fecha.getMonth() + 1; // Los meses comienzan desde 0
        const anio = fecha.getFullYear();
        const hora = fecha.getHours();
        const minutos = fecha.getMinutes();
        const segundos = fecha.getSeconds();
        const min = 300000;
        const max = 500000; // Puedes ajustar este valor para obtener un número aleatorio mayor o menor.

        const numAleatorio = Math.floor(Math.random() * (max - min + 1)) + min;
        const fechaActual = `${dia}/${mes}/${anio} ${hora}:${minutos}:${segundos}`;
        let consulta = (await executeC(`INSERT INTO logActividad(timestampx, actividad,idpaciente, idhabitacion, id) values('${fechaActual}','${info.actividad}',${info.idpaciente},${info.idhabitacion},${numAleatorio}) `)).rows;
        res.status(200).json({
            'data': consulta
        }); 
    } catch (error) {
        res.status(200).json({ 'success': false, 'message': 'Existe un error inesperado',error })
    }
    
}

//cassandraQuery()
module.exports = { consulta1,consulta2,consulta3,consulta4, consulta5, consulta6, consulta7,insertLogHabitacion,insertLogActividad};