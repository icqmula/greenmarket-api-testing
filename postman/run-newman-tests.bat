@echo off
REM ###############################################################################
REM Script de Automatización - Newman para GreenMarket API (Windows)
REM 
REM Este script ejecuta la colección de Postman usando Newman (CLI)
REM y genera reportes en formato HTML y JUnit
REM
REM Requisitos:
REM - Node.js y npm instalados
REM - Newman instalado globalmente: npm install -g newman
REM - Newman HTML reporter: npm install -g newman-reporter-html
REM
REM Uso: run-newman-tests.bat
REM ###############################################################################

echo =========================================
echo   GreenMarket API - Newman Test Runner
echo =========================================
echo.

REM Verificar si Newman está instalado
newman --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Newman no está instalado
    echo Instalar con: npm install -g newman
    pause
    exit /b 1
)

echo [OK] Newman está instalado
echo.

REM Archivos y directorios
set COLLECTION_FILE=GreenMarket_Collection.postman_collection.json
set ENVIRONMENT_FILE=GreenMarket_Environment.postman_environment.json
set REPORTS_DIR=newman-reports

REM Crear directorio de reportes si no existe
if not exist "%REPORTS_DIR%" mkdir "%REPORTS_DIR%"

REM Timestamp para el reporte
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set TIMESTAMP=%datetime:~0,8%_%datetime:~8,6%
set REPORT_NAME=greenmarket_report_%TIMESTAMP%

echo Ejecutando colección de pruebas...
echo.
echo Colección: %COLLECTION_FILE%
echo Entorno: %ENVIRONMENT_FILE%
echo Reportes: %REPORTS_DIR%\%REPORT_NAME%
echo.
echo =========================================
echo.

REM Ejecutar Newman con reportes
newman run "%COLLECTION_FILE%" ^
    -e "%ENVIRONMENT_FILE%" ^
    --reporters cli,html,junit ^
    --reporter-html-export "%REPORTS_DIR%\%REPORT_NAME%.html" ^
    --reporter-junit-export "%REPORTS_DIR%\%REPORT_NAME%.xml" ^
    --color on ^
    --delay-request 100 ^
    --timeout-request 10000 ^
    --insecure

REM Capturar el código de salida
set EXIT_CODE=%errorlevel%

echo.
echo =========================================

if %EXIT_CODE% equ 0 (
    echo [OK] Todas las pruebas pasaron exitosamente
) else (
    echo [ERROR] Algunas pruebas fallaron
)

echo.
echo Reportes generados:
echo   - HTML: %REPORTS_DIR%\%REPORT_NAME%.html
echo   - JUnit XML: %REPORTS_DIR%\%REPORT_NAME%.xml
echo.

pause
exit /b %EXIT_CODE%
