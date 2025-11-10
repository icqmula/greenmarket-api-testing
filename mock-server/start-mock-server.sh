#!/bin/bash

###############################################################################
# Script para iniciar Mock Server con json-server
# API REST local para pruebas de GreenMarket
###############################################################################

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}  GreenMarket Mock API Server${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

# Verificar si json-server está instalado
if ! command -v json-server &> /dev/null; then
    echo -e "${RED}✗ json-server no está instalado${NC}"
    echo ""
    echo -e "${YELLOW}Instalando json-server...${NC}"
    npm install -g json-server
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error al instalar json-server${NC}"
        echo "Intenta manualmente: npm install -g json-server"
        exit 1
    fi
fi

echo -e "${GREEN}✓ json-server está instalado${NC}"
echo ""

# Verificar si db.json existe
if [ ! -f "db.json" ]; then
    echo -e "${RED}✗ Archivo db.json no encontrado${NC}"
    echo "Asegúrate de tener el archivo db.json en este directorio"
    exit 1
fi

echo -e "${GREEN}✓ Archivo db.json encontrado${NC}"
echo ""

# Puerto
PORT=3000

echo -e "${YELLOW}Iniciando servidor en puerto $PORT...${NC}"
echo ""
echo -e "${GREEN}API estará disponible en:${NC}"
echo -e "  ${BLUE}http://localhost:$PORT${NC}"
echo ""
echo -e "${GREEN}Endpoints disponibles:${NC}"
echo -e "  GET    http://localhost:$PORT/users"
echo -e "  GET    http://localhost:$PORT/products"
echo -e "  GET    http://localhost:$PORT/orders"
echo -e "  GET    http://localhost:$PORT/reviews"
echo ""
echo -e "${YELLOW}Presiona Ctrl+C para detener el servidor${NC}"
echo ""
echo -e "${BLUE}======================================${NC}"
echo ""

# Iniciar json-server
json-server --watch db.json --port $PORT --host 0.0.0.0
