USE
DB_MundialesDeFutbol
GO


CREATE PROCEDURE sp_ObtenerDatosJugador(
@pasaporte INT
)
AS

	SELECT 
		pa.nombre pais_Mundial
		,ea.año_mundial 
		,i.nombre
		,i.apellido
		,jp.nro_camiseta
		,p.nombre pais_jugador
		,jp.es_titular 
	FROM Jugador j 
	JOIN Integrante i ON j.pasaporte = i.pasaporte
	JOIN Juega_en jp on j.pasaporte =jp.pasaporte_jug
	JOIN Pais p on jp.cod_pais = p.codigo
	JOIN Es_anfitrion_de ea ON jp.año_mundial =ea.año_mundial
	Join Pais pa on ea.cod_pais = pa.codigo
	WHERE j.pasaporte = @pasaporte

	EXEC sp_ObtenerDatosJugador 25485613