\c postgres postgres
drop database distromachines;
create database distromachines encoding 'utf-8';
\c distromachines

create sequence empresa_seq increment by 1 minvalue 0 no maxvalue;
create sequence cuenta_seq increment by 1 minvalue 0 no maxvalue;
create sequence dulce_seq increment by 1 minvalue 0 no maxvalue;
create sequence contrato_seq increment by 1 minvalue 0 no maxvalue;
create sequence maquina_seq increment by 1 minvalue 0 no maxvalue;
create sequence contrato_1b_dulce_seq increment by 1 minvalue 0 no maxvalue;

create table empresa (
	empresa_id numeric(10, 0) default nextval('empresa_seq'),
	nombre varchar(100) not null,
	representante varchar(100) not null,
	constraint empresa_pk
		primary key (empresa_id)
);


create table dulce (
	dulce_id numeric(10, 0) default nextval('dulce_seq'),
	nombre varchar(60) not null,
	tipo varchar(20) not null,
	marca varchar(60) not null,
	precio_adquisicion numeric(7, 2) not null,
	constraint dulce_pk
		primary key (dulce_id)
);

create table cuenta_bancaria (
	cuenta_bancaria_id numeric(10, 0) default nextval('cuenta_seq'),
	empresa_id numeric(10, 0) not null,
	clabe char(18) not null,
	banco varchar(40) not null,
	administrador varchar(100) not null,
	constraint empresa_cuenta_fk
		foreign key (empresa_id)
		references empresa(empresa_id)
		on delete cascade on update cascade,
	constraint cuenta_pk
		primary key (cuenta_bancaria_id, empresa_id)
);

create table contrato (
	contrato_id numeric(10, 0) default nextval('contrato_seq'),
	vigencia date not null,
	empresa_id numeric(10, 0) not null,
	constraint empresa_contrato_fk
		foreign key (empresa_id)
		references empresa(empresa_id)
		on delete cascade on update cascade,
	constraint contrato_pk
		primary key (contrato_id)
);

create table contrato_1a (
	contrato_id numeric(10, 0) not null,
	precio_maquina numeric(10,2) not null,
	constraint contrato_contrato_1a_fk
		foreign key (contrato_id)
		references contrato(contrato_id)
		on delete cascade on update cascade,
	constraint contrato_1a_pk
		primary key (contrato_id)
);

create table contrato_1b (
	contrato_id numeric(10, 0) not null,
	precio_maquina numeric(10,2) not null,
	fecha_resurtir date not null,
	constraint contrato_contrato_1b_fk
		foreign key (contrato_id)
		references contrato(contrato_id)
		on delete cascade on update cascade,
	constraint contrato_1b_pk
		primary key (contrato_id)
);

create table maquina (
	maquina_id numeric(10, 0) default nextval('maquina_seq'),
	material varchar(40) not null,
	tipo_sistema_operativo varchar(40) not null,
	num_registro varchar(10) not null,
	empresa_id numeric(10, 0) not null,
	contrato_id numeric(10, 0) not null,
	constraint empresa_maquina_fk
		foreign key (empresa_id)
		references empresa(empresa_id)
		on delete cascade on update cascade,
	constraint contrato_maquina_fk
		foreign key (contrato_id)
		references contrato(contrato_id)
		on delete cascade on update cascade,
	constraint maquina_pk
		primary key (maquina_id)
);

create table tipo_A (
	maquina_id numeric(10, 0) not null,
	dimensiones varchar(12),
	capacidad numeric(2, 0) not null,
	constraint maquina_tipo_A_fk
		foreign key (maquina_id)
		references maquina(maquina_id)
		on delete cascade on update cascade,
	constraint tipo_A_pk
		primary key (maquina_id)
);

create table tipo_B (
	maquina_id numeric(10, 0) not null,
	dimensiones varchar(12),
	capacidad numeric(2, 0) not null,
	vidrio_reforzado varchar(20) not null,
	alerta varchar(20) null,
	candados varchar(20) null,
	constraint maquina_tipo_C_fk
		foreign key (maquina_id)
		references maquina(maquina_id)
		on delete cascade on update cascade,
	constraint tipo_C_pk
		primary key (maquina_id)
);

create table tipo_C (
	maquina_id numeric(10, 0) not null,
	dimensiones varchar(12),
	capacidad numeric(2, 0) not null,
	vidrio_templado varchar(20) not null,
	alerta varchar(20) not null,
	candados varchar(20) not null,
	camara varchar(20) not null,
	constraint tipo_C_fk
		foreign key (maquina_id)
		references maquina(maquina_id)
		on delete cascade on update cascade,
	constraint maquina_tipo_C_pk
		primary key (maquina_id)
);

create table contrato_1b_dulce (
	contrato_1b_dulce_id numeric(10, 0) default nextval('contrato_1b_dulce_seq'),
	precio_dulces numeric(10, 2) not null,
	dulce_id numeric(10, 0) not null,
	contrato_id numeric(10, 0) not null,
	constraint contrato_1b_contrato_1b_dulce_fk
		foreign key (contrato_id)
		references contrato(contrato_id)
		on delete cascade on update cascade,
	constraint dulce_contrato_1b_dulce_fk
		foreign key (dulce_id)
		references dulce(dulce_id)
		on delete cascade on update cascade,
	constraint contrato_1b_dulce_pk
		primary key (contrato_1b_dulce_id)
);
