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
```
🧾 Pedido Service

```env
DB_USER_POSTGRES=tu_usuario_postgres
DB_PASSWORD_POSTGRES=tu_password_postgres
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







