@echo off
REM ============================================================================
REM Script para ejecutar pruebas Newman con generacion de reportes
REM GreenMarket API Testing
REM ============================================================================

echo.
echo ========================================
echo   GreenMarket - Pruebas Automatizadas
echo ========================================
echo.

REM Verificar que Newman esta instalado
where newman >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Newman no esta instalado
    echo.
    echo Instala Newman con: npm install -g newman
    pause
    exit /b 1
)

REM Verificar que newman-reporter-html esta instalado
echo [INFO] Verificando newman-reporter-html...
call npm list -g newman-reporter-html >nul 2>&1
if errorlevel 1 (
    echo [WARN] newman-reporter-html no esta instalado
    echo [INFO] Instalando newman-reporter-html...
    call npm install -g newman-reporter-html
    if errorlevel 1 (
        echo [ERROR] No se pudo instalar newman-reporter-html
        pause
        exit /b 1
    )
)

echo [OK] Newman y reportes configurados correctamente
echo.

REM Crear carpeta reports si no existe
if not exist "reports" (
    mkdir reports
    echo [INFO] Carpeta 'reports' creada
)

REM Generar timestamp para nombre de archivo
set timestamp=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set timestamp=%timestamp: =0%

echo [INFO] Ejecutando pruebas...
echo.

REM Ejecutar Newman con reportes HTML y JUnit
newman run GreenMarket_JsonServer_Compatible.postman_collection.json ^
  --reporters cli,html,junit ^
  --reporter-html-export reports/report_%timestamp%.html ^
  --reporter-junit-export reports/results_%timestamp%.xml

if errorlevel 1 (
    echo.
    echo [ERROR] Las pruebas fallaron o hubo un error
    echo [INFO] Revisa que el servidor mock este corriendo en http://localhost:3000
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Reportes Generados Exitosamente
echo ========================================
echo.
echo [OK] Reporte HTML: reports\report_%timestamp%.html
echo [OK] Reporte JUnit: reports\results_%timestamp%.xml
echo.

REM Preguntar si desea abrir el reporte
set /p open="Deseas abrir el reporte HTML? (S/N): "
if /i "%open%"=="S" (
    start reports\report_%timestamp%.html
)

echo.
echo Presiona cualquier tecla para salir...
pause >nul
