/*Escalable para Dashboard
Realizaci�n de la Normalizaci�n 3:
-Creaci�n de 3 nuevas tablas: Tabla TipoPokemOn, Tabla Generaciones, Tabla Legendario 
a partir de la Tabla Pokemon descargado del archivo CSV.
-Creaci�n de la tabla nueva PokemonPrincipal.*/

--1. TABLA TIPO POKEMON:
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TipoPokemon')
Begin
CREATE TABLE TipoPokemon(
    ID int IDENTITY(1,1) PRIMARY KEY,
    Tipo nvarchar (255) NULL,
	Descripcion nvarchar (255) null
	);
End;
GO
/*
sys.tables: Vista del sistema donde se encuentra informaci�n sobre cada tabla.
Begin y End: Agrupar instrucciones dentro del control de flujo.
GO: Dividde el Script, como un lote independiente del siguiente.
*/

--1.1 Creaci�n comando Drop Table, por si algo sale mal. 
Drop table TipoPokemon;
--1.2 Seleccionar Tabla TipoPokemon:
select *from dbo.TipoPokemon
-- dbo: Esquema predeterminado, buena pr�ctica.

--1.3 Inserci�n datos a la nueva tabla.
-- Insertar datos a columnas uno por uno.
INSERT INTO TipoPokemon ([Tipo Nombre], [Descripcion]) VALUES 
('Grass', 'Type Grass Pok�mon'),
('Fire', 'Type Fire Pok�mon'),
('Water', 'Type Water Pok�mon'),
('Electric', 'Type Electric Pok�mon'),
('Psychic', 'Type Psychic Pok�mon'),
('Dragon', 'Type Dragon Pok�mon');

-- Inserci�n de valores �nicos de las columnas [Tipo 1] y [Tipo 2], de la Tabla "Pokemon" en la Tabla "TipoPokemon"
INSERT INTO TipoPokemon (Tipo, Descripcion)
SELECT DISTINCT Tipo, CONCAT('Type ', Tipo, ' Pok�mon') AS Descripcion
FROM (
    SELECT [Tipo 1] AS Tipo FROM Pokemon WHERE [Tipo 1] IS NOT NULL
    UNION
    SELECT [Tipo 2] AS Tipo FROM Pokemon WHERE [Tipo 2] IS NOT NULL
) AS TiposUnicos;
--La creaci�n de esta tabla me permitir� consolidar los tipos de pokemon en una sola tabla que me seriva de referencia. 
GO

--2. TABLA GENERACIONES:
IF NOT EXISTS (SELECT *FROM sys.tables Where name = 'Generacion')
BEGIN
CREATE TABLE Generacion(
    GeneracionID int IDENTITY(1,1) PRIMARY KEY,
    NumeroGeneracion int NOT NULL,
    Descripcion nvarchar (255) NULL
);
END;
--2.1 Creaci�n comando Drop Table, por si algo sale mal al crear la tabla.
Drop table dbo.Generacion;
--2.2 Seleccionar Tabla Generacion:
SELECT *FROM dbo.Generacion;
go
-- 2.3 Inserci�n de datos a la nueva tabla.
-- Insertar datos a las columnas uno por uno.
INSERT INTO Generacion ([NumeroGeneracion], [Descripcion]) VALUES 
(1, 'Generacion 1'),
(2, 'Generacion 2'),
(3, 'Generacion 3'),
(4, 'Generacion 4'),
(5, 'Generacion 5'),
(6, 'Generacion 6');

--Insertar valores �nicos 
Insert into Generacion (NumeroGeneracion, Descripcion)
SELECT DISTINCT 
				Generation, 
				'Generacion ' + CAST([Generation] AS nvarchar(250)) AS Descripcion
FROM dbo.Pokemon;
GO

--3. Creaci�n Tabla Legendario
IF NOT EXISTS (SELECT*FROM sys.tables where name = 'Legendario')
BEGIN
CREATE TABLE Legendario(
	LegendarioID INT Identity(1,1) PRIMARY KEY,
	Descripcion nvarchar(255) null
	);
END;
--3.1 Creaci�n Drop Table:
DROP TABLE dbo.Legendario;
--3.2 Seleccionar Tabla Legendario:
SELECT*FROM Legendario;
--3.3 Inserci�n de datos a la nueva tabla.
INSERT INTO Legendario (Descripcion)
SELECT DISTINCT
    CASE
        WHEN Legendary = 'TRUE' THEN 'Legendario'
        ELSE 'No Legendario'
    END AS Descripcion
FROM dbo.Pokemon;
GO
--4. Creaci�n Nueva Tabla PokemonPrincipal:
IF NOT EXISTS (SELECT*FROM sys.tables where name = 'PokemonPrincipal')
BEGIN
CREATE TABLE PokemonPrincipal(
	PokemonID INT IDENTITY(1,1) PRIMARY KEY,
	Orden float null,
	Nombre nvarchar (255) null,
	[Tipo1 ID] INT  NULL,	
	[Tipo2 ID] INT  NULL,
	Total float NULL,
	HP Float null,
	Ataque float null,
	Defensa float null,
	[Ataque especial] float null,
	[Defensa especial] float null,
	Velocidad float null,
	GeneracionID INT null, 
	LegendarioID INT null,
	CONSTRAINT FK_Tipo1 FOREIGN KEY ([Tipo1 ID])
	REFERENCES TipoPokemon(ID), 
	CONSTRAINT FK_Tipo2 FOREIGN KEY([Tipo2 ID])
	REFERENCES TipoPokemon(ID),
	CONSTRAINT FK_GeneracionID FOREIGN KEY(GeneracionID)
	REFERENCES Generacion(GeneracionID),
	CONSTRAINT FK_LegendarioID FOREIGN KEY(LegendarioID)
	REFERENCES Legendario(LegendarioID)
);
END;
--4.1 Creaci�n DROP TABLE:
DROP TABLE PokemonPrincipal;
--4.2 Selecci�n Tabla:
SELECT *FROM PokemonPrincipal;

--4.3 Insertar datos a la tabla creada:
INSERT INTO PokemonPrincipal(
	Orden,	
	Nombre,
	[Tipo1 ID],
	[Tipo2 ID],
	Total,
	HP,	
	Ataque,
	Defensa,
	[Ataque especial],
	[Defensa especial],
	Velocidad,
	GeneracionID,
	LegendarioID)
SELECT 
	Orden,
    [Name] AS Nombre,
    TP1.ID AS [Tipo1 ID],
    TP2.ID AS [Tipo2 ID],
    Total,
    HP,
    Attack AS Ataque,
    Defense AS Defensa,
    [Sp# Atk] AS [Ataque especial],
    [Sp# Def] AS [Defensa especial],
    Speed AS Velocidad,
    G.GeneracionID,
    L.LegendarioID
FROM Pokemon P
LEFT JOIN TipoPokemon TP1 ON P.[Tipo 1] = TP1.Tipo
LEFT JOIN TipoPokemon TP2 ON P.[Tipo 2] = TP2.Tipo
LEFT JOIN Generacion G ON P.Generation = G.NumeroGeneracion
LEFT JOIN Legendario L ON 
	CASE 
		WHEN P.Legendary = 'TRUE' THEN 'Legendario' 
		ELSE 'No Legendario' 
	END = L.Descripcion;

