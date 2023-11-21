package servelet;

import Controler.conexion;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "serveletLogin", urlPatterns = {"/Login"})
public class serveletLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = request.getParameter("iduser");
        String password = request.getParameter("txtpassword");
        String error = "";
        String promisseid = "";
        String passpromisse = "";
        int tuser = -1;

        if (id.equals("") || password.equals("")) {
            String respuesta = "<input type='text' class='invisible login' "
                    + "data-text='Asegurese que el campo iduser y contraseña no este vacio.' "
                    + "data-icon='error' data-titulo='Rellene todos los campos' data-user='' data-num='camposvacios'>";
            request.setAttribute("respuesta", respuesta);
            request.getRequestDispatcher("/login.jsp").forward(request, resp);
        } else {
            try {
                conexion cn = new conexion();
                Connection conex = cn.getConexion();
                cn.st = conex.createStatement();
                cn.rs = cn.st.executeQuery("call sp_login_users(" + id + ",'" + password + "',@error,@promisse,@passpromisse)");
                while (cn.rs.next()) {
                    error = cn.rs.getString(1);
                    promisseid = cn.rs.getString(2);
                    passpromisse = cn.rs.getString(3);
                    tuser = cn.rs.getInt(4);
                }
                if (error == null) {
                    if (passpromisse.equals(password)) {
                        String dir = "";
                        if (tuser == 1) {
                            dir = "cuadro.jsp";
                        } else if (tuser == 2) {
                            dir = "registro.jsp";
                        }
                        try {
                            HttpSession session = request.getSession();
                            session.setAttribute("iduser", id);
                            session.setAttribute("datos", traerDatos(id));
                            session.setAttribute("pagos", informacionPagos(id));
                            resp.sendRedirect(dir);
                        } catch (IOException e) {
                            out.println(e);
                        }

                    } else {

                        String respuesta = "<input type='text' class='invisible login' "
                                + "data-text='La contraseña no coincide con el id de usuario.' "
                                + "data-icon='error' data-titulo='Contraseña incorrecta' data-user='" + id + "'>";
                        request.setAttribute("respuesta", respuesta);
                        request.getRequestDispatcher("/login.jsp").forward(request, resp);
                    }

                } else {
                    String respuesta = "<input type='text' class='invisible login' "
                            + "data-text='" + error + "' "
                            + "data-icon='error' data-titulo='Error' data-user='" + id + "'>";
                    request.setAttribute("respuesta", respuesta);
                    request.getRequestDispatcher("/login.jsp").forward(request, resp);
                }

            } catch (ClassNotFoundException | SQLException e) {
                System.err.println(e);
            }
        }

    }
    
    private String[] traerDatos(String iduser) {

        String datoUser[]=new String[8];
        try {

            conexion cn = new conexion();
            Connection conex = cn.getConexion();
            cn.st = conex.createStatement();
            cn.rs = cn.st.executeQuery("call sp_datos_user(" + iduser + ")");
            while (cn.rs.next()) {
                datoUser[0] = cn.rs.getString(10);
                datoUser[1] = cn.rs.getString(11);
                datoUser[2] = cn.rs.getString(12);
                datoUser[3] = cn.rs.getString(13);
                datoUser[4] = cn.rs.getString(14);
                datoUser[5] = cn.rs.getString(15);
                datoUser[6] = cn.rs.getString(16);
                datoUser[7] = cn.rs.getString(20) + " - " + cn.rs.getString(23) + " - " + cn.rs.getString(22);
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            out.print(e);
        }
        return datoUser;
    }
    
    private String[] informacionPagos(String iduser){
        String datoUser[] = new String[16];

        try {
            conexion cn = new conexion();
            Connection conex = cn.getConexion();
            cn.st = conex.createStatement();
            cn.rs = cn.st.executeQuery("call SP_llamar_user_payments_works(" + iduser + ",0)");
            while (cn.rs.next()) {
                datoUser[0] = cn.rs.getString(31);
                datoUser[1] = cn.rs.getString(25);
                datoUser[2] = cn.rs.getString(33);
                datoUser[3] = cn.rs.getString(26);
                datoUser[4] = cn.rs.getString(34);
                datoUser[5] = cn.rs.getString(27);
                datoUser[6] = cn.rs.getString(35);
                datoUser[7] = cn.rs.getString(28);
                datoUser[8] = cn.rs.getString(36);
                datoUser[9] = cn.rs.getString(29);
                datoUser[10] = cn.rs.getString(37);
                datoUser[11] = cn.rs.getString(30);
                datoUser[12] = cn.rs.getString(38);
                datoUser[13] = cn.rs.getString(39);
                datoUser[14] = cn.rs.getString(40);
                datoUser[15] = cn.rs.getString(44);
            }
        } catch (ClassNotFoundException | SQLException e) {
        }
        return datoUser;
    }
    
}
