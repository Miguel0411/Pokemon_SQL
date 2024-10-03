# NORMALIZACION:
# Creando la nueva tabla pokemon, que integra en una sola columna el tipo NF1:
CREATE TABLE IF NOT EXISTS Principal_v1(
    `Orden` FLOAT NULL,
    `Nombre` VARCHAR(255) NULL,
    `Tipo` VARCHAR(255) NULL,
    `OrdenTipo` VARCHAR(255) NULL,
    `Total` FLOAT NULL,
    `HP` FLOAT NULL,
    `Ataque` FLOAT NULL,
    `Defensa` FLOAT NULL,
    `Ataque Especial` FLOAT NULL,
    `Defensa Especial` FLOAT NULL,
    `Velocidad` FLOAT NULL,
    `Generacion` FLOAT NULL,
    `Legendario` VARCHAR(255) NULL
);
DROP TABLE Principal_v1;

-- Datos en la nueva tabla:
-- Insertar filas con Tipo 1
INSERT INTO Principal_v1 (`Orden`, `Nombre`, `Tipo`, `OrdenTipo`, `Total`, `HP`, `Ataque`, `Defensa`, `Ataque Especial`, `Defensa Especial`, `Velocidad`, `Generacion`, `Legendario`)
SELECT *
FROM (
    SELECT 
        IdPokemon AS `Orden`, 
        Nombre, 
        `Tipo 1` AS Tipo, 
        1 AS OrdenTipo,
        Total, 
        HP, 
        Ataque, 
        Defensa, 
        `Ataque Especial`, 
        `Defensa Especial`, 
        Velocidad, 
        Generacion, 
        Legendario
    FROM 
        Pokemon_new
    WHERE 
        `Tipo 1` IS NOT NULL AND `Tipo 1` != ''
    UNION ALL
    SELECT 
        IdPokemon AS `Orden`, 
        Nombre, 
        COALESCE(NULLIF(`Tipo 2`, ''), 'Sin Tipo') AS Tipo, 
        2 AS OrdenTipo,
        Total, 
        HP, 
        Ataque, 
        Defensa, 
        `Ataque Especial`, 
        `Defensa Especial`, 
        Velocidad, 
        Generacion, 
        Legendario
    FROM 
        Pokemon_new
) AS SubConsultaTipo
ORDER BY `Orden`, `OrdenTipo`;
Select *from Principal_V1 LIMIT 1600;



