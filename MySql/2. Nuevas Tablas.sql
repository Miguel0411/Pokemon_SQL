#Normalizacion
/*
-Creación de 3 Nuevas tablas: 
	TipoPokemon, Generaciones, Legendario
-Creación de nueva tabla PokemonPrincipal.
*/
## 1. Tabla TipoPokemon
CREATE TABLE IF NOT EXISTS TipoPokemon(
	ID INT auto_increment primary key,
    Tipo Varchar(255) not null,
    Descripcion varchar(255) null
);
### 1.1 Creacion Comando DROP TABLE
DROP TABLE pokemon.tipopokemon;
### 1.2 Seleccionar Tabla TipoPokemon:
SELECT*FROM tipopokemon;
### 1.3 Inserción valores de la tabla Pokemon
INSERT INTO tipopokemon (Tipo,Descripcion)
select distinct tipo,
				concat('Tipo ',Tipo) as descripcion
from (
	select `Tipo 1` as tipo from pokemon 
    where `Tipo 1` is not null AND `Tipo 1` != ''
    union
    select `Tipo 2` as tipo from pokemon 
    where `Tipo 2` is not null AND `Tipo 2` != ''
    ) as TiposUnicos;

## 2. Tabla Generaciones
 CREATE TABLE IF NOT EXISTS Generaciones(
	ID INT auto_increment primary key,
    Descripcion varchar (255) null
);
### 2.1 Creacion comando DROP TABLE
DROP TABLE pokemon.generaciones;
### 2.2 Seleccionar tabla generaciones
SELECT*FROM pokemon.generaciones;
### 2.3 Insercion valores
INSERT INTO generaciones(Descripcion)
SELECT DISTINCT 
	CONCAT('Generacion ',cast(Generation as CHAR))as Descripcion
FROM Pokemon;

## 3. Tabla Legendario
CREATE TABLE IF NOT EXISTS Legendario (
	ID int auto_increment primary key,
    Descripcion varchar(255) null
);
### 3.1 Drop table
DROP TABLE pokemon.Legendario;
### 3.2 Seleccionar tabla legendario
SELECT*FROM pokemon.Legendario;
### 3.3 Insertar valores:
INSERT INTO Legendario (Descripcion)
SELECT distinct
	CASE 
		WHEN Legendary = 'TRUE' THEN 'Legendario'
        ELSE 'No Legendario'
	END as Descripcion
FROM pokemon
WHERE Legendary is not null and Legendary != '';

## 4. Tabla PokemonPrincipal
CREATE TABLE if not exists PokemonPrincipal(
    PokemonID INT AUTO_INCREMENT PRIMARY KEY,
    Orden FLOAT NULL,
    Nombre VARCHAR(255) NULL,
    Tipo1_ID INT NULL,
    Tipo2_ID INT NULL,
    Total FLOAT NULL,
    HP FLOAT NULL,
    Ataque FLOAT NULL,
    Defensa FLOAT NULL,
    Ataque_especial FLOAT NULL,
    Defensa_especial FLOAT NULL,
    Velocidad FLOAT NULL,
    GeneracionID INT NULL,
    LegendarioID INT NULL,
    CONSTRAINT FK_Tipo1 FOREIGN KEY (Tipo1_ID) REFERENCES TipoPokemon(ID),
    CONSTRAINT FK_Tipo2 FOREIGN KEY (Tipo2_ID) REFERENCES TipoPokemon(ID),
    CONSTRAINT FK_GeneracionID FOREIGN KEY (GeneracionID) REFERENCES Generaciones(ID),
    CONSTRAINT FK_LegendarioID FOREIGN KEY (LegendarioID) REFERENCES Legendario(ID)
);
### 4.1 DROP TABLE
DROP TABLE PokemonPrincipal;
### 4.2 Seleccionar Tabla
SELECT *FROM PokemonPrincipal;
### 4.3 Insertar Valores:
INSERT INTO PokemonPrincipal(
	Orden,
    Nombre,
    Tipo1_ID,
    Tipo2_ID,
    Total,
    Hp,
    Ataque,
    Defensa,
    Ataque_especial,
    Defensa_especial,
    Velocidad,
    GeneracionID,
    LegendarioID)
SELECT
	Orden,
    `Name` AS Nombre,
    Tp1.ID as Tipo1_ID,
    Tp2.ID as Tipo2_ID,
    Total,
    HP ,
    Attack as Ataque,
    Defense as Defensa,
    `Sp Atk`as Ataque_especial,
    `Sp Def`as Defensa_especial,
    Speed as Velocidad,
    G.ID as GeneracionID,
    L.ID as LegendarioID
FROM pokemon P
LEFT JOIN tipopokemon Tp1 ON P.`Tipo 1` = Tp1.Tipo
LEFT JOIN tipopokemon Tp2 ON P.`Tipo 2` = Tp2.Tipo
LEFT JOIN generaciones G ON P.Generation = G.ID
LEFT JOIN legendario L ON 
	CASE 
		WHEN P.Legendary = 'True' THEN 'Legendario'
        ELSE 'No Legendario'
	END = L.Descripcion;









