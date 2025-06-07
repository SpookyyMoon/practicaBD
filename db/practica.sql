#################################### INSERCCIÓN DE DATOS DE LA PRÁCTICA ANTERIOR #################################

#Creacion y seleccion db
CREATE database if not exists practica_hotel;
USE practica_hotel;

#Creacion de tablas
CREATE TABLE if not exists cliente(
	dni varchar(9) unique not null,
    nombre varchar(32) not null, #Cambio a varchar de 32, no entran los datos
    apellidos varchar(30) not null,
    domicilio varchar(30) not null,
    telefono varchar(9) not null,
    
    primary key(dni)
);

CREATE TABLE if not exists habitacion(
	numero int unique not null,
	superficie int not null,
    bar varchar(2) CHECK (bar in ("Si", "No")) not null,
    terraza varchar(2) CHECK (terraza in ("Si", "No")) not null,
    puedeSupletoria varchar(2) CHECK (puedeSupletoria in ("Si", "No")) not null,
    tipo varchar(10) CHECK (tipo in ("Individual", "Doble")) not null,
    
    primary key(numero)
);

CREATE TABLE if not exists precio(
	tipo varchar(10) unique not null,
    precio int,
    
    primary key(tipo)
);

CREATE TABLE if not exists factura(
	codigoF int unique not null,
    entrada date not null,
    salida date,
    dni varchar(9) not null,
    numero int not null,
    supletoria int,
    forma varchar(8) CHECK (forma in ("Efectivo", "Tarjeta", "Talón")) not null,
    
    primary key(codigoF)
);

CREATE TABLE if not exists servicio(
	codS int unique not null,
    descripcion VARCHAR(11) CHECK (descripcion IN ("tintorería", "plancha", "lavandería", "bar", "restaurante", "floristeria")) not null,
    costeInterno int,
    numReg int not null,
    
    primary key(codS)
);

CREATE TABLE if not exists formaPago(
    forma varchar(8) CHECK (forma in ("Efectivo", "Tarjeta", "Talón")) unique not null,
    comision int,
    
    primary key(forma)
);

CREATE TABLE if not exists empleado(
	numReg int unique not null,
    nombre varchar(32) not null, #Cambio a varchar de 32, no entran los datos
    incorporacion date not null,
    sueldo int,
    codS int,
    codigoE int, #Renombro porque codE es reservada
	coste int,
    
    primary key(numReg)
);

CREATE TABLE if not exists proveedor(
	nif varchar(10) not null,
    nombre varchar(16) not null,
    direccion varchar(30) not null,
    numReg int not null,
    
    primary key(nif)
);

CREATE TABLE if not exists factura_prov(
	codFP int unique not null,
    fecha date not null,
    importe int not null,
    nif varchar(10) not null,
    numReg int not null,
    
    primary key(codFP)
);

CREATE TABLE if not exists empresa(
	codigoE int unique not null,
    nombre varchar(20) not null,
    direccion varchar(30) not null,
    
    primary key(codigoE)
);

CREATE TABLE if not exists reserva(
	dni varchar(9) not null,
    numero int not null,
    entrada date not null,
    salida date not null,

	primary key(dni, numero)
);

CREATE TABLE if not exists incluye(
	codigoF int not null,
    codS int not null,
    coste int not null,
    fecha date not null,
    
    primary key(codigoF, codS, fecha)
);

CREATE TABLE if not exists usa(
	codS int not null,
    servicio_codS int not null,
    fecha date not null,
    
    primary key(codS, servicio_codS, fecha)
);

CREATE TABLE if not exists limpieza(
	numReg int not null,
    numero int not null,
    fecha date not null,
    
    primary key(numReg, numero, fecha)
);

#Modificacion tablas
ALTER TABLE habitacion add foreign key(tipo) references precio(tipo) 
	on DELETE no action;
