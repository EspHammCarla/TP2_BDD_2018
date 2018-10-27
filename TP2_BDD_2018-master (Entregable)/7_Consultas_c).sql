/*
	c) Liste los equipos con menor cantidad de goles de cada mundial.
*/

use DB_MundialesDeFutbol
go

create view Cant_goles_equipo
as(
	select P.nombre, JE.a�o_mundial, count(G.pasaporte_jug) cant_goles
	from Gol G, Juega_en JE, Pais P
	where G.pasaporte_jug = JE.pasaporte_jug AND G.a�o_mundial = JE.a�o_mundial AND P.codigo = JE.cod_pais
	group by JE.cod_pais, JE.a�o_mundial, P.nombre
)

create view Menos_goles_mundial
as(
	select a�o_mundial, MIN(cant_goles) cant_goles
	from Cant_goles_equipo
	group by a�o_mundial
)

select CGE.nombre, CGE.a�o_mundial
from Cant_goles_equipo CGE, Menos_goles_mundial MGM
where CGE.cant_goles = MGM.cant_goles AND CGE.a�o_mundial = MGM.a�o_mundial