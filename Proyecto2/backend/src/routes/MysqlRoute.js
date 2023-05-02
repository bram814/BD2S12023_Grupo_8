const { Router } = require('express');
const router = Router();
const DB_MYSQL = require('../config/Mysql');


// req : request  ----- res : responseve
router.get('/', (req, res) => {

    res.status(200).json({
        msg:"Bienvenido - [BD2]Proyecto"
    });
});

router.get('/users', (req, res) => {
    sql = `
        SELECT * FROM USUARIO USUARIO;
    `;
    var result = DB_MYSQL.QUERY(sql, [], (result) => {
        res.status(200).json(result)
    });

});

router.get('/MySql/R1', (req, res) =>{
    try {
        var sql = `SELECT 
                    CASE 
                        WHEN	p.edad <18 THEN 'PEDIATRICO'
                        WHEN p.edad BETWEEN 18 AND 60 THEN 'MEDIANA EDAD'
                        ELSE 'GENIATRICO' 
                    END AS CATEGORIA,
                    COUNT(p.idPaciente) TOTAL_PACIENTES 
                   FROM PACIENTE p 
                   GROUP BY CATEGORIA;`;

        var data = [];

        DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json(result);
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});



router.get('/MySql/R2', (req, res) =>{
    try {
        var sql = `select
                    h.habitacion
                ,count(la.idPaciente) as CANTIDAD
            from DB_G8.PACIENTE p
            left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
            left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
            group by h.habitacion
            having count(la.idPaciente) > 0
            order by CANTIDAD desc, h.habitacion ;`;

        var data = [];

        DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json(result);
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});




router.get('/MySql/R3', (req, res) =>{
    try {
        var sql = `select
                    p.genero
                    ,count(la.idPaciente) as CANTIDAD
                from DB_G8.PACIENTE p
                left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
                left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
                group by p.genero
                having count(la.idPaciente) > 0
                order by p.genero ASC, CANTIDAD asc;`;

        var data = [];

        DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json(result);
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});



router.get('/MySql/R4', (req, res) =>{
    try {
        var sql = `select
                p.edad
                ,count(la.idPaciente) as CANTIDAD
            from DB_G8.PACIENTE p
            left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
            left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
            group by  p.edad
            having count(la.idPaciente) > 0
            order by CANTIDAD DESC, p.edad
            limit 5;`;

        var data = [];

        DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json(result);
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});

router.get('/MySql/R5', (req, res) =>{
    try {
        var sql = `select
                        p.edad
                        ,count(la.idPaciente) as CANTIDAD
                    from DB_G8.PACIENTE p
                    left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
                    left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
                    group by  p.edad
                    having count(la.idPaciente) > 0
                    order by CANTIDAD asc, p.edad asc
                    limit 5;`;

        var data = [];

        DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json(result);
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});

router.get('/MySql/R6', (req, res) =>{
    try {
        var sql = `select
                        h.habitacion
                        ,count(la.idPaciente) as CANTIDAD
                    from DB_G8.PACIENTE p
                    left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
                    left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
                    group by  h.habitacion
                    having count(la.idPaciente) > 0
                    order by CANTIDAD DESC, h.habitacion asc
                    limit 5;`;

        var data = [];

        DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json(result);
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});

router.get('/MySql/R7', (req, res) =>{
    try {
        var sql = `select
                        h.habitacion
                        ,count(la.idPaciente) as CANTIDAD
                    from DB_G8.PACIENTE p
                    left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
                    left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
                    group by  h.habitacion
                    having count(la.idPaciente) > 0
                    order by CANTIDAD ASC, h.habitacion asc
                    limit 5;`;

        var data = [];

        DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json(result);
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});

router.get('/MySql/R8', (req, res) =>{
    try {
        var sql = `select
                    date_format(STR_TO_DATE(la.timestampx, '%m/%d/%Y %h:%i:%s %p'), '%m/%d/%Y') dia
                    ,count(la.idPaciente) as CANTIDAD
                from DB_G8.PACIENTE p
                left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
                left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
                group by  dia
                having count(la.idPaciente) > 0
                order by CANTIDAD desc, dia asc
                limit 1;
                `;

        var data = [];

        DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json(result);
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});


router.get('/MySql/Paciente', (req, res) =>{
    try {
        var sql = `select * from DB_G8.PACIENTE;`;

        var data = [];

        DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json(result);
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});


router.get('/MySql/Habitacion', (req, res) =>{
    try {
        var sql = `select * from DB_G8.HABITACION;`;

        var data = [];

        DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json(result);
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});

module.exports = router;
