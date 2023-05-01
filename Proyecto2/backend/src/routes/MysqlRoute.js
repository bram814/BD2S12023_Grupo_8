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


module.exports = router;
