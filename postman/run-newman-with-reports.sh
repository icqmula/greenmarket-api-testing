#!/bin/bash

################################################################################
# Script para ejecutar pruebas Newman con generacion de reportes
# GreenMarket API Testing
################################################################################

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  GreenMarket - Pruebas Automatizadas${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Verificar que Newman esta instalado
if ! command -v newman &> /dev/null; then
    echo -e "${RED}[ERROR] Newman no esta instalado${NC}"
    echo ""
    echo "Instala Newman con: npm install -g newman"
    exit 1
fi

# Verificar que newman-reporter-html esta instalado
echo -e "${YELLOW}[INFO] Verificando newman-reporter-html...${NC}"
if ! npm list -g newman-reporter-html &> /dev/null; then
    echo -e "${YELLOW}[WARN] newman-reporter-html no esta instalado${NC}"
    echo -e "${YELLOW}[INFO] Instalando newman-reporter-html...${NC}"
    npm install -g newman-reporter-html
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}[ERROR] No se pudo instalar newman-reporter-html${NC}"
        echo "Intenta con: sudo npm install -g newman-reporter-html"
        exit 1
    fi
fi

echo -e "${GREEN}[OK] Newman y reportes configurados correctamente${NC}"
echo ""

# Crear carpeta reports si no existe
if [ ! -d "reports" ]; then
    mkdir -p reports
    echo -e "${GREEN}[INFO] Carpeta 'reports' creada${NC}"
fi

# Generar timestamp para nombre de archivo
timestamp=$(date +"%Y%m%d_%H%M%S")

echo -e "${YELLOW}[INFO] Ejecutando pruebas...${NC}"
echo ""

# Ejecutar Newman con reportes HTML y JUnit
newman run GreenMarket_JsonServer_Compatible.postman_collection.json \
  --reporters cli,html,junit \
  --reporter-html-export reports/report_${timestamp}.html \
  --reporter-junit-export reports/results_${timestamp}.xml

if [ $? -ne 0 ]; then
    echo ""
    echo -e "${RED}[ERROR] Las pruebas fallaron o hubo un error${NC}"
    echo -e "${YELLOW}[INFO] Revisa que el servidor mock este corriendo en http://localhost:3000${NC}"
    echo ""
    exit 1
fi

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Reportes Generados Exitosamente${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${GREEN}[OK] Reporte HTML: reports/report_${timestamp}.html${NC}"
echo -e "${GREEN}[OK] Reporte JUnit: reports/results_${timestamp}.xml${NC}"
echo ""

# Preguntar si desea abrir el reporte
read -p "¿Deseas abrir el reporte HTML? (s/n): " open
if [[ "$open" == "s" || "$open" == "S" ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        open reports/report_${timestamp}.html
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        xdg-open reports/report_${timestamp}.html 2>/dev/null || echo "Abre manualmente: reports/report_${timestamp}.html"
    fi
fi

echo ""
echo -e "${GREEN}¡Pruebas completadas! 🎉${NC}"
