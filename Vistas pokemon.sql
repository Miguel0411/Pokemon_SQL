--Tabla creada POKEMON
CREATE TABLE [dbo].[Pokemon](
	[Orden] [float] NULL,
	[Name] [nvarchar](255) NULL,
	[Tipo 1] [nvarchar](255) NULL,
	[Tipo 2] [nvarchar](255) NULL,
	[Total] [float] NULL,
	[HP] [float] NULL,
	[Attack] [float] NULL,
	[Defense] [float] NULL,
	[Sp# Atk] [float] NULL,
	[Sp# Def] [float] NULL,
	[Speed] [float] NULL,
	[Generation] [float] NULL,
	[Legendary] [nvarchar](255) NULL
) ON [PRIMARY]
GO
------------------------------------------------------------------------------------------------------------------------------------------------------------
--USO DE LA TABLA POKEMON:
USE Pokemon
GO
select *from Pokemon
--==========================================================================================================================================================
--LISTAS POR CARACTERISTICAS: 

--Encontrar La lista de pokemon 'Grass'
IF OBJECT_ID('V_Grass', 'V') IS NOT NULL
DROP VIEW V_Grass;
GO
CREATE VIEW V_Grass AS 
select Orden, Name, [Tipo 1],[Tipo 2], Attack,Defense,Generation
FROM Pokemon
Where [Tipo 1] = 'Grass' OR [Tipo 2] = 'Grass';

--Encontrar Lista pokemon tipo  'Fire'
IF OBJECT_ID('V_Fire', 'V') IS NOT NULL
DROP VIEW V_Fire;
GO
CREATE VIEW V_Fire AS 
select Orden, Name, [Tipo 1], [Tipo 2],Attack,Defense,Generation
FROM Pokemon
Where [Tipo 1] = 'Fire' OR [Tipo 2] = 'Fire';


--Encontrar Lista Pokemon tipo 'Water'
IF OBJECT_ID('V_Water', 'V') IS NOT NULL
DROP VIEW V_Water;
GO
CREATE VIEW V_Water AS 
select Orden, Name, [Tipo 1],[Tipo 2], Attack,Defense,Generation
FROM Pokemon
Where [Tipo 1] = 'Water' OR [Tipo 2] = 'Water';

--Encontrar lista de Pokemon Legendary
IF OBJECT_ID('V_Legendary', 'V') IS NOT NULL
DROP VIEW V_Legendary;
GO

CREATE VIEW V_Legendary As
SELECT Orden, Name, [Tipo 1], [Tipo 2],Attack, Defense
FROM Pokemon
where Legendary NOT LIKE  '%FALSE%';

--lista de Pokemon Legendario con dos tipos obligatorio:
IF OBJECT_ID('V_Legendary_Type', 'V') IS NOT NULL
DROP VIEW V_Legendary_Type;
GO
CREATE VIEW V_Legendary_Type AS
SELECT	Orden, Name, [Tipo 1], [Tipo 2],Attack, Defense
FROM Pokemon
WHERE Legendary like '%TRUE%' and
	[Tipo 1] IS NOT null and 
	[Tipo 2] is not null;

-- Lista de Pokemon tipo Pokemon'Electric'
IF OBJECT_ID('V_Electric', 'V') IS NOT NULL
DROP VIEW V_Electric;
GO

CREATE VIEW V_Electric AS 
SELECT Orden, Name, [Tipo 1], [Tipo 2], Attack, Defense, Generation
FROM Pokemon
WHERE [Tipo 1] = 'Electric' or [Tipo 2] = 'Electric';

-- Lista de Pokemon tipo Pokemon 'Psychic'
IF OBJECT_ID('V_Psychic', 'V') IS NOT NULL
DROP VIEW V_Psychic;
GO
CREATE VIEW V_Psychic AS 
SELECT Orden, Name, [Tipo 1],[Tipo 2], Attack, Defense, Generation
FROM Pokemon
WHERE [Tipo 1] = 'Psychic' or [Tipo 2] = 'Psychic';

-- Lista de Pokemon tipo Pokemon 'Dragon'
IF OBJECT_ID('V_Dragon', 'V') IS NOT NULL
DROP VIEW V_Dragon;
GO
CREATE VIEW V_Dragon AS 
SELECT Orden, Name, [Tipo 1], [Tipo 2], Attack, Defense, Generation
FROM Pokemon
WHERE [Tipo 1] = 'Dragon' or [Tipo 2] = 'Dragon';

-- Lista de Pokemon de Generación 1
IF OBJECT_ID('V_Generation1', 'V') IS NOT NULL
DROP VIEW V_Generation1;
GO
CREATE VIEW V_Generation1 AS 
SELECT Orden, Name, [Tipo 1], [Tipo 2], Attack, Defense
FROM Pokemon
WHERE Generation = 1;

-- Lista de Pokemon de Generación 2
IF OBJECT_ID('V_Generation2', 'V') IS NOT NULL
DROP VIEW V_Generation2;
GO
CREATE VIEW V_Generation2 AS 
SELECT Orden, Name, [Tipo 1], [Tipo 2], Attack, Defense
FROM Pokemon
WHERE Generation = 2;
--======================================================================================================================================================
--Lista de los 50 pokemones con mejor ataque
IF OBJECT_ID('V_Attack','V') IS NOT NULL
DROP VIEW V_Attack;
GO
CREATE VIEW V_Attack AS
SELECT top(50) Orden,Name, [Tipo 1], [Tipo 2], Attack, Defense
FROM Pokemon
ORDER BY Attack DESC

--Lista de los 50 pokemones con mejor defensa
IF OBJECT_ID('V_Defense','V') IS NOT NULL
DROP VIEW V_Defense;
GO
CREATE VIEW V_Defense AS
SELECT top(50) Orden,Name, [Tipo 1], [Tipo 2], Attack, Defense
FROM Pokemon
ORDER BY Defense DESC

-- Lista de los 50 pokemones con mejor ataque y defensa combinados
IF OBJECT_ID('V_AttackDefense', 'V') IS NOT NULL
    DROP VIEW V_AttackDefense;
GO
CREATE VIEW V_AttackDefense AS
SELECT TOP 50 Orden, Name, [Tipo 1], [Tipo 2], Attack, Defense, (Attack + Defense) AS TotalScore
FROM Pokemon
ORDER BY TotalScore DESC;

--Lista de los 50 pokemones con mejor ataque y defensa, con una ponderación
--del 60% para el ataque en comparación a la defensa.

if OBJECT_ID('V_AttackDefense_Attack60','V') is not null
	DROP VIEW V_AttackDefense_Attack60
GO
CREATE VIEW V_AttackDefense_Attack60 AS
SELECT TOP 50 Orden, Name, [Tipo 1], [Tipo 2], Attack, Defense, (0.6*Attack + 0.4*Defense) AS TotalScore
FROM Pokemon
ORDER BY TotalScore DESC;


-- Lista de Pokemon con más de 100 puntos de HP
IF OBJECT_ID('V_HighHP', 'V') IS NOT NULL
DROP VIEW V_HighHP;
GO
CREATE VIEW V_HighHP AS 
SELECT Orden, Name, [Tipo 1], [Tipo 2], HP, Attack, Defense
FROM Pokemon
WHERE HP > 100;

-- Lista de Pokemon con velocidad mayor a 100
IF OBJECT_ID('V_HighSpeed', 'V') IS NOT NULL
DROP VIEW V_HighSpeed;
GO
CREATE VIEW V_HighSpeed AS 
SELECT Orden, Name, [Tipo 1], [Tipo 2], Speed, Attack, Defense
FROM Pokemon
WHERE Speed > 100;

-- Lista de Pokemon con alto ataque especial
IF OBJECT_ID('V_HighSpAtk', 'V') IS NOT NULL
DROP VIEW V_HighSpAtk;
GO
CREATE VIEW V_HighSpAtk AS 
SELECT  Orden, Name, [Tipo 1], [Tipo 2], [Sp# Atk] AS SpAtk, [Sp# Def] AS SpDef
FROM Pokemon
WHERE [Sp# Atk] > 100;
 
-- Lista de Pokemon con alta defensa especial
IF OBJECT_ID('V_HighSpDef', 'V') IS NOT NULL
DROP VIEW V_HighSpDef;
GO
CREATE VIEW V_HighSpDef AS 
SELECT Orden, Name, [Tipo 1], [Tipo 2], [Sp# Def] AS SpDef, [Sp# Atk] AS SpAtk
FROM Pokemon
WHERE [Sp# Def] > 100;

-- Lista de Pokemon con total de estadísticas mayor a 500
IF OBJECT_ID('V_HighTotal', 'V') IS NOT NULL
DROP VIEW V_HighTotal;
GO
CREATE VIEW V_HighTotal AS 
SELECT Orden, Name, [Tipo 1], [Tipo 2], Total, HP, Attack, Defense, [Sp# Atk], [Sp# Def], Speed
FROM Pokemon
WHERE Total > 500;

-- Lista de Pokemon con baja velocidad (menor a 50)
IF OBJECT_ID('V_LowSpeed', 'V') IS NOT NULL
DROP VIEW V_LowSpeed;
GO
CREATE VIEW V_LowSpeed AS 
SELECT Orden, Name, [Tipo 1], [Tipo 2], Speed, Attack, Defense
FROM Pokemon
WHERE Speed < 50;

--=========================================================================================================================
--DISTRIBUCIONES: 

--Distribución por Generación:
SELECT*FROM Pokemon
If OBJECT_ID('V_Distribucion_Generacion','V') IS NOT NULL
DROP VIEW V_Distribucion_Generacion;
go

Create View V_Distribucion_Generacion AS
SELECT Orden, Name,Generation as Generacion, Count(*) as Cantidad
from Pokemon
GROUP BY ORDEN, NAME, Generation
--Llamar a la Vista creada a traves de una consulta:
SELECT*FROM V_Distribucion_Generacion
order by Cantidad Desc;

--=============================================================================================================================
--Distribucion Pokemon Lengendarios
IF OBJECT_ID('V_Distribucion_Legendary', 'V') IS NOT NULL
DROP VIEW V_Distribucion_Legendary;
GO
CREATE VIEW V_Distribucion_Legendary AS 
SELECT Orden, Name,
		CASE 
           WHEN Legendary = 'TRUE' THEN 'Legendary' 
           ELSE 'Non-Legendary' 
		END AS Tipo, 
       COUNT(*) AS Cantidad
FROM Pokemon
Group by Orden, Name,Legendary
/*GROUP BY CASE 
            WHEN Legendary = 'TRUE' THEN 'Legendary' 
            ELSE 'Non-Legendary' 
         END;*/
--============================================================================================================================
/*Distribución por Tipo Primario: */
if OBJECT_ID('V_Distribucion_Tipo_Pri','V')is not null
DROP VIEW V_Distribucion_Tipo_Pri;
GO

CREATE VIEW V_Distribucion_Tipo_Pri AS
SELECT	[Tipo 1] AS TipoPrimario,
		COUNT([Tipo 1]) AS [Cant. Tipo1]
FROM  Pokemon
GROUP BY  [Tipo 1]
--Llamar a la consulta:
select*from V_Distribucion_Tipo_Pri
order by [Cant. Tipo1] DESC

/*Distribucion por Tipo Secundario*/
IF OBJECT_ID ('V_Distribucion_Tipo_Secu','V') is not null
DROP view V_Distribucion_Tipo_Secu;
go

CREATE VIEW V_Distribucion_Tipo_Secu AS
SELECT	[Tipo 2] AS TipoPrimario,
		COUNT([Tipo 2]) AS [Cant. Tipo2]
FROM  Pokemon
GROUP BY  [Tipo 2]
--Llamar a la consulta:
select*from V_Distribucion_Tipo_Secu
order by [Cant. Tipo2] DESC

/*Distribucion por tipo 1 y tipo 2*/
IF OBject_id ('V_Distribucion_Tipo_PrimSecu','V') IS NOT NULL
DROP VIEW V_Distribucion_Tipo_PrimSecu;
GO

CREATE VIEW V_Distribucion_Tipo_PrimSecu AS
sELECT 
    CAST([Tipo 1] AS NVARCHAR(255)) AS TipoPrimario,
    CAST([Tipo 2] AS NVARCHAR(255)) AS TipoSecundario,
    COUNT(*) AS Cantidad
FROM 
    Pokemon
GROUP BY 
    CAST([Tipo 1] AS NVARCHAR(255)),
    CAST([Tipo 2] AS NVARCHAR(255))

--=================================================================================================================================
/*Distribución por Generación y Tipo: */
IF OBJECT_id ('V_Distribucion_Tipo_Gener','V') IS NOT NULL
DROP VIEW V_Distribucion_Tipo_Gener;
go

CREATE VIEW V_Distribucion_Tipo_Gener as
SELECT	CAST([Tipo 1] AS nVARCHAR(255)) AS TipoPrimario,
		CAST([Tipo 2] AS nVARCHAR(255)) AS TipoSecundario,
		CAST(Generation as nvarchar(255)) as Generation,
		COUNT(*) AS Cantidad
FROM Pokemon
GROUP BY 
    CAST([Tipo 1] AS nVARCHAR(255)),
    CAST([Tipo 2] AS nVARCHAR(255)),
	CAST(Generation as nvarchar(255)) 
--=============================================================================================================================================0
select*from Pokemon
/*Distribucion por Pokemon Legendaios vs No legendarios*/
IF OBJECT_ID('V_Distribucion_Legendarios','V') IS NOT NULL
DROP VIEW V_Distribucion_Legendarios;
GO

CREATE VIEW V_Distribucion_Legendarios AS
SELECT	Legendary,
		count(*) as Cantidad
FROM Pokemon
group by Legendary
--==================================================================================================================================================
























