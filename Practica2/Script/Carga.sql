LOAD DATA LOCAL INFILE '/home/fmagdiel/Descargas/CARGAS/Paciente.csv' INTO TABLE PACIENTE FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/fmagdiel/Descargas/CARGAS/Habitaciones.csv' INTO TABLE HABITACION FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/fmagdiel/Descargas/CARGAS/LogHabitaciones.csv' INTO TABLE LOG_HABITACION FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/fmagdiel/Descargas/CARGAS/LogActividades1.csv' INTO TABLE LOG_ACTIVIDAD FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/fmagdiel/Descargas/CARGAS/LogActividades2.csv' INTO TABLE LOG_ACTIVIDAD FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;