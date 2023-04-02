with datos_dulce as (
	select
	'dulce_' || seq as nombre,
	(
		case (random() * 3)::int
			when 0 then 'dulce'
			when 1 then 'salado'
			when 2 then 'picoso'
			when 3 then 'acidulzado'
		end
	) as tipo,
	(
		case (random() * 3)::int
			when 0 then 'marinela'
			when 1 then 'sabritas'
			when 2 then 'nestle'
			when 3 then 'loquesea'
		end
	) as marca,
	(random() * 10000) as precio_adquisicion
	from GENERATE_SERIES(1, 100) seq
)
insert into dulce(nombre, tipo, marca, precio_adquisicion) select * from datos_dulce;
select * from dulce;

with datos_empresa as (
	select
	'empresa_' || seq AS nombre,
	'representante_' || seq AS representante
	from GENERATE_SERIES(1, 100) seq
)
insert into empresa(nombre, representante) select * from datos_empresa;
select * from empresa;

with datos_cuenta as (
	select
	empresa_id,
	CAST(100000000000000000 + floor(random() * 900000000000000000) as bigint) as clabe,
	(
		case (random() * 2)::int
			when 0 then 'Banamex'
			when 1 then 'Bancomer'
			when 2 then 'BBVA'
		end
	) as banco,
	'administrador_' || seq as administrador
	from GENERATE_SERIES(0, (select count(empresa_id) from empresa)) seq
	inner join empresa ON (seq = empresa_id)
)
insert into cuenta_bancaria(empresa_id, clabe, banco, administrador) select * from datos_cuenta;
select * from cuenta_bancaria;

with expanded as (
	select random(), seq, empresa_id
	FROM GENERATE_SERIES(1, 100) seq, empresa
), shuffled as (
	select
	date(current_date + (random() * 365 * 5)::int) as vigencia,
	e.empresa_id
	from expanded e
	inner join (
		select ei.seq, MIN(ei.random) from expanded ei group by ei.seq
	) em ON (e.seq = em.seq AND e.random = em.min)
)
insert into contrato(vigencia, empresa_id) select * from shuffled;
select * from contrato;

do $$
declare
	counter integer := 0;
begin
	while counter < (select count(contrato_id) from contrato) loop
		if (random())::int = 0 then
			insert into contrato_1a(contrato_id, precio_maquina) values(counter, random() * 10000);
		else
			insert into contrato_1b(contrato_id, fecha_resurtir, precio_maquina) values(counter, date(current_date + 30), random() * 10000);
		end if;
		counter := counter + 1;
	end loop;
end$$;

select * from contrato_1a;
select * from contrato_1b;

with datos_contrato_dulce as (
	select
	random() * 10000 as precio_dulces,
	random() * ((select count(dulce_id) from dulce) - 1) as dulce_id,
	contrato_id
	from GENERATE_SERIES(0, 10000) seq
	inner join contrato_1b ON (seq = contrato_id)
)
insert into contrato_1b_dulce(precio_dulces, dulce_id, contrato_id) select * from datos_contrato_dulce;
select * from contrato_1b_dulce;


with datos_maquina as (
	select
	(
		case (random() * 4)::int
			when 0 then 'Vibranium'
			when 1 then 'Acero'
			when 2 then 'Aluminio'
			when 3 then 'Plástico'
			when 4 then 'Cartón'
		end
	) as nombre,
	(
		case (random() * 2)::int
			when 0 then 'Linux'
			when 1 then 'Windows'
			when 2 then 'BSD'
		end
	) as tipo_sistema_operativo,
	CAST(1000000000 + floor(random() * 9000000000) as bigint) as num_registro,
	empresa_id,
	contrato_id
	from GENERATE_SERIES(0, 10000) seq
	inner join contrato ON (seq = contrato_id)
)
insert into maquina(material, tipo_sistema_operativo, num_registro, empresa_id, contrato_id) select * from datos_maquina;
select * from maquina;

do $$
declare
	counter integer := 0;
		valor integer := 0;
begin
	while counter < (select count(maquina_id) from maquina) loop
		valor := (random() * 2)::int;
		if valor = 0 then
			insert into tipo_A(
				maquina_id,
				dimensiones,
				capacidad
			)
			values(
				counter,
				'135x200x135',
				25
			);
		elsif valor = 2 then
			insert into tipo_B(
				maquina_id,
				dimensiones,
				capacidad,
				vidrio_reforzado,
				alerta,
				candados
			)
			values(
				counter,
				'150x200x140',
				35,
				'Vidrio marca Acme',
				'alerta.wav',
				'los más baratos'
			);
		else
			insert into tipo_C(
				maquina_id,
				dimensiones,
				capacidad,
				vidrio_templado,
				alerta,
				candados,
				camara
			)
			values(
				counter,
				'135x200x135',
				50,
				'Vidrio marca Acme',
				'alerta.wav',
				'los más baratos',
				'Go Pro'
			);

		end if;
		counter := counter + 1;
	end loop;
end$$;

select * from tipo_A;
select * from tipo_B;
select * from tipo_C;
