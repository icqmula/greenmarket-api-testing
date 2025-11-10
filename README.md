# Proyecto de Validación de API - GreenMarket

Suite completa de pruebas automatizadas para la API REST de **GreenMarket**, una plataforma de comercio sustentable que gestiona productos ecológicos y locales.

[![Tests](https://img.shields.io/badge/tests-37%20passed-success)](https://github.com)
[![Coverage](https://img.shields.io/badge/coverage-100%25-brightgreen)](https://github.com)
[![Status](https://img.shields.io/badge/status-passing-success)](https://github.com)

---

##  Descripción del Proyecto

Este proyecto implementa una **suite completa de pruebas automatizadas** para validar la funcionalidad, seguridad y rendimiento de la API REST de GreenMarket antes de su lanzamiento a producción.

### Características Principales:
- ✅ **14 casos de prueba automatizados** con 37+ aserciones
- ✅ **Colección Postman** para testing manual y automatizado con Newman
- ✅ **Tests en Java** con REST Assured + JUnit 5
- ✅ **Mock Server** con json-server para desarrollo y testing
- ✅ **Reportes automáticos** en HTML y JUnit XML
- ✅ **CI/CD ready** con GitHub Actions

---

##  Objetivos Cumplidos

✅ Validar la funcionalidad completa de los endpoints  
✅ Asegurar el correcto manejo de casos positivos y negativos  
✅ Verificar códigos de estado HTTP apropiados  
✅ Validar estructura y contenido de respuestas JSON  
✅ Garantizar tiempos de respuesta óptimos (< 2000ms)  
✅ Automatizar la ejecución de pruebas  
✅ Generar reportes detallados de cobertura  

---

##  Resultados de Pruebas

```
✓ 14 requests ejecutados
✓ 37 assertions pasaron
✓ 0 fallos
✓ Cobertura: 100%
✓ Tiempo promedio: 9ms
```

### Distribución de Pruebas:
- **Gestión de Usuarios:** 4 casos de prueba
- **Catálogo de Productos:** 4 casos de prueba
- **Órdenes de Compra:** 3 casos de prueba
- **Reseñas de Clientes:** 3 casos de prueba

---

##  Inicio Rápido (3 minutos)

### Prerrequisitos
```bash
# Verificar instalaciones
node --version    # v14+
npm --version     # v6+
```

### Paso 1: Instalar Dependencias
```bash
npm install -g newman json-server
```

### Paso 2: Iniciar Mock Server
```bash
# Clonar repositorio
git clone <repo-url>
cd greenmarket-api-testing

# Iniciar servidor
json-server --watch db.json --port 3000
```

### Paso 3: Ejecutar Pruebas
```bash
# En otra terminal
newman run GreenMarket_JsonServer_Compatible.postman_collection.json
```

 **Resultado:** 37 assertions pasando, 0 fallos

---

##  Estructura del Proyecto

```
greenmarket-api-testing/
│
├──  README.md                          # Este archivo
├──  Plan_de_Pruebas_GreenMarket.docx   # Plan de pruebas completo
├──  Casos_de_Prueba_GreenMarket.docx   # Casos de prueba detallados
│
├──  postman/
│   ├── GreenMarket_JsonServer_Compatible.postman_collection.json
│   ├── GreenMarket_Environment.postman_environment.json
│   ├── run-newman-tests.bat
│   └── run-newman-tests.sh
│
├──  rest-assured/
│   ├── pom.xml
│   ├── BaseTest.java
│   ├── UserManagementTest.java
│   ├── ProductCatalogTest.java
│   ├── OrderManagementTest.java
│   └── run-rest-assured-tests.sh
│
├──  mock-server/
│   ├── db.json
│   ├── start-mock-server.bat
│   └── start-mock-server.sh
│
├──  docs/
│   ├── INICIO_RAPIDO.md
│   ├── GUIA_CONFIGURACION.md
│   └── GUIA_RAPIDA.md
│
└──  .github/workflows/
    └── github-actions-workflow.yml
```

---

##  Métodos de Ejecución

### Opción 1: Scripts Automatizados (Recomendado)

**Windows:**
```cmd
start-mock-server.bat
run-newman-tests.bat
```

**Linux/Mac:**
```bash
./start-mock-server.sh
./run-newman-tests.sh
```

### Opción 2: Newman (CLI)
```bash
newman run postman/GreenMarket_JsonServer_Compatible.postman_collection.json \
  --reporters cli,html \
  --reporter-html-export report.html
```

### Opción 3: REST Assured (Java)
```bash
cd rest-assured
mvn clean test
```

### Opción 4: Postman (GUI)
1. Importar `GreenMarket_JsonServer_Compatible.postman_collection.json`
2. Configurar `base_url = http://localhost:3000`
3. Ejecutar colección

---

##  Módulos Probados

### 1. Gestión de Usuarios
| Caso | Endpoint | Método | Aserciones |
|------|----------|--------|------------|
| Crear usuario | `/users` | POST | 5 |
| Listar usuarios | `/users` | GET | 3 |
| Obtener usuario | `/users/:id` | GET | 2 |
| Usuario inexistente | `/users/99999` | GET | 1 |

### 2. Catálogo de Productos
| Caso | Endpoint | Método | Aserciones |
|------|----------|--------|------------|
| Listar productos | `/products` | GET | 5 |
| Filtrar por categoría | `/products?category=organic` | GET | 2 |
| Obtener producto | `/products/:id` | GET | 3 |
| Producto no encontrado | `/products/999999` | GET | 1 |

### 3. Órdenes de Compra
| Caso | Endpoint | Método | Aserciones |
|------|----------|--------|------------|
| Crear orden | `/orders` | POST | 4 |
| Listar órdenes | `/orders` | GET | 2 |
| Obtener orden | `/orders/:id` | GET | 2 |

### 4. Reseñas de Clientes
| Caso | Endpoint | Método | Aserciones |
|------|----------|--------|------------|
| Crear reseña | `/reviews` | POST | 3 |
| Listar reseñas | `/reviews` | GET | 2 |
| Filtrar reseñas | `/reviews?productId=1` | GET | 2 |

**Total: 14 casos | 37 aserciones**

---

##  Personalización

### Agregar Productos
Edita `mock-server/db.json`:
```json
{
  "id": "11",
  "name": "Nuevo Producto Ecológico",
  "description": "Descripción del producto",
  "price": 15990,
  "category": "organic",
  "stock": 25
}
```

### Cambiar Puerto
```bash
json-server --watch db.json --port 3001
```

### Modificar Tests
Edita la colección en Postman o los archivos `.java` en `rest-assured/`

---

##  Reportes

### Generar Reporte HTML
```bash
newman run postman/GreenMarket_JsonServer_Compatible.postman_collection.json \
  --reporters html \
  --reporter-html-export report.html
```

### Generar Reporte JUnit (CI/CD)
```bash
newman run postman/GreenMarket_JsonServer_Compatible.postman_collection.json \
  --reporters junit \
  --reporter-junit-export results.xml
```

### Ver Reportes Maven
```bash
cd rest-assured
mvn test
# Ver: target/surefire-reports/
```

---

##  Integración CI/CD

### GitHub Actions
El proyecto incluye workflow configurado en `.github/workflows/github-actions-workflow.yml`

```yaml
- name: Run Newman Tests
  run: newman run postman/GreenMarket_JsonServer_Compatible.postman_collection.json
```

### Jenkins
```groovy
stage('API Tests') {
    steps {
        sh 'newman run postman/collection.json'
    }
}
```

---

##  Tecnologías Utilizadas

| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| **Postman** | Latest | Diseño y ejecución manual de pruebas |
| **Newman** | v6+ | Ejecución automatizada desde CLI |
| **json-server** | v0.17+ | Mock API REST |
| **REST Assured** | v5.3+ | Framework de testing Java |
| **JUnit 5** | v5.10+ | Testing framework |
| **Maven** | v3.6+ | Gestión de dependencias Java |
| **Node.js** | v14+ | Runtime para Newman y json-server |

---

##  Documentación Adicional

- **[INICIO_RAPIDO.md](docs/INICIO_RAPIDO.md)** - Guía de inicio en 3 minutos
- **[GUIA_CONFIGURACION.md](docs/GUIA_CONFIGURACION.md)** - Configuración detallada
- **[GUIA_RAPIDA.md](docs/GUIA_RAPIDA.md)** - Referencia rápida de comandos
- **[Plan_de_Pruebas_GreenMarket.docx](Plan_de_Pruebas_GreenMarket.docx)** - Plan completo
- **[Casos_de_Prueba_GreenMarket.docx](Casos_de_Prueba_GreenMarket.docx)** - Casos detallados

---

##  Troubleshooting

### Puerto 3000 ocupado
```bash
json-server --watch db.json --port 3001
newman run collection.json --env-var "base_url=http://localhost:3001"
```

### Newman no instalado
```bash
npm install -g newman newman-reporter-html
```

### Permisos denegados (Linux/Mac)
```bash
chmod +x *.sh
```

---

##  Licencia

Este proyecto es parte de un trabajo académico para validación de APIs REST.

---

##  Autor

**Ignacio Parada**  
Analista Geodésico - Instituto Geográfico Militar (IGM) Chile  
Proyecto: Validación de API GreenMarket

---

##  Contexto Académico

Este proyecto fue desarrollado como parte del curso de **Automatización de Pruebas de APIs REST** enfocado en:
- Testing funcional de APIs
- Automatización con Postman/Newman
- Testing programático con REST Assured
- Integración CI/CD
- Generación de reportes

---

##  Información del Proyecto

- **Fecha de Inicio:** Noviembre 2025
- **Última Actualización:** Noviembre 2025
- **Versión:** 1.0.0
- **Estado:** ✅ Completado y Funcional

---

##  Enlaces Útiles

- [Documentación Postman](https://learning.postman.com/)
- [Newman CLI](https://learning.postman.com/docs/running-collections/using-newman-cli/)
- [json-server](https://github.com/typicode/json-server)
- [REST Assured](https://rest-assured.io/)
- [JUnit 5](https://junit.org/junit5/)

---

##  Agradecimientos

Agradecimientos al equipo docente y compañeros del curso de automatización que contribuyeron con feedback y sugerencias durante el desarrollo de este proyecto.

---

**¿Preguntas o sugerencias?** Abre un issue en GitHub o contacta al autor.

**¡Gracias por revisar este proyecto! **
