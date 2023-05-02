const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const LogHabitacionesSchema = new Schema({
    timestampx: { type: Date, required: true },
    statusx: { type: String, required: true },
    idHabitacion: { type: Number, required: true }
});

module.exports = mongoose.model('LogHabitacionesSchema', LogHabitacionesSchema);