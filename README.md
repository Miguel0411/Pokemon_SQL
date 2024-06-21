# Pokemon_SQL
Consultas en SQL utilizando un Dataset de Pokemon - SQL queries using a Pokémon dataset

# Proyecto de Análisis de Datos de Pokémon
Descripción del Proyecto
Este proyecto se centra en el análisis de datos de Pokémon y utiliza una base de datos en SQL Server. 
El objetivo es proporcionar una visión detallada de las características y estadísticas de los Pokémon a través de varias consultas y vistas SQL. Este análisis permite explorar diferentes aspectos como distribuciones por tipo, generación, estadísticas de combate, entre otras.

# Estructura de la Base de Datos
La base de datos contiene una única tabla llamada Pokemon con la siguiente estructura:

Orden: Número de orden del Pokémon.
Name: Nombre del Pokémon.
Tipo 1: Tipo principal del Pokémon.
Tipo 2: Tipo secundario del Pokémon (si aplica).
Total: Total de estadísticas del Pokémon.
HP: Puntos de vida del Pokémon.
Attack: Estadística de ataque del Pokémon.
Defense: Estadística de defensa del Pokémon.
Sp. Atk: Estadística de ataque especial del Pokémon.
Sp. Def: Estadística de defensa especial del Pokémon.
Speed: Estadística de velocidad del Pokémon.
Generation: Generación a la que pertenece el Pokémon.
Legendary: Indica si el Pokémon es legendario.

# Consultas y Vistas
Se han creado varias consultas y vistas SQL para analizar los datos de Pokémon. Aquí hay algunas de las vistas más relevantes:

V_Grass: Lista de Pokémon de tipo 'Grass'.
V_Fire: Lista de Pokémon de tipo 'Fire'.
V_Water: Lista de Pokémon de tipo 'Water'.
V_Legendary: Lista de Pokémon legendarios.
V_Legendary_Type: Lista de Pokémon legendarios con dos tipos obligatorios.
V_Electric: Lista de Pokémon de tipo 'Electric'.
V_Psychic: Lista de Pokémon de tipo 'Psychic'.
V_Dragon: Lista de Pokémon de tipo 'Dragon'.
V_Generation1: Lista de Pokémon de la generación 1.
V_Generation2: Lista de Pokémon de la generación 2.
V_Attack: Lista de los 50 Pokémon con mejor ataque.
V_Defense: Lista de los 50 Pokémon con mejor defensa.
V_AttackDefense: Lista de los 50 Pokémon con mejor ataque y defensa combinados.
V_AttackDefense_Attack60: Lista de los 50 Pokémon con mejor ataque y defensa, ponderando el ataque un 60%.
V_HighHP: Lista de Pokémon con más de 100 puntos de HP.
V_HighSpeed: Lista de Pokémon con velocidad mayor a 100.
V_HighSpAtk: Lista de Pokémon con alto ataque especial.
V_HighSpDef: Lista de Pokémon con alta defensa especial.
V_HighTotal: Lista de Pokémon con total de estadísticas mayor a 500.
V_LowSpeed: Lista de Pokémon con velocidad menor a 50.

# Distribuciones
Se han creado vistas para analizar la distribución de Pokémon por diferentes atributos:

V_Distribucion_Generacion: Distribución de Pokémon por generación.
V_Distribucion_Legendary: Distribución de Pokémon legendarios y no legendarios.
V_Distribucion_Tipo_Pri: Distribución de Pokémon por tipo principal.
V_Distribucion_Tipo_Secu: Distribución de Pokémon por tipo secundario.
V_Distribucion_Tipo_PrimSecu: Distribución de Pokémon por tipo principal y secundario.
V_Distribucion_Tipo_Gener: Distribución de Pokémon por generación y tipo.
V_Distribucion_Legendarios: Distribución de Pokémon legendarios vs no legendarios.

# Implementación en Power BI
Los datos y las vistas creadas se pueden importar a Power BI para crear visualizaciones interactivas que faciliten el análisis y la presentación de los resultados. Algunas de las visualizaciones recomendadas incluyen gráficos de barras, gráficos de columnas y matrices.

# Objetivos del Proyecto
-Análisis Detallado: Proveer un análisis detallado de las características y estadísticas de los Pokémon.
-Visualización de Datos: Crear visualizaciones interactivas para facilitar la comprensión de los datos.
-Herramientas de Exploración: Desarrollar herramientas y vistas SQL que permitan a los usuarios explorar y analizar diferentes aspectos de los datos de Pokémon.

Uso del Proyecto
Este proyecto puede ser utilizado por aficionados de Pokémon, analistas de datos, y cualquier persona interesada en aprender más sobre el análisis de datos utilizando SQL y Power BI.
