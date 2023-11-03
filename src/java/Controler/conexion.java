package Controler;

import java.sql.*;

public class conexion {
    public Statement st;
    public ResultSet rs;
    public static Connection getConexion() throws ClassNotFoundException{
        Connection con=null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3345/reg_empleados_tesla?user=root");
        } catch (SQLException e) {
            
        }

        return con;  
    }
    public static void main(String[] args) throws ClassNotFoundException {
        conexion.getConexion();
    }
}
