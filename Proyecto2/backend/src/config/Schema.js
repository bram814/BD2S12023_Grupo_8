const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const PacienteSchema = new Schema({
    idPaciente: { type: Number, required: true },
    edad: { type: Number, required: true },
    genero: { type: String, required: true },
});

module.exports = mongoose.model('PacienteSchema', PacienteSchema);

