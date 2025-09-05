<?php
echo "Olá Mundo!";
?> 

import mysql.connector

# connect to the MySql server
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="senaisp",
    database="avaliacao"
)
cursor = conn.cursor()

# run a query 
cursor.execute("SELECT * FROM users")