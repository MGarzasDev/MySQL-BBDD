-- 1
create index nombre_cliente_index on cliente(nombre_cliente);
show indexes from cliente;
drop index nombre_cliente_index on cliente;

-- vistas
-- 1
create view HiperGardenTools as 
select count(codigo_producto), sum(cantidad_en_stock), 
sum(precio_venta-precio_proveedor)
from producto
where proveedor like "HiperGarden Tools";
-- 2
create view Jefes as
select jefe.codigo_empleado, 
concat(jefe.nombre," ", jefe.apellido1," ", jefe.apellido2), 
count(emple.codigo_empleado)
from empleado jefe
join empleado emple
	on emple.codigo_jefe=jefe.codigo_empleado
group by jefe.codigo_empleado;

-- 3
create view resultados2009 as
select count(id_transaccion), sum(total)
from pago
where year(fecha_pago) = 2009;

-- 4
create view representantesClientesMadrid as
select distinct e.codigo_empleado, 
concat(e.nombre," ", e.apellido1," ", e.apellido2),
o.linea_direccion1
from empleado e
join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
join oficina o on o.codigo_oficina=e.codigo_oficina
where c.ciudad = "Madrid";

-- 5
select * from jefes;
drop view if exists jefes;

-- DML
-- 1
create table empleadosRepVentasMadrid as 
select distinct e.*
from empleado e
join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
join oficina o on o.codigo_oficina=e.codigo_oficina
where o.ciudad = "Madrid";

-- 2
insert empleadosRepVentasMadrid
select distinct e.*
from empleado e
join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
join pedido p on p.codigo_cliente = c.codigo_cliente
where c.ciudad = "Madrid"
and year(p.fecha_pedido) = 2009
and estado = "entregado";

-- 3
update empleadosRepVentasMadrid
set codigo_jefe = 
(
	select codigo_empleado 
    from empleado
	where nombre = "Marcos" 
    and apellido1="Magaña" 
    and apellido2="Perez"
)
where codigo_jefe = 
(
	select codigo_empleado 
    from empleado
	where nombre = "Carlos" 
    and apellido1 = "Soria" 
    and apellido2 = "Jimenez"
);

-- 4
delete from empleadosRepVentasMadrid
where codigo_oficina in (
	select codigo_oficina
    from oficina
    where pais not like "España"
);
