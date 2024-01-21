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

@WebServlet(name = "serveletInformacion", urlPatterns = {"/Buscar"})
public class serveletInformacion extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String idper = request.getParameter("periodobusc");
        String iduser = (String) session.getAttribute("iduser");

        session.setAttribute("iduser", iduser);
        session.setAttribute("datos", traerDatos(iduser));
        session.setAttribute("pagos", informacionPagos(iduser, idper));
        resp.sendRedirect("cuadro.jsp");
    }

    private String[] informacionPagos(String iduser, String idper) {
        String datoUser[] = new String[16];
        if (idper == null) {
            idper = "0";
        }
        try {
            conexion cn = new conexion();
            Connection conex = cn.getConexion();
            cn.st = conex.createStatement();
            cn.rs = cn.st.executeQuery("call SP_llamar_user_payments_works(" + iduser + "," + idper + ")");
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

    private String[] traerDatos(String iduser) {

        String datoUser[] = new String[8];
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
}
