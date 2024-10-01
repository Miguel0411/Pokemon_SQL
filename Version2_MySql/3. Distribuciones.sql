# CONSULTAS Y VISTAS:
# Tablas Nuevas: PokemonPrincipal, TipoPokemon, Generaciones, Legendario
select *from TipoPokemon;
SELECT *FROM Generaciones;
# Creación de consultas:
USE POKEMON;

# Distribuciones:

	# 1. Distribucion por Generacion:
SELECT GeneracionID as Generacion,
		COUNT(*) AS Cantidad
FROM PokemonPrincipal
GROUP BY GeneracionID;

		#Creacion Vista Distribucion por Generacion:
DROP VIEW IF EXISTS V_Distribucion_Generacion;
Create View V_Distribucion_Generacion AS
SELECT 
	G.Descripcion AS Generacion,
    count(*) AS Cantidad
FROM PokemonPrincipal P
JOIN Generaciones G ON P.GeneracionID = G.ID
GROUP BY G.Descripcion;
		#Ver Vista
SELECT *FROM V_Distribucion_Generacion;

	# 2. Distribucion Pokemones Legendarios:
SELECT
	LegendarioID AS Legendario,
    count(*) AS Cantidad
FROM PokemonPrincipal
GROUP BY LegendarioID;

SELECT 
	L.Descripcion AS 'Tipo Legendario',
    COUNT(*) AS Cantidad
FROM pokemonprincipal P
JOIN Legendario L ON L.ID = P.LegendarioID
Group by L.Descripcion;

		# Creacion Vista Distrucion Pokemones Legendarios
DROP VIEW IF EXISTS V_Distribucion_Legendary;
CREATE VIEW V_Distribucion_Legendary    AS
SELECT 
	CASE 
		WHEN LegendarioID = 
			(SELECT ID FROM Legendario WHERE Descripcion ='Legendario')
            THEN 'Legendario'
		ELSE 'No Legendario'
	END AS 'Tipo Legendario',
    COUNT(*) AS Cantidad
FROM pokemonprincipal
GROUP BY LegendarioID
ORDER BY LegendarioID DESC;

		#Ver Vista
SELECT *FROM V_Distribucion_Legendary;

	# 3. Distribución Pokemones por Primer Tipo
SELECT * FROM tipopokemon t;
		#Creación de vista por tipo primario:
DROP VIEW if exists V_Distribucion_PrimerTipo;
CREATE VIEW V_Distribucion_PrimerTipo AS
SELECT	
	T. Descripcion as `1º Tipo`,
    COUNT(*) AS Cantidad
FROM pokemonprincipal P 
Join tipopokemon T on P.Tipo1_ID = T.ID
group by T.Descripcion;
		#Crear Vista:
SELECT *FROM V_Distribucion_PrimerTipo;

	# 4. Distribución Pokemones por Segundo Tipo
DROP VIEW IF EXISTS V_Distribucion_SegundoTipo;
CREATE VIEW V_Distribucion_SegundoTipo AS
SELECT 
    IFNULL(t.Descripcion, 'Sin Tipo') AS `2º Tipo`,
    COUNT(*) AS Cantidad
FROM 
    PokemonPrincipal P
LEFT JOIN 
    tipopokemon t ON P.Tipo2_ID = t.ID
GROUP BY 
    IFNULL(t.Descripcion, 'Sin Tipo');
		#Crear vista:
SELECT *FROM V_Distribucion_SegundoTipo;

	# 5. Distribucion Conjunta por Ambos tipos:
DROP VIEW IF EXISTS V_Distribucion_DosTipos;
CREATE VIEW V_Distribucion_DosTipos AS
SELECT 
    IFNULL(t1.Descripcion, 'Sin Tipo') AS `1º Tipo`,
    IFNULL(t2.Descripcion, 'Sin Tipo') AS `2º Tipo`,
    COUNT(*) AS Cantidad
FROM 
    PokemonPrincipal P
LEFT JOIN 
    tipopokemon t1 ON P.Tipo1_ID = t1.ID
LEFT JOIN 
    tipopokemon t2 ON P.Tipo2_ID = t2.ID
GROUP BY 
    IFNULL(t1.Descripcion, 'Sin Tipo'),
    IFNULL(t2.Descripcion, 'Sin Tipo')
ORDER BY 
	ifnull(t1.Descripcion,'Sin Tipo');
		#Crear Vista:
SELECT *FROM V_Distribucion_DosTipos;

	#6. Distribucion por Tipos y por Generacion
DROP VIEW if exists V_Distribucion_TipoGeneracion;
CREATE VIEW V_Distribucion_TipoGeneracion AS
SELECT 
    IFNULL(t1.Descripcion, 'Sin Tipo') AS `1º Tipo`,
    IFNULL(t2.Descripcion, 'Sin Tipo') AS `2º Tipo`,
    g.Descripcion AS 'Generacion',
    COUNT(*) AS Cantidad
FROM 
    PokemonPrincipal P
LEFT JOIN 
    tipopokemon t1 ON P.Tipo1_ID = t1.ID
LEFT JOIN 
    tipopokemon t2 ON P.Tipo2_ID = t2.ID
LEFT JOIN 
    generaciones g ON P.GeneracionID = g.ID
GROUP BY 
    IFNULL(t1.Descripcion, 'Sin Tipo'),
    IFNULL(t2.Descripcion, 'Sin Tipo'),
    g.Descripcion
ORDER BY g.Descripcion;
		  #Crear Vista:
SELECT *FROM V_Distribucion_TipoGeneracion;

	# 7. Distribucion por Tipo, Generacion y si es o no Legendario
DROP VIEW IF exists V_Distribucion_TipoGeneracionLegend;
CREATE View V_Distribucion_TipoGeneracionLegend AS
SELECT 
    IFNULL(T1.Descripcion, 'Sin Tipo') AS `1º Tipo`,
    IFNULL(T2.Descripcion, 'Sin Tipo') AS `2º Tipo`,
    G.Descripcion AS 'Generacion',
    IFNULL(L.Descripcion, 'No Legendario') AS 'Legendario',
    COUNT(*) AS Cantidad
FROM 
    PokemonPrincipal P
LEFT JOIN 
    Tipopokemon T1 ON P.Tipo1_ID = T1.ID
LEFT JOIN 
    Tipopokemon T2 ON P.Tipo2_ID = T2.ID
LEFT JOIN 
	Generaciones G ON P.GeneracionID = G.ID
LEFT JOIN 
    Legendario L ON P.LegendarioID = L.ID
GROUP BY 
    IFNULL(t1.Descripcion, 'Sin Tipo'),
    IFNULL(t2.Descripcion, 'Sin Tipo'),
    G.Descripcion,
    IFNULL(l.Descripcion, 'No Legendario');
		#Crear Vista:
SELECT *FROM V_Distribucion_TipoGeneracionLegend;









        
