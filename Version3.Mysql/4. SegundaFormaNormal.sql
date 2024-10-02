# Creando tablas independiente para la segunda forma normal (NF2):

#Tabla TipoPokemon:
CREATE TABLE IF NOT EXISTS TipoPokemon(
	IdTipo INT auto_increment primary key,
    Tipo Varchar(255) not null,
    Descripcion varchar(255) null
);
-- DROP:
DROP TABLE TipoPokemon;
-- SELECT:
SELECT*FROM Pokemon.TipoPokemon;
-- INSERT:
INSERT INTO TipoPokemon (Tipo,Descripcion)
SELECT DISTINCT Tipo,
				concat('Tipo ',Tipo) as Descripcion
FROM principal_v1;
-- Cambio de Nombre:
RENAME TABLE dimtipopokemon TO DimTipo;
SELECT*FROM dimtipopokemon;

#Tabla Generacion:
CREATE TABLE IF NOT EXISTS TablaGeneracion(
	IdGen INT auto_increment primary key,
    Descripcion varchar (255) null
);
-- DROP:
DROP TABLE TablaGeneracion;
-- SELECT:
SELECT*FROM TablaGeneracion;
-- INSERT:
INSERT INTO TablaGeneracion (IdGen, Descripcion)
SELECT DISTINCT 
    CAST(Generacion AS UNSIGNED) AS IdGen,  -- Convertir Generación a un entero sin signo
    CONCAT('Generación ', CAST(Generacion AS UNSIGNED)) AS Descripcion
FROM Principal_v1
WHERE Generacion IS NOT NULL AND Generacion != ''
ORDER BY IdGen;
-- Cambio de Nombre:
RENAME TABLE TablaGeneracion TO DimGeneracion;

#TablaLegendario:
CREATE TABLE IF NOT EXISTS Legendario (
	IdLen int auto_increment primary key,
    Legendario varchar(255),
    Descripcion varchar(255) null
);
-- DROP:
DROP TABLE Legendario;
-- SELECT:
SELECT * FROM Pokemon.Legendario;
-- INSERT:
INSERT INTO Legendario (Legendario, Descripcion)
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
    ROW_NUMBER() OVER (PARTITION BY dp.IdPokemon ORDER BY dt.IdTipo) AS OrdenTipo -- Para alternar OrdenTipo 1 y 2 por Pokémon
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







