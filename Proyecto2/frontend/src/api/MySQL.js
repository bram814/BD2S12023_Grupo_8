import { url_api } from '../config/routes/Paths';




const url_reporte1 				= url_api + `/MySql/R1`;



export async function getReporte1(){
    console.log(url_reporte1)
	return fetch(url_reporte1, {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type":"application/json"
		},
	})
}


/* POST */
// export async function sendPost(name){
// 	return fetch(url_registro, {
// 		method: "POST",
// 		headers: {
// 			Accept: "application/json",
// 			"Content-Type":"application/json"
// 		},
// 		body: JSON.stringify({
// 			Datos:{
// 		        nombre:name
// 		    }
// 		})
// 	})
// }