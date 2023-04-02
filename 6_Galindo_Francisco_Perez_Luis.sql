delete from empresa where nombre='empresa_6';
delete from empresa where nombre='empresa_18';
delete from empresa where nombre='empresa_56';

delete from dulce where tipo='salado';

delete from cuenta_bancaria where banco='BBVA';

delete from contrato where vigencia > to_date('01/01/2027','DD/MM/YYYY');

delete from contrato_1a where precio_maquina <3000; 

delete from contrato_1b where precio_maquina <3000; 

delete from tipo_A where maquina_id >25; /*Se hace de esta manera por que el tipo se distribuye aleatoriameente*/

delete from tipo_B where maquina_id >25;

delete from tipo_C where maquina_id >25;

delete from maquina where tipo_sistema_operativo='BSD'; 



