# MC2 LE3

## Env variables:
<br>
add these .env local in a .env file or in the env variables
<br><br>
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
<br>


## Docker 
https://hub.docker.com/_/arangodb

docker run -e ARANGO_RANDOM_ROOT_PASSWORD=1 -d --name arangodb-instance arangodb

## DB User muss nicht manuell eingerichtet werden, da er wenn die env variablen richtig gesetzt sind automatisch erstellt im script:

### Will man dennoch einen User Manuell anlegen hier:

![image](https://user-images.githubusercontent.com/32195170/211159486-1ebd168f-11cf-418d-8ee6-410e2e9b1643.png)
<br>
Erstelle ein User für deine Datenbank

![image](https://user-images.githubusercontent.com/32195170/211159530-e50894d6-53d5-4fa1-abca-1a819e08128e.png)

<br>
 
Gib dem User die Berechtigungen auf die Datenbank:

![image](https://user-images.githubusercontent.com/32195170/211159553-e5f816cf-992d-42f8-88b8-c12d46db870e.png)

<br>

bearbeite nun die .env mit den Werten deines neu angelegten Users:
<br>
arango_username=fillusername
<br>
arango_password=fillpassword
<br>
arango_database=filldatabase


## Python run the Notebook with Python 3.10

![image](https://user-images.githubusercontent.com/32195170/211159621-dcc38468-2dfe-4c88-80d9-9404a020fc89.png)

![image](https://user-images.githubusercontent.com/32195170/211159626-ad100938-12c2-421f-9faf-51b415e6155a.png)