ALTER TABLE factura add foreign key(dni) references cliente(dni);
ALTER TABLE factura add foreign key(numero) references habitacion(numero);
ALTER TABLE factura add foreign key(forma) references formaPago(forma);
ALTER TABLE servicio add foreign key(numReg) references empleado(numReg)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE servicio add foreign key(codS) references servicio(codS)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE empleado add foreign key(codigoE) references empresa(codigoE)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE proveedor add foreign key(numReg) references empleado(numReg)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE factura_prov add foreign key(nif) references proveedor(nif)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE factura_prov add foreign key(numreg) references empleado(numreg)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE reserva add foreign key(dni) references cliente(dni)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE reserva add foreign key(numero) references habitacion(numero)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE incluye add foreign key(codigoF) references factura(codigoF)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE incluye add foreign key(codS) references servicio(codS)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE usa add foreign key(codS) references servicio(codS)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE usa add foreign key(servicio_codS) references servicio(codS)
	on DELETE no action
    on UPDATE cascade; #Cambio a que servicio_codS referencia servicio(codS)
ALTER TABLE limpieza add foreign key(numreg) references empleado(numreg)
	on DELETE no action
    on UPDATE cascade;
ALTER TABLE limpieza add foreign key(numero) references habitacion(numero)
	on DELETE no action
    on UPDATE cascade;
    
#Insercción de datos
INSERT INTO cliente(dni,nombre,apellidos,domicilio,telefono) VALUES
	(111111,"Antonio","Aguirre Pez","20, 1oA",999418768),
	(222222,"Jorge","Anguiano López","Churruca 2, 6oD",999876737),
	(333333,"Pilar","Méndez Alonso","Gran vía 167",999343543),
	(444444,"Azucena","Rubio del Val","Brasil 63 2oA",999456765),
	(555555,"Raúl","Gutiérrez González","Literatos 3, 5o",999876234),
	(666666,"Santiago","Rivera Romero","Avd de la Paz 30",999111232),
	(777777,"Pedro","González Hernando","Castellana 290, 9oB",999232222),
	(888888,"Antonio","Díaz Martín","Cuba 1",999444554),
	(999999,"Virginia","Fernández Fernández","Brasil 65, 3o",999009009),
	(000000,"Francisco","Vilansó Rodríguez","General Rodrigos, 24",999667788);

INSERT INTO precio(tipo, precio) VALUES
	("Individual", 75),
    ("Doble", 90);

INSERT INTO habitacion(numero,superficie,bar,terraza,puedeSupletoria,tipo) VALUES
	(100,17,"Si","Si","Si","Doble"),
	(101,17,"Si","Si","Si","Doble"),
	(102,17,"Si","Si","Si","Individual"),
	(200,17,"Si","Si","Si","Doble"),
	(201,17,"Si","Si","No","Doble"),
	(202,15,"Si","Si","No","Individual"),
	(203,17,"No","Si","Si","Individual"),
	(204,17,"Si","Si","Si","Doble"),
	(300,17,"No","Si","Si","Doble"),
	(301,17,"Si","Si","Si","Doble");

INSERT INTO formaPago(forma,comision) VALUES
	("Efectivo", 0),
    ("Tarjeta", 2),
    ("Talón", 5);

INSERT INTO empresa(codigoE,nombre,direccion) VALUES
	(1, "Resources Consulting", "Avd. de los Recursos, 101"),
	(2, "Personal Servicing", "Plaza de Alquiler, 65");

INSERT INTO empleado(numreg,nombre,incorporacion,sueldo,codS,codigoE,coste) VALUES
	(1, "Luisa Blanco Baroja", "1996/10/23", 1000, NULL, NULL, NULL),
	(2, "Fernando Serrano Vázquez", "1996/10/23", 1000, NULL, NULL, NULL),
	(3, "Manuel Pérez Calo", "2000/01/01", 900, NULL, NULL, NULL),
	(4, "Ana Troncoso Calvo", "2000/01/01", 900, NULL, NULL, NULL),
	(5, "Alba Troncoso Calvo", "2002/09/13", NULL, NULL, 1, 1100),
	(6, "Jorge Alonso Alonso", "2002/09/13", NULL, NULL, 1, 1100),
	(7, "Fernando Soaje Álvarez", "2003/01/01", NULL, NULL, 2, 1200),
	(8, "Rosa Luigi Paz", "2003/01/01", 1000, NULL, NULL, NULL),
	(9, "Rafael Fuertes Cabrera", "2003/01/01", 1100, NULL, NULL, NULL),
	(10, "Antonio Sancho Sancho", "2003/01/01", 1000, NULL, NULL, NULL),
	(11, "María Gonzalo Fuentes", "2003/01/01", 1000, NULL, NULL, NULL),
	(12, "Juana Peláez Trasto", "2003/01/01", 900, NULL, NULL, NULL),
	(13, "Gonzalo Cabezas Muiño", "2003/01/01", 1500, NULL, NULL, NULL);

