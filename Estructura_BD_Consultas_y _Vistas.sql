/*# Estructura de la Base de Datos
La base de datos contiene una �nica tabla llamada Pokemon con la siguiente estructura:

Orden: N�mero de orden del Pok�mon.
Name: Nombre del Pok�mon.
Tipo 1: Tipo principal del Pok�mon.
Tipo 2: Tipo secundario del Pok�mon (si aplica).
Total: Total de estad�sticas del Pok�mon.
HP: Puntos de vida del Pok�mon.
Attack: Estad�stica de ataque del Pok�mon.
Defense: Estad�stica de defensa del Pok�mon.
Sp. Atk: Estad�stica de ataque especial del Pok�mon.
Sp. Def: Estad�stica de defensa especial del Pok�mon.
Speed: Estad�stica de velocidad del Pok�mon.
Generation: Generaci�n a la que pertenece el Pok�mon.
Legendary: Indica si el Pok�mon es legendario.

# Consultas y Vistas
Se han creado varias consultas y vistas SQL para analizar los datos de Pok�mon. Aqu� hay algunas de las vistas m�s relevantes:

V_Grass: Lista de Pok�mon de tipo 'Grass'.
V_Fire: Lista de Pok�mon de tipo 'Fire'.
V_Water: Lista de Pok�mon de tipo 'Water'.
V_Legendary: Lista de Pok�mon legendarios.
V_Legendary_Type: Lista de Pok�mon legendarios con dos tipos obligatorios.
V_Electric: Lista de Pok�mon de tipo 'Electric'.
V_Psychic: Lista de Pok�mon de tipo 'Psychic'.
V_Dragon: Lista de Pok�mon de tipo 'Dragon'.
V_Generation1: Lista de Pok�mon de la generaci�n 1.
V_Generation2: Lista de Pok�mon de la generaci�n 2.
V_Attack: Lista de los 50 Pok�mon con mejor ataque.
V_Defense: Lista de los 50 Pok�mon con mejor defensa.
V_AttackDefense: Lista de los 50 Pok�mon con mejor ataque y defensa combinados.
V_AttackDefense_Attack60: Lista de los 50 Pok�mon con mejor ataque y defensa, ponderando el ataque un 60%.
V_HighHP: Lista de Pok�mon con m�s de 100 puntos de HP.
V_HighSpeed: Lista de Pok�mon con velocidad mayor a 100.
V_HighSpAtk: Lista de Pok�mon con alto ataque especial.
V_HighSpDef: Lista de Pok�mon con alta defensa especial.
V_HighTotal: Lista de Pok�mon con total de estad�sticas mayor a 500.
V_LowSpeed: Lista de Pok�mon con velocidad menor a 50.

# Distribuciones
Se han creado vistas para analizar la distribuci�n de Pok�mon por diferentes atributos:

V_Distribucion_Generacion: Distribuci�n de Pok�mon por generaci�n.
V_Distribucion_Legendary: Distribuci�n de Pok�mon legendarios y no legendarios.
V_Distribucion_Tipo_Pri: Distribuci�n de Pok�mon por tipo principal.
V_Distribucion_Tipo_Secu: Distribuci�n de Pok�mon por tipo secundario.
V_Distribucion_Tipo_PrimSecu: Distribuci�n de Pok�mon por tipo principal y secundario.
V_Distribucion_Tipo_Gener: Distribuci�n de Pok�mon por generaci�n y tipo.
V_Distribucion_Legendarios: Distribuci�n de Pok�mon legendarios vs no legendarios.

*/