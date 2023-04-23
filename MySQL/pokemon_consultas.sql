--  Muestra los nombres de los pokemon tipo agua.
SELECT pokemon.nombre
FROM pokemon
JOIN pokemon_tipo ON pokemon.numero_pokedex = pokemon_tipo.numero_pokedex
JOIN tipo ON pokemon_tipo.id_tipo = tipo.id_tipo
WHERE tipo.nombre = 'agua';

-- Muestra el efecto secundario de los movimientos que tienen una
-- probabilidad de más del 60% de afectar.
SELECT efecto_secundario
FROM efecto_secundario
JOIN movimiento_efecto_secundario ON efecto_secundario.id_efecto_secundario = movimiento_efecto_secundario.id_efecto_secundario
WHERE movimiento_efecto_secundario.probabilidad > 0.6;

-- Muestra los movimientos de tipo fuego que aplican un efecto
-- secundario
SELECT movimiento.nombre
FROM movimiento
JOIN movimiento_efecto_secundario ON movimiento.id_movimiento = movimiento_efecto_secundario.id_movimiento
JOIN tipo ON movimiento.id_tipo = tipo.id_tipo
WHERE tipo.nombre = 'fuego';

-- Muestra los nombres y los tipos de los pokemon que evolucionan
-- usando una piedra
SELECT pokemon.nombre, tipo_piedra.nombre_piedra
FROM pokemon
JOIN pokemon_forma_evolucion ON pokemon.numero_pokedex = pokemon_forma_evolucion.numero_pokedex
JOIN forma_evolucion ON pokemon_forma_evolucion.id_forma_evolucion = forma_evolucion.id_forma_evolucion
JOIN tipo_evolucion ON forma_evolucion.tipo_evolucion = tipo_evolucion.id_tipo_evolucion
JOIN piedra ON forma_evolucion.id_forma_evolucion = piedra.id_forma_evolucion
JOIN tipo_piedra ON piedra.id_tipo_piedra = tipo_piedra.id_tipo_piedra
WHERE tipo_evolucion.tipo_evolucion = 'piedra';


-- Muestra los nombres de los tipos de piedra, de las piedras que
-- hacen evolucionar pokemon cuya altura sea mayor de 0.3
SELECT tipo_piedra.nombre_piedra
FROM tipo_piedra
JOIN piedra ON tipo_piedra.id_tipo_piedra = piedra.id_tipo_piedra
JOIN forma_evolucion ON piedra.id_forma_evolucion = forma_evolucion.id_forma_evolucion
JOIN pokemon_forma_evolucion ON forma_evolucion.id_forma_evolucion = pokemon_forma_evolucion.id_forma_evolucion
JOIN pokemon ON pokemon_forma_evolucion.numero_pokedex = pokemon.numero_pokedex
WHERE pokemon.altura > 0.3;

-- Muestra los movimientos de los pokemon tipo planta que se
-- aprenden al subir de nivel


--  Muestra el nombre de la preevolución, el nombre del pokemon y
-- el nombre de la evolución de los pokemons que tienen tres
-- evoluciones, junto con los niveles a los que evolucionan.
-- (charmander, charmeleon, charizard)


-- Muestra las mo que pueden aprender los pokemon tipo fuego que
-- evolucionan con piedra.

