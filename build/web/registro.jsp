<%@page import="java.sql.*"%>
<%@page import="Controler.conexion" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro de Usuarios</title>        
        <link rel="stylesheet" href="Encabezado.css">
        <link rel="stylesheet" href="Style-body.css">
        <link rel="stylesheet" href="Footer.css">
        <link rel="stylesheet" href="registrar.css">
    <link rel="stylesheet" 
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <header class="encabezado">
            <div class="logoET">
                <a href="index.jsp">
                    <img href="#" src="SRC/Logo.png" alt="Logo Empresa">
                </a>
            </div>  
            <a href="login.jsp" class="boton_ingresar_registrarse"><button>Cerrar Seccion</button></a>
        </header>
    <%
        conexion cn=new conexion();
        Connection conex=cn.getConexion();
        cn.st=conex.createStatement();
     
    %>
        <div class="marcar-c">
            <form>
                <h2>Registrar empleado</h2>
                <div class="form-row">
                    <label for="nombre" class="form-label">Tipo usuario:</label>
                    <select  name="typeuser" class="form-input">
                        <%                            cn.rs = cn.st.executeQuery("call sp_readTypesUsers();");
                            while (cn.rs.next()) {
                                out.print("<option value='" + cn.rs.getString(1) + "' class='select'>" + cn.rs.getString(2) + "</option>");
                            }
                        %>
                    </select>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <label for="nombre" class="form-label">Empresa:</label>
                    <select  name="sucursal" class="form-input">
                        <%
                            cn.rs = cn.st.executeQuery("call sp_readFactories();");
                            while (cn.rs.next()) {
                                out.print("<option value='" + cn.rs.getString(1) + "' class='select'>" + cn.rs.getString(2) + " - " + cn.rs.getString(3) + "</option>");
                            }
                        %>
                    </select>
                </div>
                <div class="form-row">
                    <input type="text" placeholder="Nombres" name="nombres" required class="form-input"> <input type="text" placeholder="Apellidos" name="apellidos" required class="form-input">
                </div>
                <div class="form-row">
                    <input type="number" placeholder="Edad" name="edad" required> <input type="number" placeholder="DNI" name="DNI" required>
                </div>
                <div class="form-row">
                    <input type="password" placeholder="&#128274; Contraseña" name="pass" required>
                    <input type="date" placeholder="Cumpleaños" name="cumpleaños" required>
                </div>
                <div class="form-row">
                    <input type="text" placeholder="Direccion" name="direccion" required>
                    <input type="text" placeholder="País" name="pais" required>
                </div>
                <div class="form-row">
                    <input type="submit" value="Registrar" name="btnregistrar" class="but"><br>
                </div>
                <form/>
        </div >
        
        
        <% 
            if(request.getParameter("btnregistrar")!=null){
                String name=request.getParameter("nombres");
                String lastn=request.getParameter("apellidos");
                String edad=request.getParameter("edad");
                String dni=request.getParameter("DNI");
                String pass=request.getParameter("pass");
                String cumpleaños=request.getParameter("cumpleaños");
                String direccion=request.getParameter("direccion");
                String pais=request.getParameter("pais");
                String typeu=request.getParameter("typeuser");
                String sucursal=request.getParameter("sucursal");
                int id=0;
                int res=0;

                try {
                        
                    
                        cn.rs = cn.st.executeQuery("call sp_registro_usuarios("+typeu +",'"+ pass + "','" + name + "'"
                                + ",'" + lastn + "'," + edad + "," + dni + ",'" + cumpleaños + "','" + direccion + "','" + pais + "'," + sucursal + ")");
                                
                        while (cn.rs.next()) {
                            res=cn.rs.getInt(1);
                            id=cn.rs.getInt(2);
                        }
                        
                        if(res==1){
                            out.println("<input type='text' class='invisible registro' "
                                        + "data-text='Usuario registrado corectamente.' "
                                        + "data-icon='success' data-titulo='Registro Existoso' data-user='"+id+"'>");
                        }else{
                            out.println("<input type='text' class='invisible registro' "
                                        + "data-text='Usuario no registrado.' "
                                        + "data-icon='error' data-titulo='Error al Registrar' data-user='"+id+"'>");
                        }
                        

                    } catch (Exception e) {
                        System.out.println(e);
                        out.print(e);
                        out.println("<input type='text' class='invisible registro' "
                                        + "data-text='"+e+"' "
                                        + "data-icon='error' data-titulo='Error' data-user='"+id+"'>");
                    }
                
            }
        
        %>
        <footer class="pie_pag">
            <div class="footer">
                <ul class="list">
                    <li>
                        <a href="Index.jsp">Inicio</a>
                    </li>
                    <li>
                        <a href="Servicios.jsp">Servicios</a>
                    </li>
                    <li>
                        <a href="Nosotros.jsp">Nosotros</a>
                    </li>
                    </li>
                </ul>
                <p class="copyright">
                    Plataforma de empleado © 2023 | Hecho por Polo y Zuñiga
                </p>
            </div>
        </footer>

    </body>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
     <script type="text/javascript" src="JS/alerts.js"></script>
</html>
