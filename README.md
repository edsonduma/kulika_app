# kulika

A new app to price survey.

## Introdução

Este projecto tem como objectivo principal disponiblizar
os melhores precos do mercado entre outros.

Foi desenvolvido com Flutter, Laravel  e PostgreSQL.


## Passos para correr o projecto Flutter (app):

Para arrancar o projecto numa nova maquina, é necessario
criar e configurar devidamente o ip da maquina no .env file 
igual ao .env.example

## Passos para correr o servidor Backend

- Executar o comando abaixo:
php artisan serve --host 0.0.0.0


## Restore da Base de Dados
- Caso haja problemas no restore, usar os comando abaixo

sudo ./psql -U postgres -d baratuxo_db < ~/Documents/baratuxo_db_12122023_1954.sql