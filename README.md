# Proyecto de Validación de API - GreenMarket

## 📋 Descripción
Suite completa de pruebas automatizadas para la API REST de GreenMarket, 
plataforma de comercio sustentable.

## 🎯 Objetivos Cumplidos
✅ Plan de Pruebas completo
✅ 17+ Casos de Prueba documentados
✅ Colección Postman con 37 aserciones
✅ Tests REST Assured con JUnit 5
✅ Automatización con Newman
✅ Mock Server con json-server

## 📊 Resultados de Pruebas
```
✓ 14 requests ejecutados
✓ 37 assertions pasaron
✓ 0 fallos
✓ Cobertura: 100%
```

## 🚀 Ejecución Rápida

### Opción 1: Newman (Postman CLI)
```bash
# 1. Instalar json-server
npm install -g json-server

# 2. Iniciar mock server
cd mock-server
json-server --watch db.json --port 3000

# 3. Ejecutar tests (en otra terminal)
newman run postman/GreenMarket_JsonServer_Compatible.postman_collection.json
```

### Opción 2: REST Assured (Java)
```bash
cd rest-assured
mvn clean test
```

## 📁 Estructura del Proyecto
```
├── postman/              # Colecciones Postman
├── rest-assured/         # Tests Java + JUnit
├── mock-server/          # API mock con json-server
├── docs/                 # Documentación adicional
└── .github/workflows/    # CI/CD
```

## 📚 Documentación
- [Plan de Pruebas](Plan_de_Pruebas_GreenMarket.docx)
- [Casos de Prueba](Casos_de_Prueba_GreenMarket.docx)
- [Guía Rápida](docs/GUIA_RAPIDA.md)

## 🛠️ Tecnologías
- **Postman/Newman** - Testing de API
- **REST Assured** - Framework Java
- **JUnit 5** - Testing framework
- **json-server** - Mock API
- **Maven** - Gestión de dependencias

## 👤 Autor
Ignacio Parada - Analista Geodésico IGM Chile

## 📅 Fecha
Noviembre 2025
```

GreenMarket API Testing - JSONPlaceholder Demo

□ Demo: Gestión de Usuarios (JSONPlaceholder)
└ GET - Obtener Usuario
  GET https://jsonplaceholder.typicode.com/users/1 [200 OK, 1.66kB, 857ms]
  √  Status code es 200 OK
  √  Content-Type es application/json
  √  Response contiene datos del usuario
  √  Tiempo de respuesta menor a 2000ms

└ GET - Listar Usuarios
  GET https://jsonplaceholder.typicode.com/users [200 OK, 2.98kB, 147ms]
  √  Status code es 200 OK
  √  Response es un array
  √  Cada usuario tiene campos requeridos

└ POST - Crear Usuario
  POST https://jsonplaceholder.typicode.com/users [201 Created, 1.34kB, 257ms]
  √  Status code es 201 Created
  √  Response contiene id del nuevo usuario
  √  Email enviado está en la respuesta

└ GET - Usuario Inexistente (404)
  GET https://jsonplaceholder.typicode.com/users/99999 [404 Not Found, 1.15kB, 141ms]
  √  Status code es 404 Not Found

□ Demo: Posts (Productos)
└ GET - Listar Posts
  GET https://jsonplaceholder.typicode.com/posts?_limit=10 [200 OK, 3.95kB, 146ms]
  √  Status code es 200 OK
  √  Response es un array de posts
  √  Cada post tiene estructura correcta

└ GET - Obtener Post por ID
  GET https://jsonplaceholder.typicode.com/posts/1 [200 OK, 1.44kB, 141ms]
  √  Status code es 200 OK
  √  Post contiene todos los campos

└ POST - Crear Post
  POST https://jsonplaceholder.typicode.com/posts [201 Created, 1.35kB, 261ms]
  √  Status code es 201 Created
  √  Response contiene id del nuevo post

└ DELETE - Eliminar Post
  DELETE https://jsonplaceholder.typicode.com/posts/1 [200 OK, 1.13kB, 260ms]
  √  Status code es 200 OK

□ Demo: Comentarios (Reseñas)
└ GET - Listar Comentarios
  GET https://jsonplaceholder.typicode.com/comments?postId=1 [200 OK, 2.65kB, 142ms]
  √  Status code es 200 OK
  √  Response es un array

└ POST - Crear Comentario
  POST https://jsonplaceholder.typicode.com/comments [201 Created, 1.39kB, 257ms]
  √  Status code es 201 Created
  √  Comentario contiene email

┌─────────────────────────┬─────────────────────┬────────────────────┐
│                         │            executed │             failed │
├─────────────────────────┼─────────────────────┼────────────────────┤
│              iterations │                   1 │                  0 │
├─────────────────────────┼─────────────────────┼────────────────────┤
│                requests │                  10 │                  0 │
├─────────────────────────┼─────────────────────┼────────────────────┤
│            test-scripts │                  10 │                  0 │
├─────────────────────────┼─────────────────────┼────────────────────┤
│      prerequest-scripts │                   0 │                  0 │
├─────────────────────────┼─────────────────────┼────────────────────┤
│              assertions │                  23 │                  0 │
├─────────────────────────┴─────────────────────┴────────────────────┤
│ total run duration: 3.5s                                           │
├────────────────────────────────────────────────────────────────────┤
│ total data received: 7.26kB (approx)                               │
├────────────────────────────────────────────────────────────────────┤
│ average response time: 260ms [min: 141ms, max: 857ms, s.d.: 206ms] │
└────────────────────────────────────────────────────────────────────┘


