const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const LogActividadesSchema = new Schema({
    timestampx: { type: Date, required: true },
    actividad: { type: String, required: true },
    idPaciente: { type: Number, required: true },
    idHabitacion: { type: Number, required: true }
});

module.exports = mongoose.model('LogActividadesSchema', LogActividadesSchema);