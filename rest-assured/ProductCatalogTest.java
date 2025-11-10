package com.greenmarket.tests;

import com.greenmarket.tests.base.BaseTest;
import io.restassured.response.Response;
import org.junit.jupiter.api.*;
import static io.restassured.RestAssured.*;
import static org.hamcrest.Matchers.*;

/**
 * Suite de pruebas para el módulo de Catálogo de Productos
 * Incluye casos de listado, consulta y manejo de errores
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class ProductCatalogTest extends BaseTest {
    
    private static String testProductId;
    
    /**
     * CP-007: Listar Productos
     * Verifica que se pueden obtener todos los productos disponibles
     */
    @Test
    @Order(1)
    @DisplayName("CP-007: Listar Productos")
    public void testListProducts() {
        Response response = given()
                .spec(requestSpec)
                .queryParam("limit", 10)
                .queryParam("page", 1)
            .when()
                .get("/products")
            .then()
                .statusCode(200)
                .contentType(ContentType.JSON)
                .body("$", isA(java.util.List.class))
                .body("size()", greaterThan(0))
                .body("[0].id", notNullValue())
                .body("[0].name", notNullValue())
                .body("[0].description", notNullValue())
                .body("[0].price", notNullValue())
                .body("[0].category", notNullValue())
                .body("[0].price", greaterThan(0.0f))
                .time(lessThan(2000L))
            .extract()
                .response();
        
        // Guardar el ID del primer producto para pruebas posteriores
        testProductId = response.jsonPath().getString("[0].id");
        
        System.out.println("✓ CP-007 Pasó: Productos listados correctamente");
        System.out.println("  Total productos en respuesta: " + response.jsonPath().getList("$").size());
        System.out.println("  Primer Product ID: " + testProductId);
    }
    
    /**
     * CP-007b: Listar Productos con Filtro de Categoría
     * Verifica que se pueden filtrar productos por categoría
     */
    @Test
    @Order(2)
    @DisplayName("CP-007b: Listar Productos con Filtro")
    public void testListProductsWithFilter() {
        given()
            .spec(requestSpec)
            .queryParam("category", "organic")
            .queryParam("limit", 5)
        .when()
            .get("/products")
        .then()
            .statusCode(200)
            .contentType(ContentType.JSON)
            .body("$", isA(java.util.List.class))
            .body("[0].category", equalToIgnoringCase("organic"));
        
        System.out.println("✓ CP-007b Pasó: Filtrado por categoría funcional");
    }
    
    /**
     * CP-008: Obtener Producto por ID
     * Verifica que se puede obtener un producto específico por su ID
     */
    @Test
    @Order(3)
    @DisplayName("CP-008: Obtener Producto por ID")
    public void testGetProductById() {
        given()
            .spec(requestSpec)
        .when()
            .get("/products/" + testProductId)
        .then()
            .statusCode(200)
            .contentType(ContentType.JSON)
            .body("id", equalTo(testProductId))
            .body("name", notNullValue())
            .body("description", notNullValue())
            .body("price", notNullValue())
            .body("category", notNullValue())
            .body("stock", notNullValue())
            .body("price", greaterThan(0.0f))
            .body("stock", greaterThanOrEqualTo(0));
        
        System.out.println("✓ CP-008 Pasó: Producto obtenido por ID correctamente");
        System.out.println("  Product ID consultado: " + testProductId);
    }
    
    /**
     * CP-009: Producto No Encontrado
     * Verifica que el sistema retorna error cuando el producto no existe
     */
    @Test
    @Order(4)
    @DisplayName("CP-009: Producto No Encontrado")
    public void testGetProductNotFound() {
        String nonExistentProductId = "999999";
        
        given()
            .spec(requestSpec)
        .when()
            .get("/products/" + nonExistentProductId)
        .then()
            .statusCode(404)
            .contentType(ContentType.JSON)
            .body("error", containsStringIgnoringCase("Product not found"));
        
        System.out.println("✓ CP-009 Pasó: Producto inexistente manejado correctamente");
    }
    
    /**
     * CP-009b: Producto con ID Inválido
     * Verifica el manejo de IDs con formato inválido
     */
    @Test
    @Order(5)
    @DisplayName("CP-009b: Producto con ID Inválido")
    public void testGetProductInvalidId() {
        String invalidProductId = "abc-invalid";
        
        Response response = given()
                .spec(requestSpec)
            .when()
                .get("/products/" + invalidProductId)
            .then()
                .statusCode(anyOf(equalTo(400), equalTo(404)))
                .contentType(ContentType.JSON)
            .extract()
                .response();
        
        System.out.println("✓ CP-009b Pasó: ID inválido manejado correctamente");
        System.out.println("  Status code: " + response.statusCode());
    }
    
    /**
     * Test auxiliar para obtener el productId guardado
     */
    public static String getTestProductId() {
        return testProductId;
    }
    
    @AfterAll
    public static void tearDown() {
        System.out.println("\n=== Resumen de Pruebas de Productos ===");
        System.out.println("Todas las pruebas del módulo de productos completadas");
    }
}
