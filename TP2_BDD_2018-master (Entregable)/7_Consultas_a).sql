/*
	a) Listar los 5 países con mayor cantidad de finales jugadas.
*/

use DB_MundialesDeFutbol
go

create view Finales_jugadas
as (
	select P.nro, P.año_mundial, P.cod_pais_1, P.cod_pais_2
	from Partido P inner join Instancia I
		on P.id_instancia = I.id
	where I.descripcion = 'Final'
)

select *
from Finales_jugadas

create view Cant_finales_pais
as(
	select P.codigo, P.nombre, count(P.codigo) cant_finales
	from Pais P,Finales_jugadas FJ
	where P.codigo = FJ.cod_pais_1 or P.codigo = FJ.cod_pais_2
	group by P.codigo, P.nombre

)
select *
from Cant_finales_pais

select top 5 *
from Cant_finales_pais
order by cant_finales DESC