INSERT INTO servicio(codS,descripcion,costeInterno,numreg) VALUES
	(1, "Tintoreria", 50, 1),
	(2, "Plancha", 30, 2),
	(3, "Lavanderia", 60, 3),
	(4, "Bar", 15, 4),
	(5, "Restaurante", 50, 8),
	(6, "Floristeria", 25, 9);
    
INSERT INTO usa(codS,servicio_codS,fecha) VALUES
	(5, 1, "2024/11/25"),
	(5, 1, "2024/11/30"),
	(5, 1, "2024/12/24"),
	(5, 2, "2024/11/18"),
	(5, 2, "2024/12/01"),
	(5, 3, "2024/12/05"),
	(5, 4, "2024/12/20"),
	(5, 4, "2024/12/29"),
	(5, 6, "2024/12/25"),
	(4, 2, "2024/11/17"),
	(4, 2, "2024/11/29"),
	(4, 3, "2024/12/01"),
	(4, 3, "2024/12/05"),
	(4, 3, "2024/12/19");
    
INSERT INTO limpieza(numreg,numero,fecha) VALUES
	(10, 101, "2024/10/20"),
	(10, 101, "2024/10/21"),
	(10, 101, "2024/10/22"),
	(10, 101, "2024/10/23"),
	(10, 102, "2024/10/24"),
	(10, 202, "2024/11/23"),
	(10, 203, "2024/11/23"),
	(10, 204, "2024/11/30"),
	(10, 301, "2024/12/30"),
	(10, 300, "2024/12/23"),
	(12, 100, "2024/11/10"),
	(12, 101, "2024/11/10"),
	(12, 102, "2024/11/10"),
	(12, 200, "2024/11/10"),
	(12, 201, "2024/11/11"),
	(12, 202, "2024/11/11"),
	(12, 203, "2024/11/11"),
	(12, 204, "2024/11/11"),
	(12, 300, "2024/11/12"),
	(12, 301, "2024/11/12"),
	(11, 100, "2024/10/01"),
	(11, 100, "2024/11/01"),
	(11, 100, "2024/12/01"),
	(11, 100, "2024/12/02"),
	(11, 101, "2024/10/10"),
	(11, 101, "2024/11/10"),
	(11, 101, "2024/10/14"),
	(11, 102, "2024/10/15"),
	(11, 200, "2024/10/10"),
	(11, 201, "2024/11/10"),
	(11, 202, "2024/11/10"),
	(11, 203, "2024/01/10"),
	(11, 204, "2024/01/10"),
	(11, 301, "2024/01/10"),
	(11, 301, "2024/01/01"),
	(11, 301, "2024/01/17");
    
INSERT INTO proveedor(nif,nombre,direccion,numreg) VALUES
	("121212T", "Carnes SA", "Plaza de los Acá 20", 8),
	("343434L", "Logística Pérez", "Calle del Pueblo 30, 1o", 1),
	("545454Q", "Prd. Químicos SA", "Colombiana 34", 12);

INSERT INTO factura_prov(codfp,fecha,importe,nif,numreg) VALUES
	(1, "2024/03/21", 1500, "121212T", 8),
	(2, "2024/04/21", 1000, "121212T", 8),
	(3, "2024/05/21", 500, "121212T", 8),
	(4, "2024/06/21", 976, "121212T", 8),
	(5, "2024/03/21", 345, "343434L", 1),
	(6, "2024/05/21", 235, "343434L", 1),
	(7, "2024/07/21", 1000, "343434L", 1),
	(8, "2024/08/21", 765, "343434L", 1),
	(9, "2024/03/21", 1235, "545454Q", 12),
	(10, "2024/04/11", 2342, "545454Q", 12),
	(11, "2024/06/15", 2567, "545454Q", 12);

