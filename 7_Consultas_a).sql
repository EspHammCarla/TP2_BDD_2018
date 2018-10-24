/*
	a) Listar los 5 países con mayor cantidad de finales jugadas.
*/

use DB_MundialesDeFutbol
go

create view Finales_jugadas
as(
	select P.nro, P.año_mundial, P.cod_pais_1, P.cod_pais_2
	from Partido P inner join Instancia I
		on P.id_instancia = I.id
	where I.descripcion = 'Final'
)go

create view Cant_finales_pais
as(
	select P.codigo, P.nombre, count(P.codigo) cant_finales
	from Pais P,Finales_jugadas FJ
	where P.codigo = FJ.cod_pais_1 or P.codigo = FJ.cod_pais_2
	group by P.codigo, P.nombre
	order by count(P.codigo) DESC
)go

select *
from Cant_finales_pais
where ROW_NUMBER() <= 5
go
