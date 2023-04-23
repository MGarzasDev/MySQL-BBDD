-- 1
create table pokemonfuego as
select p.nombre from pokemon p 
join pokemon_tipo pt on pt.numero_pokedex=p.numero_pokedex
join tipo t on t.id_tipo=pt.id_tipo
where t.nombre = "Fuego";
-- 4
insert pokemonfuego select p.nombre
from tipo t 
join pokemon_tipo pt on pt.id_tipo=t.id_tipo
join pokemon p on p.numero_pokedex=pt.numero_pokedex
where t.nombre = "fuego" and peso > 1;
-- 7
update pokemonfuego 
set nombre = (
	select nombre from pokemon 
    join estadisticas_base 
    on pokemon.numero_pokedex=estadisticas_base.numero_pokedex
    order by ataque desc limit 1
)
where nombre like "char%";
-- 10
delete from pokemonfuego
where nombre in (
	select pokemon.nombre from pokemon
    join pokemon_forma_evolucion pfe on pfe.numero_pokedex=pokemon.numero_pokedex
    join forma_evolucion fe on fe.id_forma_evolucion=pfe.id_forma_evolucion
    join tipo_evolucion te on te.id_tipo_evolucion=fe.tipo_evolucion
    where te.tipo_evolucion = "piedra"
);

-- 2
create table pokemonEvolucionesTipo as
select po.numero_pokedex as numero_origen,
po.nombre as nombre_origen,
tor.nombre tipo_origen,
tpe.tipo_evolucion evoluciona_con,
pe.nombre nombre_evolucionado,
te.nombre tipo_evolucionado
from pokemon po
join pokemon_tipo pto on pto.numero_pokedex=po.numero_pokedex
join tipo tor on tor.id_tipo=pto.id_tipo
join evoluciona_de ed on ed.pokemon_origen=po.numero_pokedex
join pokemon pe on pe.numero_pokedex=ed.pokemon_evolucionado
join pokemon_tipo pte on pte.numero_pokedex=pe.numero_pokedex
join tipo te on te.id_tipo=pte.id_tipo
join pokemon_forma_evolucion pfe on pfe.numero_pokedex=po.numero_pokedex
join forma_evolucion on forma_evolucion.id_forma_evolucion=pfe.id_forma_evolucion
join tipo_evolucion tpe on tpe.id_tipo_evolucion=forma_evolucion.tipo_evolucion
order by po.numero_pokedex;