INSERT INTO reserva(dni,numero,entrada,salida) VALUES
	("111111", 101, "2025/02/01", "2025/02/04"),
	("111111", 102, "2025/03/01", "2025/03/04"),
	("222222", 300, "2025/02/02", "2025/02/04"),
	("777777", 203, "2025/02/17", "2025/02/19"),
	("777777", 204, "2025/03/25", "2025/03/27"),
	("999999", 200, "2025/03/11", "2025/03/15");

INSERT INTO factura(codigoF,entrada,salida,dni,numero,supletoria,forma) VALUES
	(0, "2024/01/01", "2019/01/05", "999999", 300, 0, "Tarjeta"),
	(1, "2024/01/01", "2019/01/03", "111111", 100, 30, "Efectivo"),
	(2, "2024/06/01", "2019/06/03", "111111", 100, 30, "Efectivo"),
	(3, "2024/09/01", "2019/09/03", "111111", 100, 30, "Efectivo"),
	(4, "2025/01/19", NULL, "111111", 100, 0, "Efectivo"),
	(5, "2025/01/15", NULL, "333333", 200, 0, "Tarjeta"),
	(6, "2025/01/17", NULL, "999999", 204, 30, "Talón"),
	(7, "2025/01/20", NULL, "555555", 300, 0, "Efectivo"),
	(8, "2025/01/22", NULL, "777777", 301, 30, "Tarjeta"),
	(9, "2024/05/15", "2019/05/17", "999999", 301, 0, "Tarjeta"),
	(10, "2024/08/10", "2019/08/13", "333333", 300, 0, "Tarjeta"),
	(11, "2024/08/15", "2019/08/22", "888888", 102, 0, "Tarjeta"),
	(12, "2024/12/23", "2019/12/24", "444444", 201, 0, "Talón"),
	(13, "2024/05/01", "2019/05/05", "999999", 300, 0, "Efectivo"),
	(14, "2024/06/11", "2019/06/06", "555555", 203, 0, "Tarjeta"),
	(15, "2024/08/15", "2019/08/19", "555555", 203, 0, "Tarjeta"),
	(16, "2024/08/15", "2019/08/19", "666666", 203, 0, "Efectivo"),
	(17, "2024/08/15", "2019/08/19", "666666", 203, 0, "Tarjeta");
    
INSERT INTO incluye(codigoF,codS,coste,fecha) VALUES
	(1, 1, 25, "2024/01/01"),
	(1, 2, 15, "2024/01/01"),
	(3, 3, 25, "2024/09/01"),
	(3, 3, 25, "2024/09/02"),
	(3, 3, 25, "2024/09/03"),
	(3, 2, 10, "2024/09/01"),
	(3, 2, 20, "2024/09/03"),
	(3, 1, 10, "2024/09/01"),
	(3, 5, 43, "2024/09/02"),
	(5, 5, 25, "2025/01/15"),
	(5, 5, 28, "2025/01/16"),
	(5, 5, 33, "2025/01/17"),
	(5, 5, 24, "2025/01/18"),
	(5, 3, 13, "2025/01/16"),
	(7, 6, 20, "2025/01/20"),
	(9, 4, 6, "2024/05/15"),
	(9, 4, 8, "2024/05/16"),
	(9, 5, 24, "2024/05/16"),
	(13, 2, 10, "2024/05/03"),
	(13, 2, 10, "2024/05/04"),
	(15, 5, 45, "2024/08/15"),
	(15, 4, 5, "2024/08/15"),
	(15, 2, 13, "2024/08/15"),
	(16, 5, 32, "2024/08/15"),
	(17, 1, 10, "2024/08/15"),
	(17, 5, 30, "2024/08/16");
    
#################################### PRACTICA 2 - SEGUNDA EVALUACIÓN #################################
USE practica_hotel;

#Apartado A- Realizar las siguientes actualizaciones de datos en la tabla Empleado.

