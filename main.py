#!/bin/python3

from DataBase import *

db = DataBase('postgres', 'mysecretpassword', '127.0.0.1', '6969', 'distromachines')

resultado = db.generarConsulta('SELECT * FROM empresa')

for elemento in resultado:
    print('id: ', elemento['empresa_id'])
