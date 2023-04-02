#!/bin/python3

import psycopg2
from psycopg2 import Error

connection = None
try:
    connection = psycopg2.connect(user="postgres",
                                  password="mysecretpassword",
                                  host="127.0.0.1",
                                  port="6969",
                                  database="distromachines")

    cursor = connection.cursor()

    cursor.execute("SELECT * FROM empresa")
    resultado = cursor.fetchall()
    print("RESULTADO CHIDO: ", resultado)
except (Exception, Error) as error:
    print("No se pudo conectar a la base de datos:", error)
finally:
    if connection:
        cursor.close()
        connection.close()
        print("Bye")
