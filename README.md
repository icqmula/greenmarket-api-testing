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

---

## 📸 **Screenshot Recomendado**

Captura pantalla de tu ejecución exitosa:
```
✓ 37 assertions passed
0 failed
