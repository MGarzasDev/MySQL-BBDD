/*1. Cree y rellene la tabla PAISES, con los mismos campos y datos que COUNTRIES (usa 
una sola sentencia) */
create table PAISES as select * from countries;
/*2. Cree la tabla LOCALIZACIONES basándose en la estructura de LOCATIONS, los campos 
tendrán los siguientes nombres: loc_id, Direccion, CodPostal, Ciudad, Provincia, 
Pais_ID. Rellénala con los datos de LOCATIONS (usa una sola sentencia) */
create table LOCALIZACIONES as select location_id loc_id,
street_address direccion, postal_code codpostal, 
city ciudad, state_province provincia,
country_id pais_id
 from locations;
/*3. Cree la tabla DEPARTAMENTOS con los campos ID y NombreDep, y rellene esta tabla 
con los datos de DEPARTMENTS (usar solo una sentencia). */
create table DEPARTAMENTOS as 
select department_id id, department_name nombreDep
from departments;
/*4. Cree la tabla EMPLEADOS, basándose en la tabla EMPLOYEES, con los campos ID, 
nombre, apellido y DepID. En la misma sentencia rellene esta nueva tabla con los 
cargos que tengan un “ad” en su código (job_id). 
(4 filas) */
create table EMPLEADOS as
select employee_id id, first_name nombre, last_name apellido, department_id depid
from employees
where job_id like "%ad%";
/*5. Insertar en la tabla EMPLEADOS aquellos trabajadores que tengan un sueldo 4000, 
6000 o 8000, según aparece en la tabla EMPLOYEES. 
(se insertan 6 filas) */
insert EMPLEADOS 
select employee_id id, first_name nombre, last_name apellido, department_id depid
from employees
where salary in (4000, 6000, 8000);
/*6. Insertar en la tabla EMPLEADOS, que están en la tabla EMPLOYEES que trabajen en 
Europa (región_name=’Europe’) 
(se insertan 36 filas) */
insert EMPLEADOS
select employee_id id, first_name nombre, last_name apellido, e.department_id depid
from employees e
join departments d on e.department_id=d.department_id
join locations l on l.location_id=d.location_id
join countries c on c.country_id=l.country_id
join regions r on r.region_id=c.region_id
where r.region_name like "Europe";
/*7. Borrar de EMPLEADOS aquellos que tienen un salario entre 3000 y 5000, según los 
datos de EMPLOYEES 
(borra 2 filas) */
delete from EMPLEADOS where id in (
	select employee_id from employees where salary between 3000 and 5000
);
/*8. Según los datos de la tabla EMPLOYEES, actualiza el campo DepID a 600 de la tabla 
EMPLEADOS, para aquellos empleados que tienen un salario de 6000. 
(2 filas actualizadas) */
update empleados 
set depid = 600
where id in (
	select employee_id from employees where salary = 6000
);
/*9. Según los datos de la tabla EMPLOYEES, actualiza el campo DepID al mismo 
que tenga 
el empleado que comenzó a trabajar el 24-5-99 (hire_date). 
Esta actualización solo se 
realizará para los empleados que tengan un salario igual a 8000. 
 (5 filas actualizadas) */
 update empleados 
 set depid = (
	select department_id from employees where hire_date = "1999-05-24"
 )
 where id in (
	select employee_id from employees where salary = 8000
);
