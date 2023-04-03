#!/bin/python3

from DataBase import *

db = DataBase('postgres', 'mysecretpassword', '127.0.0.1', '6969', 'distromachines')

resultado = db.generarConsulta("select nombre,representante from empresa join maquina \
               on empresa.empresa_id=maquina.empresa_id join tipo_C on \
               maquina.maquina_id=tipo_C.maquina_id;")
for elemento in resultado:
    print("nombre: ", elemento["nombre"],"  Representante: ", elemento["representante"])
print("\n\n")

resultado = db.generarConsulta("select count(b.contrato_id) as numero_contratos_maquina_A \
               from contrato_1b b join contrato c on  b.contrato_id=c.contrato_id \
               join maquina m on c.contrato_id=m.contrato_id join tipo_a a on m.maquina_id=a.maquina_id;")
for elemento in resultado:
    print("Contratos con maquina tipo A: ", elemento["numero_contratos_maquina_a"])
print("\n\n")


resultado = db.generarConsulta("select nombre,precio_dulces from empresa e join contrato c \
               on e.empresa_id=c.empresa_id join contrato_1b b on c.contrato_id=b.contrato_id\
                join contrato_1b_dulce bd on b.contrato_id=bd.contrato_id where precio_dulces>5000 order by precio_dulces asc;")
for elemento in resultado:
    print("Nombre: ", elemento["nombre"], "   Precio: ", elemento["precio_dulces"])
print("\n\n")


resultado = db.generarConsulta("select 'B' as tipo, count(*) as numero from tipo_B UNION select 'C' as tipo, count(*) as numero from tipo_C;")
for elemento in resultado:
    print("tipo", elemento["tipo"], "\tcantidad:",elemento["numero"] )
print("\n\n")


print("Modo interactivo")
print("Escribe 'salir' para... salir...")
query = ""
while True:
    query = input('$ ')
    if query == 'salir':
        break

    resultado = db.generarConsulta(query)

    if resultado:
        print("\t".join(resultado[0].keys()))
        for elemento in resultado:
            fila = list(map(lambda x: str(x), list(elemento.values())))
            print("\t".join(fila))
