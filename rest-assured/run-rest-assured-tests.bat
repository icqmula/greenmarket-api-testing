@echo off
REM ###############################################################################
REM Script de Automatización - REST Assured para GreenMarket API (Windows)
REM 
REM Este script ejecuta las pruebas de REST Assured usando Maven
REM y genera reportes en formato Surefire
REM
REM Requisitos:
REM - Java JDK 11 o superior
REM - Maven 3.6 o superior
REM - Archivo pom.xml configurado correctamente
REM
REM Uso: run-rest-assured-tests.bat
REM ###############################################################################

echo ============================================
echo   GreenMarket API - REST Assured Test Suite
echo ============================================
echo.

REM Verificar si Maven está instalado
mvn --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Maven no está instalado
    echo Instalar Maven desde: https://maven.apache.org/download.cgi
    pause
    exit /b 1
)

echo [OK] Maven está instalado
mvn --version | findstr "Apache Maven"
echo.

REM Verificar si Java está instalado
java -version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Java no está instalado
    echo Instalar Java JDK 11 o superior
    pause
    exit /b 1
)

echo [OK] Java está instalado
java -version 2>&1 | findstr "version"
echo.

echo ============================================
echo.

REM Limpiar compilaciones anteriores
echo Limpiando compilaciones anteriores...
call mvn clean

echo.
echo ============================================
echo.

REM Compilar el proyecto
echo Compilando proyecto...
call mvn compile

if errorlevel 1 (
    echo [ERROR] Error en la compilación
    pause
    exit /b 1
)

echo.
echo ============================================
echo.

REM Ejecutar pruebas
echo Ejecutando suite de pruebas...
echo.

call mvn test

REM Capturar el código de salida
set EXIT_CODE=%errorlevel%

echo.
echo ============================================
echo.

if %EXIT_CODE% equ 0 (
    echo [OK] Todas las pruebas pasaron exitosamente
) else (
    echo [ERROR] Algunas pruebas fallaron
)

echo.
echo Reportes de pruebas generados en:
echo   target\surefire-reports\
echo.
echo Para ver reportes detallados:
echo   dir target\surefire-reports\
echo.

REM Mostrar resumen si existe
if exist "target\surefire-reports\TEST-*.xml" (
    echo Resumen de pruebas disponible en los archivos XML
    echo.
)

pause
exit /b %EXIT_CODE%
