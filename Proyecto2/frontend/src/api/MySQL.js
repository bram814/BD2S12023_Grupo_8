import { url_api } from '../config/routes/Paths';




const url_reporte1 = url_api + `/MySql/R1`;
const url_reporte2 = url_api + `/MySql/R2`;
const url_reporte3 = url_api + `/MySql/R3`;
const url_reporte4 = url_api + `/MySql/R4`;
const url_reporte5 = url_api + `/MySql/R5`;
const url_reporte6 = url_api + `/MySql/R6`;
const url_reporte7 = url_api + `/MySql/R7`;
const url_reporte8 = url_api + `/MySql/R8`;
const url_habitacion = url_api + `/MySql/Habitacion`;
const url_paciente = url_api + `/MySql/Paciente`;
const url_insert_logActividad = url_api + `/MySql/LogActividad`;
const url_insert_logHabitacion = url_api + `/MySql/LogHabitacion`;


export async function getReporte1() {

	return fetch(url_reporte1, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json"
		},
	})
}

export async function getReporte2() {

	return fetch(url_reporte2, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json"
		},
	})
}

export async function getReporte3() {

	return fetch(url_reporte3, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json"
		},
	})
}

export async function getReporte4() {

	return fetch(url_reporte4, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json"
		},
	})
}

export async function getReporte5() {

	return fetch(url_reporte5, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json"
		},
	})
}

export async function getReporte6() {

	return fetch(url_reporte6, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json"
		},
	})
}

export async function getReporte7() {

	return fetch(url_reporte7, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json"
		},
	})
}

export async function getReporte8() {

	return fetch(url_reporte8, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json"
		},
	})
}

export async function getHabitacion() {

	return fetch(url_habitacion, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json"
		},
	})
}

export async function getPaciente() {

	return fetch(url_paciente, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json"
		},
	})
}

export async function addLogActividad(actividad, idPaciente, idHabitacion) {
	return fetch(url_insert_logActividad, {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify({
			actividad, idPaciente, idHabitacion
		}),
	});
}

export async function addLogHabitacion(statusx, idHabitacion) {
	return fetch(url_insert_logHabitacion, {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify({
			statusx, idHabitacion
		}),
	});
}
