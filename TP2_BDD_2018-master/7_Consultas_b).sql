/*
	b) Listar los 3 mayores goleadores de los mundiales (nombre, apellido, nacionalidad y
	  cantidad de goles).
*/

use DB_MundialesDeFutbol
go

create view Datos_jugador
as(
	select J.pasaporte, I.nombre, I.apellido, P.nombre as nacionalidad
	from Jugador J, Integrante I, Juega_en JE, Pais P
	where J.pasaporte = I.pasaporte
		and JE.pasaporte_jug = J.pasaporte
		and P.codigo = JE.cod_pais
)

create view Cant_goles_jugador
as(
	select DJ.nombre, DJ.apellido, DJ.nacionalidad, count(G.pasaporte_jug) cant_goles
	from Gol G, Datos_jugador DJ
	where G.pasaporte_jug = DJ.pasaporte
	group by DJ.nombre, DJ.apellido, DJ.nacionalidad
)

select top 3 *
from Cant_goles_jugador
order by cant_goles DESC
go
