--- ============================================
---                 MYSQL
--- ============================================
-- consulta 1
SELECT CASE 
	   WHEN	p.edad <18 THEN 'PEDIATRICO'
	   WHEN p.edad BETWEEN 18 AND 60 THEN 'MEDIANA EDAD'
	   ELSE 'GENIATRICO' 
	   END AS CATEGORIA
, count(p.idPaciente) TOTAL_PACIENTES 
from PACIENTE p 
GROUP BY CATEGORIA;
-- consulta 2
select

     h.habitacion
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by h.habitacion
having count(la.idPaciente) > 0
order by CANTIDAD desc, h.habitacion ;

-- CONSULTA 3
select
    p.genero
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by p.genero
having count(la.idPaciente) > 0
order by p.genero ASC, CANTIDAD asc;

-- CONSULTA 4
select
    p.edad
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by  p.edad
having count(la.idPaciente) > 0
order by CANTIDAD DESC, p.edad
limit 5;

-- CONSULTA 5
select

    p.edad
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by  p.edad
having count(la.idPaciente) > 0
order by CANTIDAD asc, p.edad asc
limit 5;


-- CONSULTA 6
select

    h.habitacion
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by  h.habitacion
having count(la.idPaciente) > 0
order by CANTIDAD DESC, h.habitacion asc
limit 5;


-- CONSULTA 7
select

    h.habitacion
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by  h.habitacion
having count(la.idPaciente) > 0
order by CANTIDAD ASC, h.habitacion asc
limit 5;

-- CONSULTA 8
select

    date_format(STR_TO_DATE(la.timestampx, '%m/%d/%Y %h:%i:%s %p'), '%m/%d/%Y') dia
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by  dia
having count(la.idPaciente) > 0
order by CANTIDAD desc, dia asc
limit 1;

--- ============================================
---                 MONGODB
--- ============================================

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
