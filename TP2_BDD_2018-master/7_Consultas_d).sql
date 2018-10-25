/*
	d) Liste los técnicos que más selecciones de países distintos han dirigido.
*/

use DB_MundialesDeFutbol
go

create view DT_paises
as(
	select DT.pasaporte, count(distinct E.cod_pais) cant_paises
	from Director_tecnico DT, Equipo E
	where DT.pasaporte = E.pasaporte_DT
	group by DT.pasaporte
)go

select pasaporte, MAX(cant_paises)
from DT_paises
