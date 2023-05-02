import { url_api } from '../config/routes/Paths';


const url_reporte1 				= url_api + `/consulta1`;
const url_reporte2 				= url_api + `/consulta2`;
const url_reporte3 				= url_api + `/consulta3`;
const url_reporte4 				= url_api + `/consulta4`;
const url_reporte5 				= url_api + `/consulta5`;
const url_reporte6 				= url_api + `/consulta6`;
const url_reporte7 				= url_api + `/consulta7`;
const url_reporte8 				= url_api + `/consulta8`;

export async function getMongoDBReporte1(){

	return fetch(url_reporte1, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getMongoDBReporte2(){

	return fetch(url_reporte2, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getMongoDBReporte3(){

	return fetch(url_reporte3, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getMongoDBReporte4(){

	return fetch(url_reporte4, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getMongoDBReporte5(){

	return fetch(url_reporte5, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getMongoDBReporte6(){
    
	return fetch(url_reporte6, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getMongoDBReporte7(){
    
	return fetch(url_reporte7, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getMongoDBReporte8(){
    
	return fetch(url_reporte8, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}
