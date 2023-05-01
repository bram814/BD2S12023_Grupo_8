/* PUBLIC */
export const HOME 	   = '/';
export const LOGIN     = '/login';
export const REGISTER  = '/register';

/* PRIVATE - USER */
export const DASHBOARD = '/dashboard';
export const CAR       = '/dashboard/data';
export const GRAPH     = '/dashboard/graph';

/* BACKEND */
export const APP_BACKEND = "localhost"
export const PORT_BACKEND = "5000"

/* API MYSQL */
export const url_api = `http://` + APP_BACKEND + `:`+ PORT_BACKEND;