# 1. Donde el NumReg sea 1 debes poner el valor de CodS a 1.
UPDATE empleado set codS = 1 where numReg = 1;
# 2. Donde el NumReg sea 2 debes poner el valor de CodS a 2.
UPDATE empleado set codS = 2 where numReg = 2;
# 3. Donde el NumReg sea 3 debes poner el valor de CodS a 3.
UPDATE empleado set codS = 3 where numReg = 3;
# 4. Donde el NumReg sea 4 debes poner el valor de CodS a 4.
UPDATE empleado set codS = 4 where numReg = 4;
# 5. Donde el NumReg sea 5 debes poner el valor de CodS a 1.
UPDATE empleado set codS = 1 where numReg = 5;
# 6. Donde el NumReg sea 6 debes poner el valor de CodS a 5.
UPDATE empleado set codS = 5 where numReg = 6;
# 7. Donde el NumReg sea 7 debes poner el valor de CodS a 5.
UPDATE empleado set codS = 5 where numReg = 7;
# 8. Donde el NumReg sea 8 debes poner el valor de CodS a 5.
UPDATE empleado set codS = 5 where numReg = 8;
# 9. Donde el NumReg sea 9 debes poner el valor de CodS a 6.
UPDATE empleado set codS = 6 where numReg = 9;

##Apartado B - Automatizar, mediante SQL una serie de procesos y consultas, para lo cual, se debe crear los scripts SQL necesarios.

#1- Obtener un listado de los empleados del hotel, con todos sus datos.
SELECT * from empleado;

#2- Obtener el jefe del servicio “Restaurante”.
SELECT empleado.nombre from empleado
inner join servicio
on servicio.numReg = empleado.numReg
where servicio.descripcion like 'Restaurante';

#3- Obtener el nombre del jefe de “Jorge Alonso Alonso”.
SELECT empleado.nombre from empleado
inner join servicio
on servicio.numReg = empleado.numReg
where servicio.codS = (SELECT codS from empleado  where empleado.nombre like '%Jorge%Alonso%Alonso%');

#4- Obtener un listado de los empleados y los servicios a los que están asignados, exclusivamente para aquellos que tengan algún servicio asignado.
SELECT empleado.nombre, servicio.descripcion from empleado
inner join servicio
on servicio.codS = empleado.codS
where empleado.codS is not null;

#5- Obtener el número de habitación y el tipo de las habitaciones que estén ocupadas en la actualidad (no tienen fecha de salida).
ALTER TABLE reserva modify salida date null; #Modifico la tabla para aceptar valores nulos en la columna salida
INSERT INTO reserva(dni,numero,entrada,salida) VALUES
	("333333", 101, "2025/02/01", null); #Inserto nuevos datos para que haya devolución

SELECT habitacion.numero, habitacion.tipo from habitacion
where numero in (SELECT numero from reserva where salida is null);

#6- Obtener los datos del empleado o empleados que hayan limpiado todas las habitaciones del hotel.
SELECT empleado.*
from empleado
inner join limpieza 
on empleado.numReg = limpieza.numReg
group by empleado.numReg, empleado.nombre
having count(distinct limpieza.numero) = (SELECT count(habitacion.numero) from habitacion);

#7- Obtener el listado de los clientes que ocupen o hayan ocupado alguna habitación de los dos tipos (“Individual” y “Doble”).
SELECT distinct cliente.* from cliente
inner join reserva
on cliente.dni = reserva.dni
where reserva.dni in (SELECT reserva.dni from reserva
					  inner join habitacion
					  on reserva.numero = habitacion.numero
					  where habitacion.tipo like 'Doble') and reserva.dni in
					 (SELECT reserva.dni from reserva
					  inner join habitacion
					  on reserva.numero = habitacion.numero
					  where habitacion.tipo like 'Individual');
                      
# 8. Obtener un listado de los proveedores cuyas facturas hayan sido aprobadas
# únicamente por el encargado y no por el responsable de un servicio.

SELECT distinct proveedor.* from proveedor
inner join factura_prov
on proveedor.numReg = factura_prov.numReg
where factura_prov.numReg not in (SELECT numReg from empleado where numReg in (SELECT numReg from servicio)); # Doy por hecho que el responsable es el que no se encuentra en proveedor.numReg