# Creando tablas independiente para la segunda forma normal (NF2):

#Tabla TipoPokemon:
CREATE TABLE IF NOT EXISTS DimTipo(
	IdTipo INT auto_increment primary key,
    Tipo Varchar(255) not null,
    Descripcion varchar(255) null
);
-- DROP:
DROP TABLE DimTipo;
-- SELECT:
SELECT*FROM Pokemon.DimTipo;
-- INSERT:
INSERT INTO DimTipo (Tipo,Descripcion)
SELECT DISTINCT Tipo,
				concat('Tipo ',Tipo) as Descripcion
FROM principal_v1;
-- Cambio de Nombre:
RENAME TABLE dimtipopokemon TO DimTipo;


#Tabla Generacion:
CREATE TABLE IF NOT EXISTS DimGeneracion(
	IdGen INT auto_increment primary key,
    Descripcion varchar (255) null
);
-- DROP:
DROP TABLE DimGeneracion;
-- SELECT:
SELECT*FROM DimGeneracion;
-- INSERT:
INSERT INTO DimGeneracion (IdGen, Descripcion)
SELECT DISTINCT 
    CAST(Generacion AS UNSIGNED) AS IdGen,  -- Convertir Generación a un entero sin signo
    CONCAT('Generación ', CAST(Generacion AS UNSIGNED)) AS Descripcion
FROM Principal_v1
WHERE Generacion IS NOT NULL AND Generacion != ''
ORDER BY IdGen;
-- Cambio de Nombre:
RENAME TABLE TablaGeneracion TO DimGeneracion;
SELECT*FROM DimGeneracion;


#TablaLegendario:
CREATE TABLE IF NOT EXISTS DimLegendario (
	IdLen int auto_increment primary key,
    Legendario varchar(255),
    Descripcion varchar(255) null
);
-- DROP:
DROP TABLE DimLegendario;
-- SELECT:
SELECT * FROM Pokemon.DimLegendario;
-- INSERT:
INSERT INTO DimLegendario (Legendario, Descripcion)
SELECT distinct
	Legendario,
	CASE 
		WHEN Legendario = 'TRUE' THEN 'Legendario'
        ELSE 'No Legendario'
	END as Descripcion
FROM Principal_v1
WHERE Legendario is not null and Legendario != '';
-- Cambiar Nombre:
RENAME TABLE Legendario TO DimLegendario;
SELECT * FROM Pokemon.DimLegendario;


#TablaPokemon:
CREATE TABLE IF NOT EXISTS DimPokemon (
	IdPokemon INT AUTO_INCREMENT PRIMARY KEY,
    Orden FLOAT,
    Nombre varchar(255)
);
-- DROP:
DROP TABLE DimPokemon;
-- SELECT:
SELECT *FROM DimPokemon;
-- INSERT:
INSERT INTO DimPokemon (Orden, Nombre)
SELECT MIN(Orden), Nombre
FROM Principal_v1
WHERE Nombre IS NOT NULL
GROUP BY Nombre
ORDER BY MIN(Orden);


#Tabla FactPokemonTipo
CREATE TABLE IF NOT EXISTS FactPokemonTipo (
    IdPokemon INT,
    IdTipo INT,
    OrdenTipo INT,
    -- Llaves foráneas
    CONSTRAINT fk_IdPokemon FOREIGN KEY (IdPokemon) REFERENCES DimPokemon(IdPokemon),
    CONSTRAINT fk_IdTipo FOREIGN KEY (IdTipo) REFERENCES DimTipo(IdTipo)
);
-- DROP
DROP TABLE FactPokemonTipo;
-- SELECT 
SELECT * FROM FactPokemonTipo;
SELECT COUNT(*) fROM FactPokemonTipo;
-- INSERT
INSERT INTO FactPokemonTipo (IdPokemon, IdTipo, OrdenTipo)
SELECT 
    dp.IdPokemon,
    dt.IdTipo,
    P.OrdenTipo AS OrdenTipo 
FROM Principal_v1 p
JOIN DimPokemon dp ON dp.Nombre = p.Nombre
JOIN DimTipo dt ON dt.Tipo = p.Tipo
ORDER BY dp.IdPokemon, OrdenTipo;

#Tabla FactPokemonStats
CREATE TABLE IF NOT EXISTS FactPokemonStats(
	IdPokemon INT,
	IdGen INT,
    IdLen INT,
    Total FLOAT,
    HP FLOAT,
    Ataque FLOAT,
    Defensa FLOAT,
    `Ataque Especial` FLOAT,
    `Defensa Especial` FLOAT,
    Velocidad FLOAT,
    -- Llaves foráneas
    CONSTRAINT fk_IdPokemonStats FOREIGN KEY (IdPokemon) REFERENCES DimPokemon(IdPokemon),
    CONSTRAINT fk_IdGen FOREIGN KEY (IdGen) REFERENCES DimGeneracion(IdGen),
    CONSTRAINT fk_IdLen FOREIGN KEY (IdLen) REFERENCES DimLegendario (IdLen)
);
-- DROP
DROP TABLE FactPokemonStats;
-- SELECT 
SELECT * FROM FactPokemonStats;
-- INSERT
INSERT INTO FactPokemonStats (IdPokemon, IdGen, IdLen, Total, HP, Ataque, Defensa, `Ataque Especial`, `Defensa Especial`, Velocidad)
SELECT distinct dp.IdPokemon, 
		dg.IdGen,dl.IdLen,Total, HP, Ataque, Defensa, `Ataque Especial`, `Defensa Especial`, Velocidad
FROM Principal_v1 p
JOIN DimPokemon dp ON dp.Nombre = p.Nombre
JOIN dimgeneracion dg ON dg.IdGen = p.generacion
JOIN dimlegendario dl ON dl.Legendario = p.Legendario
ORDER BY dp.IdPokemon;







