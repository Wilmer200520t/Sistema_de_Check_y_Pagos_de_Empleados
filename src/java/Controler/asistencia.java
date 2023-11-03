package Controler;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "asistencia", urlPatterns = {"/asistencia"})


public class asistencia extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lógica para manejar solicitudes GET
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String DNI = request.getParameter("DNI");
        String nombre = request.getParameter("nombre");
        String fecha = request.getParameter("fecha");
        String horai = request.getParameter("horai");
        String horas = request.getParameter("horas");
    

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Establece la conexión con la base de datos
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/asistencia";
            String usuarioDB = "root";
            String contraseñaDB = "";
            conn = DriverManager.getConnection(url, usuarioDB, contraseñaDB);

            // Inserta el registro de asistencia en la base de datos
            String mysql = "INSERT INTO registros_asistencia (DNI, fecha, horai, horas, nombre) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(mysql);
            stmt.setString(1, DNI);
            stmt.setString(2, fecha);
            stmt.setString(3, horai);
            stmt.setString(4, horas);
            stmt.setString(5, nombre );
            stmt.executeUpdate();
            
            // Redirige de vuelta a la página principal
            response.sendRedirect("index.jsp");
} catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Cierra la conexión y la declaración
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}