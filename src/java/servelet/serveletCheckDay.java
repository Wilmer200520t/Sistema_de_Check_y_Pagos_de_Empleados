
package servelet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import Controler.conexion;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "serveletCheckDay", urlPatterns = {"/CheckDay"})
public class serveletCheckDay extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp)throws ServletException, IOException {
        try {
            conexion cn = new conexion();
            Connection conex = cn.getConexion();
            cn.st = conex.createStatement();
            
            String iduser = request.getParameter("iduser");
            String fecha = "", hora = "", tipo = "";
            int count = -1;
            if (iduser.equals("")) {
            } else {
                cn.rs = cn.st.executeQuery("CALL sp_buscarUser(" + iduser + ")");
                while (cn.rs.next()) {
                    count = cn.rs.getInt(1);
                }
                if (count == 1) {
                    cn.rs = cn.st.executeQuery("CALL sp_check_(" + iduser + ")");
                    while (cn.rs.next()) {
                        fecha = cn.rs.getString(1);
                        hora = cn.rs.getString(2);
                        tipo = cn.rs.getString(3);
                    }
                    String respuesta="<input type='text' class='invisible icheck' "
                            + "data-fecha='" + fecha + "' data-hora='" + hora + "' data-tipo='" + tipo + "' "
                            + "data-icon='success' data-titulo='Marcacion Correcta' data-user='" + iduser + "'>";
                    request.setAttribute("respuesta", respuesta);
                    request.getRequestDispatcher("/CheckDay.jsp").forward(request, resp);
                } else {
                    
                    String respuesta="<input type='text' class='invisible icheck' "
                            + "data-fecha='' data-hora='' data-tipo='' "
                            + "data-icon='error' data-titulo='Usuario no Encontrado' data-user='" + iduser + "'>";
                    request.setAttribute("respuesta", respuesta);
                    request.getRequestDispatcher("/CheckDay.jsp").forward(request, resp);
                }

            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(serveletCheckDay.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    
    }

   
}
