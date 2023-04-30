-- consulta 1
SELECT CASE 
	   WHEN	p.edad <18 THEN 'PEDIATRICO'
	   WHEN p.edad BETWEEN 18 AND 60 THEN 'MEDIANA EDAD'
	   ELSE 'GENIATRICO' 
	   END AS CATEGORIA
, count(p.idPaciente) TOTAL_PACIENTES 
from PACIENTE p 
GROUP BY CATEGORIA;
-- consulta 2
select

     h.habitacion
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by h.habitacion
having count(la.idPaciente) > 0
order by CANTIDAD desc, h.habitacion ;

-- CONSULTA 3
select
    p.genero
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by p.genero
having count(la.idPaciente) > 0
order by p.genero ASC, CANTIDAD asc;

-- CONSULTA 4
select
    p.edad
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by  p.edad
having count(la.idPaciente) > 0
order by CANTIDAD DESC, p.edad
limit 5;

-- CONSULTA 5
select

    p.edad
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by  p.edad
having count(la.idPaciente) > 0
order by CANTIDAD asc, p.edad asc
limit 5;


-- CONSULTA 6
select

    h.habitacion
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by  h.habitacion
having count(la.idPaciente) > 0
order by CANTIDAD DESC, h.habitacion asc
limit 5;


-- CONSULTA 7
select

    h.habitacion
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by  h.habitacion
having count(la.idPaciente) > 0
order by CANTIDAD ASC, h.habitacion asc
limit 5;

-- CONSULTA 8
select

    date_format(STR_TO_DATE(la.timestampx, '%m/%d/%Y %h:%i:%s %p'), '%m/%d/%Y') dia
    ,count(la.idPaciente) as CANTIDAD
from DB_G8.PACIENTE p
left join DB_G8.LOG_ACTIVIDAD la on p.idPaciente = la.idPaciente
left join DB_G8.HABITACION h on la.idHabitacion = h.idHabitacion
group by  dia
having count(la.idPaciente) > 0
order by CANTIDAD desc, dia asc
limit 1;

