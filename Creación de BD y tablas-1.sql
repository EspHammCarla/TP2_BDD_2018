create database DB_MundialesDeFutbol
go

use DB_MundialesDeFutbol
go
create table Pais
(
	codigo int,
	nombre varchar(20) not null,
	constraint pk_pais primary key (codigo)
);
go

create table Ciudad
(
	codigo int,
	nombre varchar(20) not null,
	cod_Pais int not null,
	constraint pk_ciudad primary key (codigo),
	constraint fk_CiudadPais foreign key (cod_Pais)
		references Pais(codigo)
);
go

create table Mundial
(
	año smallint,
	constraint pk_mundial primary key (año)
);
go

create table Integrante
(
	pasaporte int,
	fecha_de_nacimiento date not null,
	nombre varchar(15) not null,
	apellido varchar(15) not null,
	constraint pk_integrante primary key (pasaporte)
);
go

create table Director_tecnico
(
	pasaporte int,
	matricula int not null,
	constraint pk_DT primary key (pasaporte),
	constraint fk_DT foreign key (pasaporte)
		references Integrante (pasaporte)
);
go
create table Jugador
(
	pasaporte int,
	constraint pk_jugador primary key (pasaporte),
	constraint fk_jugador foreign key (pasaporte)
		references Integrante (pasaporte)
);
go

create table Es_anfitrion_de
(
	cod_pais int,
	año_mundial smallint,
	constraint pk_EsAnfDe primary key (cod_pais,año_mundial),
	constraint fk_EsAnf_Pais foreign key (cod_pais)
		references Pais (codigo),
	constraint fk_EsANf_Mundial foreign key (año_mundial)
		references Mundial(año)
);
go

create table Grupo
(
	id int,
	descripcion char(4) not null,
	constraint pk_grupo primary key (id)
);
go
create table Instancia
(
	id int,
	descripcion varchar(10) not null,
	constraint pk_instancia primary key (id)
);
go
create table Estadio
(
	id int,
	nombre varchar(30) not null,
	cod_ciudad int not null,
	constraint pk_estadio primary key (id),
	constraint fk_EstadioCiudad foreign key (cod_ciudad)
		references Ciudad(codigo)
);
go

create table Equipo
(
	cod_pais int,
	año_mundial smallint,
	tarjetas_rojas smallint not null,
	tarjetas_amarillas smallint not null,
	pasaporte_DT int not null,
	constraint pk_equipo primary key (cod_pais,año_mundial),
	constraint fk_EquipoPais foreign key (cod_pais)
		references Pais(codigo),
	constraint fk_EquipoMundial foreign key (año_mundial)
		references Mundial(año),
	constraint fk_EquipoDT foreign key (pasaporte_DT)
		references Director_tecnico(pasaporte)
);
go

create table Partido
(
	nro smallint,
	año_mundial smallint,
	cod_pais_1 int not null,
	cod_pais_2 int not null,
	fecha_y_hora smalldatetime not null,
	id_instancia int not null,
	id_grupo int,
	id_estadio int not null,
	constraint pk_partido primary key (nro, año_mundial),
	constraint fk_PartidoMundial foreign key (año_mundial)
		references Mundial(año),
	constraint fk_PartidoInstancia foreign key (id_instancia)
		references Instancia(id),
	constraint fk_PartidoGrupo foreign key (id_grupo)
		references Grupo(id),
	constraint fk_PartidoEstadio foreign key (id_estadio)
		references Estadio(id),
	constraint fk_PartidoEq1 foreign key (cod_pais_1, año_mundial)
		references Equipo(cod_pais, año_mundial),
	constraint fk_PartidoEq2 foreign key (cod_pais_2, año_mundial)
		references Equipo(cod_pais, año_mundial)
);
go

create table Juega_en
(
	pasaporte_jug int,
	cod_pais int,
	año_mundial smallint,
	nro_camiseta smallint not null,
	es_titular char(2) not null,
	constraint pk_juegaEn primary key (pasaporte_jug,cod_pais,año_mundial),
	constraint fk_JuegaEnJugador foreign key (pasaporte_jug)
		references Jugador(pasaporte),
	constraint fk_JuegaEnMundial foreign key (año_mundial)
		references Mundial(año),
	constraint fk_JuegaEnPais foreign key (cod_pais)
		references Pais(codigo)
);
go

create table Tipo_gol
(
	id smallint,
	descripcion varchar(30) not null,
	constraint pk_tipoGol primary key (id)
);
go

create table Gol
(
	min_seg timestamp,
	nro_partido smallint,
	año_mundial smallint,
	id_tipoGol smallint not null,
	pasaporte_jug int not null,
	en_contra char(2) not null,
	constraint pk_gol primary key (min_seg, nro_partido, año_mundial),
	constraint fk_GolPartido foreign key (nro_partido, año_mundial)
		references Partido(nro, año_mundial),
	constraint fk_GolTipoGol foreign key (id_tipoGol)
		references Tipo_gol(id),
	constraint fk_GolJugador foreign key (pasaporte_jug)
		references Jugador(pasaporte)
);