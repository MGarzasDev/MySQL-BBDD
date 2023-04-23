/*1.Muestre el modelo del coche, el nombre de la marca y el nombre 
del concesionario de todos los coches comprados por un cliente de Madrid. 
(1punto)*/
select co.modelo, ma.nombre, con.nombre
from coches co
join venden v on v.codcoche=co.codcoche
join concesionario con on con.cifc=v.cifc
join fabrica f on f.codcoche=co.codcoche
join marcas ma on ma.cifm=f.cifm
join clientes cli on cli.dni=v.dni
where cli.ciudad = "Madrid";
/*2.Muestre el máximo número (cantidad) de coches distribuidos 
por cada concesionario, el cifc del concesionario que los 
distribuye y el codcoche, de los coches 
que tiene un 1 en su codcoche. (Usa distribuyen) (0.75 puntos)*/
select max(cantidad) maximo, cifc, codcoche from distribuyen
where codcoche like "%1%"
group by cifc;
/*3.Muestra el nombre y el apellido, y las tres primeras letras de la 
ciudad en mayúscula de todos los clientes que tengan los dnis 0001, 
0002, 0003, y cuya ciudad no sea Valencia. (0.75 puntos)*/
select upper(concat(nombre, " ", apellido)) "nombre compuesto", 
upper(substr(ciudad, 1, 3)) ciudad from clientes
where dni in ("1", "2", "3")
-- (dni =1 or dni =2 or dni=3) and
and ciudad not like "Valencia";
/*4.Muestra el número total de clientes y el cifc del concesionario de 
la tabla venden. Agrúpalo por cifc y muestra sólo el que sea el 
que más tenga.(Muestre sólo uno aunque haya varios iguales) (1 Punto)*/
select count(dni) total, cifc from venden
group by cifc
order by total desc limit 1;

select count(dni) total, cifc from venden
group by cifc
having count(dni) >= all
	(select count(dni) total from venden
	group by cifc)
 limit 1;
/*5.Muestre el cifc, el nombre del concesionario, la ciudad del 
concesionario y el nombre del cliente, de aquellos concesionarios 
que hayan vendido un coche a alguien cuyo nombre contenga una a en 
cualquier posición seguida de al menos una letra. (1 Punto)*/
select con.*, cli.nombre from concesionario con
join venden v on v.cifc=con.cifc
join clientes cli on cli.dni=v.dni
where cli.nombre like "%a_%";
/*6.Muestre el modelo y el nombre del coche, la cantidad distribuída 
y el nombre del concesionario que los distribuye, de los coches 
cuya cantidad distribuída sea mayor a la media de la cantidad 
total distribuida, agrupado por código decoche. (1 Punto)*/
select concat(coches.modelo, " ", coches.nombre) as "coche", cantidad, concesionario.nombre from coches
join distribuyen on distribuyen.codcoche=coches.codcoche
join concesionario on concesionario.cifc=distribuyen.cifc
-- where cantidad > (select avg(cantidad) from distribuyen)
group by coches.codcoche
having sum(cantidad) > avg(cantidad) ;
/*7.Usa Jardinería para esta consulta: Muestra el nombre del empleado, 
el puesto del empleado, la ciudad de la oficina del empleado, 
el nombre del jefe, el puesto del jefe y la ciudad de la oficina del jefe, 
de todos los empleados cuya oficina no sea la misma que la de su jefe.(1 Punto)*/
use jardineria;
select 
	e1.nombre empleado, 
	e1.puesto "puesto empleado", 
	o1.ciudad "ciudad empleado", 
	e2.nombre jefe, 
    e2.puesto "puesto jefe", 
    o2.ciudad "ciudad jefe"
from empleado e1
join empleado e2 on e1.codigo_jefe=e2.codigo_empleado
join oficina o1 on o1.codigo_oficina=e1.codigo_oficina
join oficina o2 on o2.codigo_oficina=e2.codigo_oficina
where o1.codigo_oficina != o2.codigo_oficina;
/*8.Muestra el nombre y el modelo de los coches que no son distribuidos 
por ningún concesionario. Ordénalos de manera ascendente por el nombre 
y muestra los tres primeros.(1 Punto)*/
use coches;

select nombre, modelo from coches
where codcoche not in (select codcoche from distribuyen)
order by nombre asc limit 3;

select c.nombre, c.modelo from coches c
left join distribuyen d on d.codcoche=c.codcoche
where d.cifc is null 
order by nombre asc limit 3;
/*9.Muestre el total de coches y el nombre de la marca del coche, 
agrupado por la marca del coche de todos los coches comprados por 
un cliente de Madrid.(1Punto)*/
select count(co.codcoche) total, m.nombre from coches co
join venden v on v.codcoche=co.codcoche
join fabrica f on f.codcoche=co.codcoche
join marcas m on m.cifm=f.cifm
join clientes cli on cli.dni=v.dni
where cli.ciudad = "Madrid"
group by m.nombre;

select count(co.codcoche) total, m.nombre from coches co
join fabrica f on f.codcoche=co.codcoche
join marcas m on m.cifm=f.cifm
where co.codcoche in (
		select codcoche from venden 
		join clientes on clientes.dni=venden.dni
		where clientes.ciudad = "Madrid"
	)
group by m.nombre;
/*10.Muestre la media redondeada a dos decimales de la cantidad, 
el nombre del concesionario y el modelo del coche, agrupado por 
el nombre del concesionario y el código del coche. Muestre solo 
aquellos concesionariosque empiecen con una a o una b en el nombre, 
teniendo en cuenta que la media de la cantidad debe ser mayor que 
la máxima cantidad de coches distribuidos por cada concesionario que 
tengan una b en su nombre. Ordena el resultado por el valor de la media 
de forma que aparezca la más alta primero. (1.5 puntos)*/
select round(avg(cantidad), 2) media, con.nombre, modelo from distribuyen
join concesionario con on con.cifc=distribuyen.cifc
join coches on coches.codcoche=distribuyen.codcoche
where con.nombre like "a%" or con.nombre like "b%"
group by con.nombre, distribuyen.codcoche
having round(avg(cantidad), 2) >= (
	select max(cantidad) from distribuyen
    join concesionario con on con.cifc=distribuyen.cifc
    where con.nombre like "%b%"
)
order by media desc;