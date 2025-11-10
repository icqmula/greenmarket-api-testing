@echo off
REM ###############################################################################
REM Script para iniciar Mock Server con json-server (Windows)
REM API REST local para pruebas de GreenMarket
REM ###############################################################################

echo ======================================
echo   GreenMarket Mock API Server
echo ======================================
echo.

REM Verificar si json-server está instalado
json-server --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] json-server no esta instalado
    echo.
    echo Instalando json-server...
    call npm install -g json-server
    
    if errorlevel 1 (
        echo [ERROR] Error al instalar json-server
        echo Intenta manualmente: npm install -g json-server
        pause
        exit /b 1
    )
)

echo [OK] json-server esta instalado
echo.

REM Verificar si db.json existe
if not exist "db.json" (
    echo [ERROR] Archivo db.json no encontrado
    echo Asegurate de tener el archivo db.json en este directorio
    pause
    exit /b 1
)

echo [OK] Archivo db.json encontrado
echo.

REM Puerto
set PORT=3000

echo Iniciando servidor en puerto %PORT%...
echo.
echo API estara disponible en:
echo   http://localhost:%PORT%
echo.
echo Endpoints disponibles:
echo   GET    http://localhost:%PORT%/users
echo   GET    http://localhost:%PORT%/products
echo   GET    http://localhost:%PORT%/orders
echo   GET    http://localhost:%PORT%/reviews
echo.
echo Presiona Ctrl+C para detener el servidor
echo.
echo ======================================
echo.

REM Iniciar json-server
json-server --watch db.json --port %PORT% --host 0.0.0.0
