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

router.post('/logout', (req, res) =>{
    try {
        var sql = `UPDATE USUARIO 
                    SET USUARIO.state = 0
                    WHERE USUARIO.id_user = ?;`;

        var data = [req.body.id_user];

        var result = DB_MYSQL.QUERY(sql, data, (result) => {
            res.status(200).json("OK");
        });

    } catch (e) {
        res.status(402).json("Error");
    }
});


module.exports = router;
