# MC2 LE3

## Env variables:
<br>
add these .env local in a .env file or in the env variables
arango_username=fillusername
<br>
arango_password=fillpassword
<br>
arango_database=filldatabase
<br>
sys_username_arango=fillrootuser
<br>
sys_password_arango=fillrootpassword
<br>
## Docker 
https://hub.docker.com/_/arangodb

docker run -e ARANGO_RANDOM_ROOT_PASSWORD=1 -d --name arangodb-instance arangodb

## Python run the Notebook with Python 3.10
