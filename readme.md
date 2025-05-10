# 🧩 Microservicios Orquestador

Este repositorio orquesta los microservicios `pedidos-service` (Java Spring Boot) y `inventory-service` (Node.js), junto con una base de datos PostgreSQL, usando Docker Compose.

## 🏗️ Estructura del Proyecto
orquestator-microservices/
├── docker-compose.yml
├── .env                      # Variables de entorno del orquestador
├── order-service/          # Submódulo Git (Spring Boot)
├── inventory-service/        # Submódulo Git (Node.js, contiene su propio .env)

---

## 🚀 Requisitos

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- (Solo si compilas Spring Boot localmente): [Maven](https://maven.apache.org/) y [Java 21](https://jdk.java.net/21/)

---

## 🧬 Clonación del proyecto

Clona el repositorio junto con los submódulos:

```bash
git clone --recurse-submodules https://github.com/joeln18/orquestator-microservices.git
cd orquestator-microservices

Si ya habías clonado sin los submódulos, puedes inicializarlos con:
git submodule update --init --recursive
```

⚙️ ## Configuración de Variables de Entorno

🗂️ Orquestador
Crea un archivo .env en la raíz del proyecto con el siguiente contenido:

```env
PORT_NODE=3000
DB_PORT=5432
PORT_JAVA=8080
DB_USER=tu_usuario
DB_HOST=postgres
DB_DATABASE=restaurante
DB_PASSWORD=tu_password
RABBITMQ_HOST=rabbitmq
RABBITMQ_PORT=5672
RABBITMQ_USER=guest
RABBITMQ_PASSWORD=guest
```
⚠️ Nota: DB_HOST=postgres hace referencia al nombre del servicio del contenedor definido en docker-compose.yml.

🧾 Inventory Service
Asegúrate de que dentro de inventory-service exista un archivo .env con la conexión a PostgreSQL:

```env
PORT=3000
DB_USER=tu_usuario
DB_HOST=localhost
DB_DATABASE=restaurante
DB_PASSWORD=tu_password
DB_PORT=5432
SONAR_TOKEN=token_sonar_solo_para_ejecutar
RABBITMQ_HOST=rabbitmq
```
🧾 Pedido Service
Agrega las siguientes variables de entorno antes de construir el .jar.
```env
DB_USER_POSTGRES=tu_usuario_postgres
DB_PASSWORD_POSTGRES=tu_password_postgres
RABBITMQ_SP_HOST=rabbitmq
RABBITMQ_SP_PORT=5672
RABBITMQ_SP_USER=guest
RABBITMQ_SP_PASSWORD=guest
```

🔨 Compilación de order-service (Spring Boot)

Antes de levantar los servicios con Docker, asegúrate de tener el .jar listo. Para eso:

```
cd order-service
mvn clean package
```
Esto generará un archivo .jar en target/, por ejemplo:
target/pedidos-service-0.0.1-SNAPSHOT.jar

Este archivo es el que será usado en el contenedor Docker.

⚙️ ## Permisos de lectura sobre scripts

```
chmod +x init-scripts/fill_tables_inventory.sql
chmod +x init-scripts/fill_tables_order.sql
chmod +x init-scripts/wait-for-it.sh
```

🐳 Levantar los contenedores

En la raíz del orquestador, ejecuta:
docker-compose up --build

Esto construirá y levantará:
	•	PostgreSQL
	•	inventory-service
	•	pedidos-service

🔁 Actualización de submódulos

Si haces cambios en uno de los microservicios:
```
cd order-service
git pull origin main  # o la rama que uses
cd ..
git add order-service
git commit -m "update submodule order-service"
git push

git submodule update --remote
```

✅ Verificación
	•	http://localhost:<puerto> — Verifica los puertos que expone cada microservicio en el docker-compose.yml.
	•	http://localhost:<puerto>/api/<endpoint> — verifica los endpoint de inventory-service en ./src/server.ts.
	•	PostgreSQL estará disponible en localhost:<POSTGRES_PORT>.

🧹 Apagar los contenedores
docker-compose down

📎 Notas
	•	Cada microservicio puede tener sus propias variables de entorno.
	•	order-service requiere generar el .jar con Maven antes de ejecutar docker-compose.
	•	inventory-service ya gestiona sus variables a través de su propio .env.
	•	inventory-service requiere de variables de entorno del sistema para postgres


✅ Ejemplo de JSON para realizar un pedido con disponibilidad en postman
	POST localhost:8080/api/pedidos

```
{
    "idPedido": 2,
    "cliente": {
        "idCliente": 7233
    },
    "itemPedidos": [
        {
            "idReceta": 1,
            "cantidad": 1,
            "valor": 2000.0,
            "totalItem": 2000.0,
            "estado": true
        }
    ],
    "direccionEntrega": {
        "departamento": "Antioquia",
        "municipio": "Medellin",
        "barrio": "Barrio Prueba",
        "direccion": "CR 40 50 52"
    },
    "totalPedido": {
        "subTotal": 10000.0,
        "porcentajeIVA": 19,
        "iva": 3000.0,
        "totalPedido": 13000.0
    },
    "estado": true
}
```




