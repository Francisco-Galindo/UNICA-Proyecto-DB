import psycopg2
import psycopg2.extras
from psycopg2 import Error

class DataBase():
    def __init__(self, user, password, host, port, database):
        self.connection = self.iniciarConexion(user, password, host, port, database)

        if self.connection:
            self.cursor = self.connection.cursor(
                cursor_factory=psycopg2.extras.RealDictCursor
            )

    def iniciarConexion(self, user, password, host, port, database):
        try:
            connection = psycopg2.connect(
                user=user,
                password=password,
                host=host,
                port=port,
                database=database
            )

            return connection

        except (Exception, Error) as error:
            print("No se pudo conectar a la base de datos: ", error)
            return None

    def generarConsulta(self, query):
        self.cursor.execute(query)
        resultado = self.cursor.fetchall()

        return resultado
