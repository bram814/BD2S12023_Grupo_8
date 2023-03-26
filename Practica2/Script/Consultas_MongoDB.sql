var DB_G8 = db.getSiblingDB('DB_G8');

// ------------------------------ Consulta 1 ----------------------------------------
DB_G8.Paciente.aggregate([
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

// -------------------------------- Consulta 2 ----------------------------------------
// Cantidad de pacientes que pasan por cada habitación
DB_G8.LogActividad.aggregate([
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
      from: "Habitacion",
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

// -------------------------------- Consulta 3 ----------------------------------------


// -------------------------------- Consulta 4 ----------------------------------------



// -------------------------------- Consulta 5 ----------------------------------------


// ------------------------------------ Consulta 6 ----------------------------------------
DB_G8.LogActividad.aggregate([
  {
    $lookup: {
      from: "Habitacion",
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

// ------------------------------------ Consulta 7 ----------------------------------------
DB_G8.LogActividad.aggregate([
  {
    $lookup: {
      from: "Habitacion",
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

// ------------------------------------ Consulta 8 ----------------------------------------


// Count
DB_G8.Paciente.count();
DB_G8.Habitacion.count();
DB_G8.LogHabitacion.count();
DB_G8.LogActividad.count();
