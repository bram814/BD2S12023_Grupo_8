const { Router } = require('express');
const router = Router();
const mongoose = require('mongoose');
const csv = require('csvtojson');
const path = require('path');
const csvFilePath = path.join(__dirname, '../data/estudiantes.csv');
const PacienteSchema = require('../config/Schema');
const LogActividadesSchema = require('../config/LogActividades');
const LogHabitacionesSchema = require('../config/LogHabitaciones');
const HabitacionesSchema = require('../config/Habitaciones');

const uri = "mongodb+srv://adminbases:proyectobases2@cluster0.3rvknof.mongodb.net/Cluster0?retryWrites=true&w=majority";

mongoose.connect(uri)
.then(() => console.log('Conexión a la base de datos exitosa'))
.catch((err) => console.error(err));



router.get('/test', async (req, res) => {
    try {
        console.log("Conectando a MongoDB...")
    
    } catch (error) {
        console.error('Error en la conexión a MongoDB:', error);
        res.status(500).send('No se pudo conectar a MongoDB');
    }
});

// Ruta para cargar datos
router.post('/cargar', async (req, res) => {
    const {path} = req.body;
    try {
        csv()
        .fromFile(path)
        .then((jsonObj) => {
        LogActividadesSchema.insertMany(jsonObj)
            .then((result) => {
            console.log(`${result.length} documentos insertados.`);
            res.json(
                {
                    "status": "OK",
                    "message": "Datos cargados exitosamente"
                }
            )
            })
            .catch((err) => {
            console.log(err);
            
            });
        })
        .catch((err) => {
        console.log(err);
        
        });
      
    }
    catch (error) {
        console.error('Error en la conexión a MongoDB:', error);
        res.status(500).send('No se pudo conectar a MongoDB');
    }
});

// Ruta consulta 1 
router.get('/consulta1', async (req, res) => {
    try {
        const pacientes = await PacienteSchema.aggregate([
            {
                $project: {
                _id: 0,
                CATEGORIA: {
                    $switch: {
                    branches: [
                        { case: { $lt: ["$edad", 18] }, then: "PEDIATRICO" },
                        { case: { $and: [{ $gte: ["$edad", 18] }, { $lte: ["$edad", 60] }] }, then: "MEDIANA EDAD" }
                    ],
                    default: "GENIATRICO"
                    }
                },
                idPaciente: 1
                }
            },
            {
                $group: {
                _id: "$CATEGORIA",
                TOTAL_PACIENTES: { $sum: 1 }
                }
            },
            {
                $project: {
                _id: 0,
                CATEGORIA: "$_id",
                TOTAL_PACIENTES: 1
                }
            }
            ]);
            res.json(pacientes);
    } catch (error) {
        console.error('Error en la conexión a MongoDB:', error);
        res.status(500).send('No se pudo conectar a MongoDB');
    }
});

// Ruta consulta 2 
// Cantidad de pacientes que pasan por cada habitación
router.get('/consulta2', async (req, res) => {
    try {
        const pacientes = await LogActividadesSchema.aggregate([
            {
                $group: {
                _id: "$idHabitacion",
                CANTIDAD: { $sum: 1 }
                }
            },
            {
                $sort: { CANTIDAD: -1 }
            },
            {
                $limit: 15
            },
            {
                $lookup: {
                from: "habitacionesschemas",
                localField: "_id",
                foreignField: "idHabitacion",
                as: "habitacion"
                }
            },
            {
                $project: {
                _id: 0,
                HABITACION: { $arrayElemAt: ["$habitacion.habitacion", 0] },
                CANTIDAD: 1
                }
            }
            ]);
            res.json(pacientes);
    } catch (error) {
        console.error('Error en la conexión a MongoDB:', error);
        res.status(500).send('No se pudo conectar a MongoDB');
    }
});
// Ruta consulta 3

// Ruta consulta 4

// Ruta consulta 5

// Ruta consulta 6
router.get('/consulta6', async (req, res) => {
    try {
        const habitaciones = await LogActividadesSchema.aggregate([
            {
                $lookup: {
                from: "habitacionesschemas",
                localField: "idHabitacion",
                foreignField: "idHabitacion",
                as: "habitacion"
                }
            },
            {
                $unwind: "$habitacion"
            },
            {
                $group: {
                _id: "$idHabitacion",
                CANTIDAD: { $sum: 1 },
                HABITACION: { $first: "$habitacion.habitacion" }
                }
            },
            {
                $sort: { CANTIDAD: -1 }
            },
            {
                $limit: 5
            },
            {
                $project: {
                _id: 0,
                HABITACION: 1,
                CANTIDAD: 1
                }
            }
            ]);
            res.json(habitaciones);
    } catch (error) {
        console.error('Error en la conexión a MongoDB:', error);
        res.status(500).send('No se pudo conectar a MongoDB');
    }
});

// Ruta consulta 7
router.get('/consulta7', async (req, res) => {
    try {
        const habitaciones = await LogActividadesSchema.aggregate([
            {
                $lookup: {
                from: "habitacionesschemas",
                localField: "idHabitacion",
                foreignField: "idHabitacion",
                as: "habitacion"
                }
            },
            {
                $unwind: "$habitacion"
            },
            {
                $group: {
                _id: "$idHabitacion",
                CANTIDAD: { $sum: 1 },
                HABITACION: { $first: "$habitacion.habitacion" }
                }
            },
            {
                $sort: { CANTIDAD: 1 }
            },
            {
                $limit: 5
            },
            {
                $project: {
                _id: 0,
                HABITACION: 1,
                CANTIDAD: 1
                }
            }
            ]);
            res.json(habitaciones);
    } catch (error) {
        console.error('Error en la conexión a MongoDB:', error);
        res.status(500).send('No se pudo conectar a MongoDB');
    }
});


// Ruta consulta 8
// Dia con mas pacientes en la clinica
router.get('/consulta8', async (req, res) => {
    try {
        const pacientes = await PacienteSchema.aggregate([
            {
                $lookup: {
                from: "logactividadschemas",
                localField: "idPaciente",
                foreignField: "idPaciente",
                as: "log_actividad"
                }
            },
            {
                $unwind: "$log_actividad"
            },
            {
                $group: {
                _id: {
                    $dateToString: {
                    date: {
                        $dateFromString: {
                        dateString: "$log_actividad.timestampx"
                        }
                    }
                    }
                },
                CANTIDAD: { $sum: 1 }
                }
            },
            {
                $sort: {
                CANTIDAD: -1,
                _id: 1
                }
            },
            {
                $limit: 1
            },
            {
                $project: {
                _id: 0,
                DIA: "$_id",
                CANTIDAD: 1
                }
            }
            ]);
            res.json(pacientes);
    } catch (error) {
        console.error('Error en la conexión a MongoDB:', error);
        res.status(500).send('No se pudo conectar a MongoDB');
    }
});


module.exports = router;
