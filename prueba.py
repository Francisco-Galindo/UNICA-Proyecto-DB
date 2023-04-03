import psycopg2
import psycopg2.extras
from psycopg2 import Error

connection = None
try:
    connection = psycopg2.connect(user="postgres",
                                  password="postgres",
                                  host="127.0.0.1",
                                  port="5432",
                                  database="distromachines")

    cursor = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

    cursor.execute("select nombre,representante from empresa join maquina \
                   on empresa.empresa_id=maquina.empresa_id join tipo_C on \
                   maquina.maquina_id=tipo_C.maquina_id;")
    resultado = cursor.fetchall()

    for elemento in resultado:
        print("nombre: ", elemento["nombre"],"  Representante: ", elemento["representante"])
    print("\n\n")


    cursor.execute("select count(b.contrato_id) as numero_contratos_maquina_A \
                   from contrato_1b b join contrato c on  b.contrato_id=c.contrato_id \
                   join maquina m on c.contrato_id=m.contrato_id join tipo_a a on m.maquina_id=a.maquina_id;")
    resultado = cursor.fetchall()
    for elemento in resultado:
        print("Contratos con maquina tipo A: ", elemento["numero_contratos_maquina_a"])
    print("\n\n")

    
    cursor.execute("select nombre,precio_dulces from empresa e join contrato c \
                   on e.empresa_id=c.empresa_id join contrato_1b b on c.contrato_id=b.contrato_id\
                    join contrato_1b_dulce bd on b.contrato_id=bd.contrato_id where precio_dulces>5000 order by precio_dulces asc;")
    resultado = cursor.fetchall()
    for elemento in resultado:
        print("Nombre: ", elemento["nombre"], "   Precio: ", elemento["precio_dulces"])
    print("\n\n")

    cursor.execute("select 'B' as tipo, count(*) as numero from tipo_B UNION select 'C' as tipo, count(*) as numero from tipo_C;")
    resultado = cursor.fetchall()
    for elemento in resultado:
        print("tipo", elemento["tipo"], "\tcantidad:",elemento["numero"] )
    print("\n\n")


except (Exception, Error) as error:
    print("No se pudo conectar a la base de datos:", error)

finally:
    if connection:
        cursor.close()
        connection.close()
        print("Bye")
