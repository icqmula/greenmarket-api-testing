#!/bin/bash

###############################################################################
# Script de Automatización - REST Assured para GreenMarket API
# 
# Este script ejecuta las pruebas de REST Assured usando Maven
# y genera reportes en formato Surefire
#
# Requisitos:
# - Java JDK 11 o superior
# - Maven 3.6 o superior
# - Archivo pom.xml configurado correctamente
#
# Uso: ./run-rest-assured-tests.sh
###############################################################################

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "============================================"
echo "  GreenMarket API - REST Assured Test Suite"
echo "============================================"
echo ""

# Verificar si Maven está instalado
if ! command -v mvn &> /dev/null; then
    echo -e "${RED}Error: Maven no está instalado${NC}"
    echo "Instalar Maven desde: https://maven.apache.org/download.cgi"
    exit 1
fi

echo -e "${GREEN}✓ Maven está instalado${NC}"
mvn --version | head -n 1
echo ""

# Verificar si Java está instalado
if ! command -v java &> /dev/null; then
    echo -e "${RED}Error: Java no está instalado${NC}"
    echo "Instalar Java JDK 11 o superior"
    exit 1
fi

echo -e "${GREEN}✓ Java está instalado${NC}"
java -version 2>&1 | head -n 1
echo ""

echo "============================================"
echo ""

# Limpiar compilaciones anteriores
echo -e "${YELLOW}Limpiando compilaciones anteriores...${NC}"
mvn clean

echo ""
echo "============================================"
echo ""

# Compilar el proyecto
echo -e "${YELLOW}Compilando proyecto...${NC}"
mvn compile

if [ $? -ne 0 ]; then
    echo -e "${RED}Error en la compilación${NC}"
    exit 1
fi

echo ""
echo "============================================"
echo ""

# Ejecutar pruebas
echo -e "${BLUE}Ejecutando suite de pruebas...${NC}"
echo ""

mvn test

# Capturar el código de salida
EXIT_CODE=$?

echo ""
echo "============================================"
echo ""

if [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✓ Todas las pruebas pasaron exitosamente${NC}"
else
    echo -e "${RED}✗ Algunas pruebas fallaron${NC}"
fi

echo ""
echo "Reportes de pruebas generados en:"
echo "  target/surefire-reports/"
echo ""
echo "Para ver reportes detallados:"
echo "  ls -la target/surefire-reports/"
echo ""

# Resumen de pruebas
if [ -f "target/surefire-reports/TEST-*.xml" ]; then
    echo "Resumen de pruebas:"
    grep -h "tests=" target/surefire-reports/TEST-*.xml | head -n 1
    echo ""
fi

exit $EXIT_CODE
