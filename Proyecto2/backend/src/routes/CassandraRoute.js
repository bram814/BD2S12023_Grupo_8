const express = require("express");
const router = express.Router();
const {consulta1, consulta2, consulta3,consulta4, consulta5, consulta6,consulta7} = require("../controllers/cassanda")

router.get('/R1', consulta1);
router.get('/R2', consulta2);
router.get('/R3', consulta3);
router.get('/R4', consulta4);
router.get('/R5', consulta5);
router.get('/R6', consulta6);
router.get('/R7', consulta7);
module.exports = router;   