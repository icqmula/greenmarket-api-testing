package com.greenmarket.tests;

import com.greenmarket.tests.base.BaseTest;
import io.restassured.response.Response;
import org.junit.jupiter.api.*;
import static io.restassured.RestAssured.*;
import static org.hamcrest.Matchers.*;

/**
 * Suite de pruebas para el módulo de Órdenes de Compra
 * Incluye creación y consulta de órdenes
 * Requiere autenticación previa
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class OrderManagementTest extends BaseTest {
    
    private static String testOrderId;
    private static String testProductId = "123"; // ID de prueba
    
    @BeforeAll
    public static void setupOrders() {
        // Nota: Este test asume que ya existe un token de autenticación
        // En un ambiente real, se ejecutaría después de UserManagementTest
        System.out.println("=== Iniciando pruebas de Órdenes ===");
        System.out.println("Token requerido para pruebas autenticadas");
    }
    
    /**
     * CP-010: Crear Orden de Compra
     * Verifica que un usuario autenticado puede crear una orden de compra
     */
    @Test
    @Order(1)
    @DisplayName("CP-010: Crear Orden de Compra")
    public void testCreateOrder() {
        // Preparar datos de la orden
        String requestBody = String.format(
            "{\"items\":[{\"productId\":\"%s\",\"quantity\":2}]," +
            "\"shippingAddress\":\"Av. Principal 123, Santiago, Chile\"}",
            testProductId
        );
        
        Response response = given()
                .spec(requestSpec)
                .header("Authorization", "Bearer " + getAuthToken())
                .body(requestBody)
            .when()
                .post("/orders")
            .then()
                .statusCode(201)
                .contentType(ContentType.JSON)
                .body("orderId", notNullValue())
                .body("total", notNullValue())
                .body("total", greaterThan(0.0f))
                .body("status", equalTo("pending"))
                .body("createdAt", notNullValue())
            .extract()
                .response();
        
        // Guardar orderId para pruebas posteriores
        testOrderId = response.jsonPath().getString("orderId");
        
        System.out.println("✓ CP-010 Pasó: Orden creada exitosamente");
        System.out.println("  Order ID: " + testOrderId);
        System.out.println("  Total: $" + response.jsonPath().getFloat("total"));
    }
    
    /**
     * CP-011: Obtener Orden por ID
     * Verifica que un usuario autenticado puede consultar su orden
     */
    @Test
    @Order(2)
    @DisplayName("CP-011: Obtener Orden por ID")
    public void testGetOrderById() {
        given()
            .spec(requestSpec)
            .header("Authorization", "Bearer " + getAuthToken())
        .when()
            .get("/orders/" + testOrderId)
        .then()
            .statusCode(200)
            .contentType(ContentType.JSON)
            .body("orderId", equalTo(testOrderId))
            .body("items", notNullValue())
            .body("items", isA(java.util.List.class))
            .body("total", notNullValue())
            .body("status", notNullValue())
            .body("shippingAddress", notNullValue());
        
        System.out.println("✓ CP-011 Pasó: Orden consultada correctamente");
    }
    
    /**
     * CP-012: Crear Orden sin Autenticación
     * Verifica que no se puede crear una orden sin estar autenticado
     */
    @Test
    @Order(3)
    @DisplayName("CP-012: Crear Orden sin Autenticación")
    public void testCreateOrderWithoutAuth() {
        String requestBody = String.format(
            "{\"items\":[{\"productId\":\"%s\",\"quantity\":1}]," +
            "\"shippingAddress\":\"Dirección de prueba\"}",
            testProductId
        );
        
        given()
            .spec(requestSpec)
            // No se envía Authorization header
            .body(requestBody)
        .when()
            .post("/orders")
        .then()
            .statusCode(401)
            .contentType(ContentType.JSON)
            .body("error", containsStringIgnoringCase("Authentication required"));
        
        System.out.println("✓ CP-012 Pasó: Orden sin auth rechazada correctamente");
    }
    
    /**
     * CP-013: Crear Orden con Datos Incompletos
     * Verifica la validación de datos requeridos
     */
    @Test
    @Order(4)
    @DisplayName("CP-013: Crear Orden con Datos Incompletos")
    public void testCreateOrderIncompleteData() {
        // Body sin items (campo requerido)
        String requestBody = "{\"shippingAddress\":\"Dirección de prueba\"}";
        
        given()
            .spec(requestSpec)
            .header("Authorization", "Bearer " + getAuthToken())
            .body(requestBody)
        .when()
            .post("/orders")
        .then()
            .statusCode(400)
            .contentType(ContentType.JSON)
            .body("error", notNullValue());
        
        System.out.println("✓ CP-013 Pasó: Validación de datos funcionando");
    }
    
    /**
     * CP-014: Crear Orden con Cantidad Inválida
     * Verifica la validación de cantidad de productos
     */
    @Test
    @Order(5)
    @DisplayName("CP-014: Crear Orden con Cantidad Inválida")
    public void testCreateOrderInvalidQuantity() {
        // Cantidad negativa
        String requestBody = String.format(
            "{\"items\":[{\"productId\":\"%s\",\"quantity\":-1}]," +
            "\"shippingAddress\":\"Dirección de prueba\"}",
            testProductId
        );
        
        given()
            .spec(requestSpec)
            .header("Authorization", "Bearer " + getAuthToken())
            .body(requestBody)
        .when()
            .post("/orders")
        .then()
            .statusCode(400)
            .contentType(ContentType.JSON)
            .body("error", notNullValue());
        
        System.out.println("✓ CP-014 Pasó: Cantidad inválida rechazada");
    }
    
    /**
     * CP-015: Consultar Orden Inexistente
     * Verifica el manejo de órdenes que no existen
     */
    @Test
    @Order(6)
    @DisplayName("CP-015: Consultar Orden Inexistente")
    public void testGetNonExistentOrder() {
        String nonExistentOrderId = "999999";
        
        given()
            .spec(requestSpec)
            .header("Authorization", "Bearer " + getAuthToken())
        .when()
            .get("/orders/" + nonExistentOrderId)
        .then()
            .statusCode(404)
            .contentType(ContentType.JSON)
            .body("error", containsStringIgnoringCase("Order not found"));
        
        System.out.println("✓ CP-015 Pasó: Orden inexistente manejada correctamente");
    }
    
    @AfterAll
    public static void tearDown() {
        System.out.println("\n=== Resumen de Pruebas de Órdenes ===");
        System.out.println("Todas las pruebas del módulo de órdenes completadas");
        if (testOrderId != null) {
            System.out.println("Orden de prueba creada: " + testOrderId);
        }
    }
}
