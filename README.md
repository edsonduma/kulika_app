# kulika

A new app to price survey.

## Introdução

Este projecto tem como objectivo principal disponiblizar
os melhores precos do mercado entre outros.

Foi desenvolvido com Flutter, Laravel  e PostgreSQL.


## Passos para correr o projecto Flutter (app):

Para arrancar o projecto numa nova maquina, é necessario
criar .env file e configurar devidamente o IP da maquina no ficheiro conforme o exemplo .env.example
- OBS:(não poderá ser usado "localhost" ou "127.0.0.1" porque queremos aceder ao servidor externo do emulador)

## Passos para correr o servidor Backend

- Executar o comando abaixo:
php artisan serve --host 0.0.0.0


## Restore da Base de Dados
- o backup da base de dados está na pasta "BACKups database" do BACKEND kulipa-api

criar a "baratuxo_db" no PostgreSQL

- Caso haja problemas no restore, usar o comando abaixo:

sudo psql -U postgres -d baratuxo_db < baratuxo_db_12122023_1954.sql