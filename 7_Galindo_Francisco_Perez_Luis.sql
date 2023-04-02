select nombre,representante
from empresa
join maquina on empresa.empresa_id=maquina.empresa_id
join tipo_C on maquina.maquina_id=tipo_C.maquina_id;

select count(b.contrato_id) as numero_contratos_maquina_A /*dudosa*/
from contrato_1b b
join contrato c on  b.contrato_id=c.contrato_id
join maquina m on c.contrato_id=m.contrato_id
join tipo_a a on m.maquina_id=a.maquina_id;

select nombre,precio_dulces
from empresa e
join contrato c on e.empresa_id=c.empresa_id
join contrato_1b b on c.contrato_id=b.contrato_id
join contrato_1b_dulce bd on b.contrato_id=bd.contrato_id
where precio_dulces>5000
order by precio_dulces asc;

select count(*) as Numero_Tipo_A
from tipo_A;

select count(*) as Numero_Tipo_B
from tipo_B;