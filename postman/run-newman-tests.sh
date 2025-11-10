#!/bin/bash

###############################################################################
# Script de Automatización - Newman para GreenMarket API
# 
# Este script ejecuta la colección de Postman usando Newman (CLI)
# y genera reportes en formato HTML y JUnit
#
# Requisitos:
# - Node.js y npm instalados
# - Newman instalado globalmente: npm install -g newman
# - Newman HTML reporter: npm install -g newman-reporter-html
#
# Uso: ./run-newman-tests.sh
###############################################################################

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================="
echo "  GreenMarket API - Newman Test Runner"
echo "========================================="
echo ""

# Verificar si Newman está instalado
if ! command -v newman &> /dev/null; then
    echo -e "${RED}Error: Newman no está instalado${NC}"
    echo "Instalar con: npm install -g newman"
    exit 1
fi

echo -e "${GREEN}✓ Newman está instalado${NC}"
echo ""

# Directorios
COLLECTION_FILE="GreenMarket_Collection.postman_collection.json"
ENVIRONMENT_FILE="GreenMarket_Environment.postman_environment.json"
REPORTS_DIR="newman-reports"

# Crear directorio de reportes si no existe
mkdir -p "$REPORTS_DIR"

# Timestamp para el reporte
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
REPORT_NAME="greenmarket_report_$TIMESTAMP"

echo "Ejecutando colección de pruebas..."
echo ""
echo "Colección: $COLLECTION_FILE"
echo "Entorno: $ENVIRONMENT_FILE"
echo "Reportes: $REPORTS_DIR/$REPORT_NAME"
echo ""
echo "========================================="
echo ""

# Ejecutar Newman con reportes
newman run "$COLLECTION_FILE" \
    -e "$ENVIRONMENT_FILE" \
    --reporters cli,html,junit \
    --reporter-html-export "$REPORTS_DIR/${REPORT_NAME}.html" \
    --reporter-junit-export "$REPORTS_DIR/${REPORT_NAME}.xml" \
    --color on \
    --delay-request 100 \
    --timeout-request 10000 \
    --insecure

# Capturar el código de salida
EXIT_CODE=$?

echo ""
echo "========================================="

if [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✓ Todas las pruebas pasaron exitosamente${NC}"
else
    echo -e "${RED}✗ Algunas pruebas fallaron${NC}"
fi

echo ""
echo "Reportes generados:"
echo "  - HTML: $REPORTS_DIR/${REPORT_NAME}.html"
echo "  - JUnit XML: $REPORTS_DIR/${REPORT_NAME}.xml"
echo ""

# Abrir reporte HTML automáticamente (opcional, descomentar si se desea)
# if command -v xdg-open &> /dev/null; then
#     xdg-open "$REPORTS_DIR/${REPORT_NAME}.html"
# fi

exit $EXIT_CODE
