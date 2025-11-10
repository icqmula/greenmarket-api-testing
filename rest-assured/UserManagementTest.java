package com.greenmarket.tests;

import com.greenmarket.tests.base.BaseTest;
import io.restassured.response.Response;
import org.junit.jupiter.api.*;
import static io.restassured.RestAssured.*;
import static org.hamcrest.Matchers.*;

/**
 * Suite de pruebas para el módulo de Gestión de Usuarios
 * Incluye casos de registro, login y perfil de usuario
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class UserManagementTest extends BaseTest {
    
    private static String testEmail = "juan.perez@greenmarket.com";
    private static String testPassword = "Password123!";
    private static String testName = "Juan Pérez";
    private static String testPhone = "+56912345678";
    
    /**
     * CP-001: Registro de Usuario Exitoso
     * Verifica que un nuevo usuario puede registrarse exitosamente con datos válidos
     */
    @Test
    @Order(1)
    @DisplayName("CP-001: Registro de Usuario Exitoso")
    public void testUserRegistrationSuccess() {
        // Preparar datos de registro
        String requestBody = String.format(
            "{\"name\":\"%s\",\"email\":\"%s\",\"password\":\"%s\",\"phone\":\"%s\"}",
            testName, testEmail, testPassword, testPhone
        );
        
        // Ejecutar petición
        Response response = given()
                .spec(requestSpec)
                .body(requestBody)
            .when()
                .post("/users/register")
            .then()
                .statusCode(201)
                .contentType(ContentType.JSON)
                .body("userId", notNullValue())
                .body("email", equalTo(testEmail))
                .body("password", not(hasKey("password")))
                .body("createdAt", notNullValue())
                .time(lessThan(2000L))
            .extract()
                .response();
        
        // Guardar userId para pruebas posteriores
        setUserId(response.jsonPath().getString("userId"));
        
        System.out.println("✓ CP-001 Pasó: Usuario registrado exitosamente");
        System.out.println("  User ID: " + getUserId());
    }
    
    /**
     * CP-002: Registro con Email Duplicado
     * Verifica que el sistema rechaza el registro de un email ya existente
     */
    @Test
    @Order(2)
    @DisplayName("CP-002: Registro con Email Duplicado")
    public void testUserRegistrationDuplicateEmail() {
        // Intentar registrar el mismo email
        String requestBody = String.format(
            "{\"name\":\"%s\",\"email\":\"%s\",\"password\":\"%s\",\"phone\":\"%s\"}",
            testName, testEmail, testPassword, testPhone
        );
        
        given()
            .spec(requestSpec)
            .body(requestBody)
        .when()
            .post("/users/register")
        .then()
            .statusCode(409)
            .contentType(ContentType.JSON)
            .body("error", containsStringIgnoringCase("already registered"));
        
        System.out.println("✓ CP-002 Pasó: Email duplicado rechazado correctamente");
    }
    
    /**
     * CP-003: Login Exitoso
     * Verifica que un usuario puede autenticarse con credenciales válidas
     */
    @Test
    @Order(3)
    @DisplayName("CP-003: Login Exitoso")
    public void testUserLoginSuccess() {
        // Preparar credenciales
        String requestBody = String.format(
            "{\"email\":\"%s\",\"password\":\"%s\"}",
            testEmail, testPassword
        );
        
        // Ejecutar login
        Response response = given()
                .spec(requestSpec)
                .body(requestBody)
            .when()
                .post("/users/login")
            .then()
                .statusCode(200)
                .contentType(ContentType.JSON)
                .body("token", notNullValue())
                .body("token", matchesPattern("^[A-Za-z0-9-_=]+\\.[A-Za-z0-9-_=]+\\.?[A-Za-z0-9-_.+/=]*$"))
                .body("userId", notNullValue())
                .body("expiresIn", notNullValue())
                .time(lessThan(2000L))
            .extract()
                .response();
        
        // Guardar token para pruebas posteriores
        String token = response.jsonPath().getString("token");
        setAuthToken(token);
        
        System.out.println("✓ CP-003 Pasó: Login exitoso");
        System.out.println("  Token obtenido: " + token.substring(0, 20) + "...");
    }
    
    /**
     * CP-004: Login con Credenciales Inválidas
     * Verifica que el sistema rechaza credenciales incorrectas
     */
    @Test
    @Order(4)
    @DisplayName("CP-004: Login con Credenciales Inválidas")
    public void testUserLoginInvalidCredentials() {
        String requestBody = String.format(
            "{\"email\":\"%s\",\"password\":\"%s\"}",
            testEmail, "PasswordIncorrecto"
        );
        
        given()
            .spec(requestSpec)
            .body(requestBody)
        .when()
            .post("/users/login")
        .then()
            .statusCode(401)
            .contentType(ContentType.JSON)
            .body("error", containsStringIgnoringCase("Invalid credentials"))
            .body("token", not(hasKey("token")));
        
        System.out.println("✓ CP-004 Pasó: Credenciales inválidas rechazadas");
    }
    
    /**
     * CP-005: Obtener Perfil de Usuario Autenticado
     * Verifica que un usuario autenticado puede obtener su perfil
     */
    @Test
    @Order(5)
    @DisplayName("CP-005: Obtener Perfil de Usuario Autenticado")
    public void testGetUserProfileAuthenticated() {
        given()
            .spec(requestSpec)
            .header("Authorization", "Bearer " + getAuthToken())
        .when()
            .get("/users/profile")
        .then()
            .statusCode(200)
            .contentType(ContentType.JSON)
            .body("userId", notNullValue())
            .body("name", notNullValue())
            .body("email", equalTo(testEmail))
            .body("phone", notNullValue())
            .body("createdAt", notNullValue())
            .body("password", not(hasKey("password")))
            .time(lessThan(2000L));
        
        System.out.println("✓ CP-005 Pasó: Perfil obtenido correctamente");
    }
    
    /**
     * CP-006: Acceso sin Token de Autenticación
     * Verifica que endpoints protegidos rechazan peticiones sin token
     */
    @Test
    @Order(6)
    @DisplayName("CP-006: Acceso sin Token de Autenticación")
    public void testGetUserProfileWithoutAuth() {
        given()
            .spec(requestSpec)
            // No se envía header de Authorization
        .when()
            .get("/users/profile")
        .then()
            .statusCode(401)
            .contentType(ContentType.JSON)
            .body("error", containsStringIgnoringCase("Authentication required"));
        
        System.out.println("✓ CP-006 Pasó: Acceso sin token rechazado");
    }
    
    @AfterAll
    public static void tearDown() {
        System.out.println("\n=== Resumen de Pruebas de Usuarios ===");
        System.out.println("Todas las pruebas del módulo de usuarios completadas");
    }
}
