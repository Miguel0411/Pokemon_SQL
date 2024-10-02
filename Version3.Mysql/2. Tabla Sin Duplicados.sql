-- Dataset descargado:
SELECT* FROM pokemon;
-- Verificar Duplicados:
SELECT *, COUNT(*)
FROM Pokemon
GROUP BY Orden, `Name`, `Tipo 1`, `Tipo 2`, Total, HP, Attack, Defense, `Sp Atk`, `Sp Def`, Speed, Generation, Legendary
HAVING COUNT(*) > 1;

-- Creacion Nueva Tabla Pokemon:
CREATE TABLE IF NOT EXISTS Pokemon_new (
    IdPokemon INT AUTO_INCREMENT PRIMARY KEY,
    Orden FLOAT NULL,
    `Nombre` VARCHAR(255) NULL,
    `Tipo 1` VARCHAR(255) NULL,
    `Tipo 2` VARCHAR(255) NULL,
    Total FLOAT NULL,
    HP FLOAT NULL,
    Ataque FLOAT NULL,
    Defensa FLOAT NULL,
    `Ataque Especial` FLOAT NULL,
    `Defensa Especial` FLOAT NULL,
    Velocidad FLOAT NULL,
    Generacion FLOAT NULL,
    Legendario VARCHAR(255) NULL
);
DROP TABLE pokemon_new;
-- Datos copiados sin duplicar de la tabla Pokemon a la tabla Pokemon_new:
INSERT INTO Pokemon_new (Orden, `Nombre`, `Tipo 1`, `Tipo 2`, Total, HP, Ataque, Defensa, `Ataque Especial`, `Defensa Especial`, Velocidad, Generacion, Legendario)
SELECT Distinct Orden, `Name`, `Tipo 1`, `Tipo 2`, Total, HP, Attack, Defense, `Sp Atk`, `Sp Def`, Speed, Generation, Legendary
FROM Pokemon P
ORDER BY P.Orden;
-- Ver nueva Tabla:
SELECT *FROM pokemon_new;

