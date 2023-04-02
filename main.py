#!/bin/python3

import psycopg2
import psycopg2.extras
from psycopg2 import Error

connection = None
try:
    connection = psycopg2.connect(user="postgres",
                                  password="mysecretpassword",
                                  host="127.0.0.1",
                                  port="6969",
                                  database="distromachines")

    cursor = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

    cursor.execute("SELECT * FROM empresa")
    resultado = cursor.fetchall()

    for elemento in resultado:
        print("id: ", elemento["empresa_id"])

except (Exception, Error) as error:
    print("No se pudo conectar a la base de datos:", error)

finally:
    if connection:
        cursor.close()
        connection.close()
        print("Bye")
