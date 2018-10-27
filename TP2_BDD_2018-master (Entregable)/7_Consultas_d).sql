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
)

select I.nombre, I.apellido, DT.pasaporte, DT.cant_paises cantidad_paises_como_entrenador
from DT_paises DT, Integrante I
where DT.cant_paises=(
	select MAX(cant_paises)
	from DT_paises
) AND DT.pasaporte=I.pasaporte