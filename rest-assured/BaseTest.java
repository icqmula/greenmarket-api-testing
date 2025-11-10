package com.greenmarket.tests.base;

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;
import org.junit.jupiter.api.BeforeAll;

/**
 * Clase base para todas las pruebas de API
 * Contiene configuración común y métodos auxiliares
 */
public class BaseTest {
    
    protected static RequestSpecification requestSpec;
    protected static String baseUrl = "https://api.greenmarket.com/v1";
    protected static String authToken;
    protected static String userId;
    
    @BeforeAll
    public static void setup() {
        // Configuración base de REST Assured
        RestAssured.baseURI = baseUrl;
        
        // Request Specification común
        requestSpec = new RequestSpecBuilder()
                .setBaseUri(baseUrl)
                .setContentType(ContentType.JSON)
                .setAccept(ContentType.JSON)
                .build();
    }
    
    /**
     * Configura el token de autenticación para las pruebas
     * @param token Token JWT obtenido del login
     */
    protected static void setAuthToken(String token) {
        authToken = token;
        requestSpec = new RequestSpecBuilder()
                .addRequestSpecification(requestSpec)
                .addHeader("Authorization", "Bearer " + token)
                .build();
    }
    
    /**
     * Obtiene el token de autenticación actual
     * @return Token JWT
     */
    protected static String getAuthToken() {
        return authToken;
    }
    
    /**
     * Establece el ID del usuario para pruebas
     * @param id ID del usuario
     */
    protected static void setUserId(String id) {
        userId = id;
    }
    
    /**
     * Obtiene el ID del usuario actual
     * @return ID del usuario
     */
    protected static String getUserId() {
        return userId;
    }
}
