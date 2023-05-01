import { url_api } from '../config/routes/Paths';




const url_reporte1 				= url_api + `/MySql/R1`;
const url_reporte2 				= url_api + `/MySql/R2`;
const url_reporte3 				= url_api + `/MySql/R3`;
const url_reporte4 				= url_api + `/MySql/R4`;
const url_reporte5 				= url_api + `/MySql/R5`;
const url_reporte6 				= url_api + `/MySql/R6`;
const url_reporte7 				= url_api + `/MySql/R7`;
const url_reporte8 				= url_api + `/MySql/R8`;



export async function getReporte1(){

	return fetch(url_reporte1, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getReporte2(){

	return fetch(url_reporte2, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getReporte3(){
    
	return fetch(url_reporte3, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getReporte4(){
    
	return fetch(url_reporte4, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getReporte5(){
    
	return fetch(url_reporte5, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getReporte6(){
    
	return fetch(url_reporte6, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getReporte7(){
    
	return fetch(url_reporte7, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}

export async function getReporte8(){
    
	return fetch(url_reporte8, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}