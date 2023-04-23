select * from animal;
select * from propietario;

select animal.nombre, propietario.nombre 
from animal, propietario
where animal.idPropietario=propietario.idpropietario
and propietario.nombre = "Paloma";

select animal.nombre, propietario.nombre 
from animal 
join propietario on animal.idPropietario=propietario.idpropietario
where propietario.nombre = "Paloma";

select * 
from animal, propietario;