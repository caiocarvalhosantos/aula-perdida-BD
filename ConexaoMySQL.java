/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.exemplocrud;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Professor
 */
public class ConexaoMySQL {
    private static final String URL = "jdbc:mysql://localhost:3306/bd_java";
    private static final String User = "root";
    private static final String Senha = "1234";
    
    public static Connection conectar() {
        Connection conexao = null;
        try {
            conexao = DriverManager.getConnection(URL, User, Senha);
            System.out.println("Conectou!");
        } catch (SQLException e) {
            System.out.println("Erro: " + e.getMessage());
        }
        return conexao;
    }
}
