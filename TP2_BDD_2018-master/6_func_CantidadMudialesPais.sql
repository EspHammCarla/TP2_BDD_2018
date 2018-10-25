USE 
DB_MundialesDeFutbol
GO

CREATE FUNCTION func_CantidadMudialesPais ( @codigo INT )
RETURNS INT
AS
BEGIN
	DECLARE @cantidad AS INT = 0

	SELECT @cantidad = COUNT(DISTINCT e.año_mundial)
	FROM Equipo e
	JOIN pais p ON e.cod_pais = p.codigo
	WHERE p.codigo = codigo

	RETURN @cantidad
END
GO

