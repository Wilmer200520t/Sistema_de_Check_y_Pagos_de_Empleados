
package servelet;

import Controler.conexion;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "serveletRegistro", urlPatterns = {"/Registro"})
public class serveletRegistro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                String name=request.getParameter("nombres");
                String lastn=request.getParameter("apellidos");
                String edad=request.getParameter("edad");
                String dni=request.getParameter("DNI");
                String pass=request.getParameter("pass");
                String cumpleaños=request.getParameter("cumpleanos");
                String direccion=request.getParameter("direccion");
                String pais=request.getParameter("pais");
                String typeu=request.getParameter("typeuser");
                String sucursal=request.getParameter("sucursal");
                String respuesta="";
                int id=0;
                int res=0;
               
                try {
                        conexion cn = new conexion();
                        Connection conex = cn.getConexion();
                        cn.st = conex.createStatement();
                    
                        cn.rs = cn.st.executeQuery("call sp_registro_usuarios("+typeu +",'"+ pass + "','" + name + "'"
                                + ",'" + lastn + "'," + edad + "," + dni + ",'" + cumpleaños + "','" + direccion + "','" + pais + "'," + sucursal + ")");
                                
                        while (cn.rs.next()) {
                            res=cn.rs.getInt(1);
                            id=cn.rs.getInt(2);
                        }
                        
                        if(res==1){
                            respuesta="<input type='text' class='invisible registro' "
                                        + "data-text='Usuario registrado corectamente.' "
                                        + "data-icon='success' data-titulo='Registro Existoso' data-user='"+id+"'>";
                        }else{
                            respuesta="<input type='text' class='invisible registro' "
                                        + "data-text='Usuario no registrado.' "
                                        + "data-icon='error' data-titulo='Error al Registrar' data-user='"+id+"'>";
                        }
                        request.setAttribute("respuesta", respuesta);

                        request.getRequestDispatcher("/registro.jsp").forward(request, response);

                    } catch (ClassNotFoundException | SQLException e) {
                        respuesta="<input type='text' class='invisible registro' "
                                        + "data-text='"+e+"' "
                                        + "data-icon='error' data-titulo='Error' data-user='"+id+"'>";
                        request.setAttribute("respuesta", respuesta);
                        request.getRequestDispatcher("/registro.jsp").forward(request, response);
                    }
    }

}
