-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas. 
select codigo_oficina, ciudad from oficina;
-- 2.Devuelve un listado con la ciudad y el teléfono de las oficinas de España. 
select ciudad, telefono from oficina where pais = "España";
select ciudad, telefono from oficina where pais like "España";
/*3.Devuelve un listado con el nombre, apellidos y email de los 
empleados cuyo jefe tiene un código de jefe igual a 7. */
select nombre, apellido1, apellido2, email 
	from empleado where codigo_jefe = 7;
select nombre, concat(apellido1," ", apellido2), email 
	from empleado where codigo_jefe = 7;
/*4.Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa. */
select puesto, nombre, apellido1, apellido2, email 
	from empleado where codigo_jefe is null;
/*5. Devuelve un listado con el nombre, apellidos y puesto 
de aquellos empleados que no sean representantes de ventas. */
select nombre, apellido1, apellido2, puesto 
	from empleado
	 where puesto not like "Representante Ventas";
	-- where puesto != "Representante Ventas";
	-- where puesto <> "Representante Ventas";
/*6. Devuelve un listado con el nombre de los todos los clientes españoles. */
select nombre_cliente from cliente 
	where pais like "Spain";
    -- where pais = "Spain";
/*7. Devuelve un listado con los distintos estados por los que puede pasar un pedido. */
select distinct estado from pedido;
/*9. Devuelve un listado con el código de pedido, código de cliente, 
fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo. */
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
	from pedido
    where fecha_esperada<fecha_entrega;
/*14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. 
Tenga en cuenta que no deben aparecer formas de pago repetidas. */
select distinct forma_pago from pago;
/*15. Devuelve un listado con todos los productos que pertenecen a la gama 
Ornamentales y que tienen más de 100 unidades en stock. 
El listado deberá estar ordenado por su precio de venta, 
mostrando en primer lugar los de mayor precio. */
select * from producto
	where gama = "Ornamentales" and cantidad_en_stock > 100
    order by precio_venta desc;
/*16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid 
y cuyo representante de ventas tenga el código de empleado 11 o 30. */
select * from cliente
	where ciudad = "Madrid"
	and (codigo_empleado_rep_ventas = 11 
		or codigo_empleado_rep_ventas = 30);
 select * from cliente
	where ciudad = "Madrid"
	and codigo_empleado_rep_ventas in (11, 30);       
        