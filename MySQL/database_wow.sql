create database wow;
use wow;

create table raza (
	idRaza int primary key,
    nombreRaza varchar(255),
    zona_inicial varchar(255)
);

create table profesion (
	idProfesion int primary key,
    nombreProfesion varchar(255)
);

create table personaje (
	idPersonaje int primary key,
    nombre varchar(255),
    nivel int,
    clase varchar(255),
    sexo varchar(255),
    faccion varchar(255),
    idRaza int,
    constraint fk_personaje_raza foreign key (idRaza)
    references raza(idRaza)
);

create table personaje_profesion (
	idPersonaje int,
    idProfesion int,
    primary key (idProfesion, idPersonaje),
    constraint fk_personajeprofesion_profesion foreign key (idProfesion)
    references profesion(idProfesion),
    constraint fk_personajeprofesion_personaje foreign key (idPersonaje)
    references personaje(idPersonaje)
);

/*Normalizar clase: creo la tabla clase,
cambio el tipo de dato de clase en personaje para que sea del mismo tipo
de dato que la primary key de clase,
añado la fk a personaje de clase*/
create table clase (
	idClase int primary key,
    nombreClase varchar(255)
);
alter table personaje modify column clase int;
alter table personaje add constraint fk_personaje_clase
	foreign key (clase) references clase(idClase);

-- crea la restriccion personaje_unique_nombre
alter table personaje add constraint personaje_unique_nombre
unique (nombre);

-- insertar 5 datos en cada tabla
insert into clase (idclase, nombreclase) 
	values (1, "Mago"), (2, "Guerrero"), (3, "Cazador"), (4, "Brujo"), 
    (5, "Paladín");
insert profesion values (1, "Mineria"), (2, "Herreria"), (3, "Herboristeria"),
(4, "Desuello"), (5, "Peletería"), (6, "Arqueologia");
insert raza (idRaza, nombreRaza, zona_inicial) 
	values (1, "Humano", "Ventormenta"), (2, "Orco", "Los baldíos"),
    (3, "Gnomo", "Gnomerang"), (4, "Trol", "Los baldíos"), (5, "Enano", "Forjaz");
insert into personaje values (1, "Lyrben", 70, 3, "F", "Alianza", 1),
							(2, "Joelito33", 3, 2, "M", "Horda", 4),
                            (3, "GuilFifa777XxXOoO", 55, 4, "M", "Alianza", 3),
                            (4, "DavideOrcasitas", 69, 5, "M", "Horda", 2),
                            (5, "DarkyPaulita", 70, 1, "F", "Alianza", 5);
insert personaje_profesion values (1, 4), (2, 3), (3, 1), (4,6), (5,2);

-- actualiza el nivel a 70 de todos los personajes de la alianza
update personaje set nivel = 70 where faccion = "Alianza";
-- borra todos los personajes de la horda
-- delete from personaje where faccion = "Horda";
-- muestra los nombres y niveles de los personajes que esten entre 60 y 70, ordenalos mostrando primero los de la alianza
select nombre, nivel from personaje 
where nivel between 60 and 70
order by faccion asc;

select nombre, nivel from personaje 
where nivel >= 60 and nivel<=70
order by faccion asc;

/*Muestra las 3 primera letras en mayuscula de los nombres de las razas
 cuya zona inicial contenga una e*/
 select upper(substr(nombreRaza, 1, 3)) from raza
 where zona_inicial like '%e%';
 
 /*Muestra los nombres de las profesiones que contengan más de 9 caracteres,
 ordénalo por orden alfabético, muestra sólo uno desde la segunda posicion*/
 select nombreprofesion from profesion 
 where length(nombreprofesion) >= 10
 order by nombreprofesion asc limit 2,1;