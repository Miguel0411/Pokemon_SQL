USE pokemon;
#Creación Tabla Pokemon, para importar la base de datos.
CREATE TABLE IF NOT exists Pokemon (
    Orden FLOAT NULL,
    `Name` VARCHAR(255) NULL,
    `Tipo 1` VARCHAR(255) NULL,
    `Tipo 2` VARCHAR(255) NULL,
    Total FLOAT NULL,
    HP FLOAT NULL,
    Attack FLOAT NULL,
    Defense FLOAT NULL,
    `Sp Atk` FLOAT NULL,
    `Sp Def` FLOAT NULL,
    Speed FLOAT NULL,
    Generation FLOAT NULL,
    Legendary VARCHAR(255) NULL
);

#DROP TABLE
DROP TABLE pokemon.pokemon;
#SELECCIONAR TABLA:
SELECT *FROM pokemon.pokemon limit 1600;


