const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const HabitacionesSchema = new Schema({
    idHabitacion: { type: Number, required: true },
    habitacion: { type: String, required: true }
});

module.exports = mongoose.model('HabitacionesSchema', HabitacionesSchema);