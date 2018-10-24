USE 
DB_MundialesDeFutbol
GO 
/*AGREGA EL CAMPO ACTIVO*/
ALTER TABLE Pais ADD activo BIT
GO
/*PONE TODOS LOS PAISES COMO ACTIVOS*/
UPDATE Pais
set activo = 1 

GO
/*CREA TRIGGER PARA DESACTIVAR PAIS EN LUGAR DE BORRAR*/
CREATE TRIGGER tgr_NoElimiar
ON Pais 
INSTEAD OF DELETE
AS 
BEGIN 
	UPDATE p
	set activo = 0 
	FROM pais p 
	JOIN deleted d ON p.codigo = d.codigo
END

