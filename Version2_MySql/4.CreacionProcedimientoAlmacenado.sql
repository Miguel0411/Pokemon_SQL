#CREACION PROCEDIMIENTO ALMACENADO PARA ACTUALIZAR TABLAS POKEMON:
DELIMITER //

CREATE PROCEDURE ActualizarTablas()
BEGIN
    -- 1. Actualizar tabla TipoPokemon
    INSERT IGNORE INTO TipoPokemon (Tipo, Descripcion)
    SELECT DISTINCT 
        Tipo,
        CONCAT('Tipo ', Tipo) AS Descripcion
    FROM (
        SELECT `Tipo 1` AS Tipo FROM Pokemon 
        WHERE `Tipo 1` IS NOT NULL AND `Tipo 1` != ''
        UNION
        SELECT `Tipo 2` AS Tipo FROM Pokemon 
        WHERE `Tipo 2` IS NOT NULL AND `Tipo 2` != ''
    ) AS TiposUnicos;

    -- 2. Actualizar tabla Generaciones
    INSERT IGNORE INTO Generaciones (Descripcion)
    SELECT DISTINCT 
        CONCAT('Generacion ', CAST(Generation AS CHAR)) AS Descripcion
    FROM Pokemon;

    -- 3. Actualizar tabla Legendario
    INSERT IGNORE INTO Legendario (Descripcion)
    SELECT DISTINCT
        CASE 
            WHEN Legendary = 'TRUE' THEN 'Legendario'
            ELSE 'No Legendario'
        END AS Descripcion
    FROM Pokemon
    WHERE Legendary IS NOT NULL AND Legendary != '';

    -- 4. Actualizar tabla PokemonPrincipal
    INSERT IGNORE INTO PokemonPrincipal (
        Orden,
        Nombre,
        Tipo1_ID,
        Tipo2_ID,
        Total,
        HP,
        Ataque,
        Defensa,
        Ataque_especial,
        Defensa_especial,
        Velocidad,
        GeneracionID,
        LegendarioID
    )
    SELECT
        Orden,
        `Name` AS Nombre,
        Tp1.ID AS Tipo1_ID,
        Tp2.ID AS Tipo2_ID,
        Total,
        HP,
        Attack AS Ataque,
        Defense AS Defensa,
        `Sp Atk` AS Ataque_especial,
        `Sp Def` AS Defensa_especial,
        Speed AS Velocidad,
        G.ID AS GeneracionID,
        L.ID AS LegendarioID
    FROM Pokemon P
    LEFT JOIN TipoPokemon Tp1 ON P.`Tipo 1` = Tp1.Tipo
    LEFT JOIN TipoPokemon Tp2 ON P.`Tipo 2` = Tp2.Tipo
    LEFT JOIN Generaciones G ON P.Generation = G.ID
    LEFT JOIN Legendario L ON 
        CASE 
            WHEN P.Legendary = 'True' THEN 'Legendario'
            ELSE 'No Legendario'
        END = L.Descripcion;
END //

DELIMITER ;

