/*
	c) Liste los equipos con menor cantidad de goles de cada mundial.
*/

use DB_MundialesDeFutbol
go

create view Cant_goles_equipo
as(
	select E.cod_pais, E.año_mundial, count(G.pasaporte_jug) cant_goles
	from Gol G, Juega_en JE, Equipo E
	where G.pasaporte_jug = JE.pasaporte_jug
	group by E.cod_pais, E.año_mundial
)go

create view Menos_goles_mundial
as(
	select año_mundial, MIN(cant_goles) cant_goles
	from Cant_goles_equipo
	group by año_mundial
)go

select CGE.cod_pais, CGE.año_mundial
from Cant_goles_equipo CGE, Menos_goles_mundial MGM
where CGE.cant_goles = MGM.cant_goles