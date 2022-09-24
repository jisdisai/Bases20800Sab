create table hotel(
	codigo integer not null primary key,
	nombre varchar(60) not null,
	direccion varchar(60) 
);

create table cliente(
	identidad varchar(15) primary key not null,
	nombre varchar(60),
	telefono integer not null,
	codigo integer not null
);

alter table cliente add constraint fk_codigo
foreign key (codigo) references hotel(codigo)

create table reserva(
	 codigo integer not null,
	 identidad varchar(15) not null,
	 fecha_inicio date not null ,
	 fecha_final date not null,
	 cantidad_personas integer
);

alter table reserva add constraint pk_codigo_reserva
primary key (codigo,identidad)


create table boleto(
	codigo_boleto integer not null primary key,
	numero_vuelo integer not null,
	fecha date not null,
	destino varchar(60),
	identidad varchar(15) not null
);

alter table boleto add constraint fk_identidad
foreign key (identidad) references cliente(identidad)

create table aerolinea(
	codigo_aerolinea integer not null primary key, 
	descueto varchar(60),
	codigo_boleto integer not null
);

alter table aerolinea add constraint fk_codigo_boleto
foreign key (codigo_boleto) references boleto(codigo_boleto)

select * from hotel;
select * from cliente;
select * from reserva;
select * from aerolinea;
select * from boleto;


insert into hotel values (001,'palmira','suyapa');
insert into hotel values (002,'providencia','comayaguela');

insert into cliente values ('0801-1990-20027','Isai salgado',334040802,001);
insert into cliente values ('0801-1992-45688','Fernando Velasquez',998878788,002);

insert into reserva values (001,'0801-1990-20027','24-08-2022','30-08-2022',default);
insert into reserva values (002,'0801-1992-45688','28-08-2022','10-09-2022',default);


alter table aerolinea add constraint ck_descueto
check(descueto <>10)


alter table boleto add constraint ck_destino
check (destino in ('mexico','guatemala','canada'))
