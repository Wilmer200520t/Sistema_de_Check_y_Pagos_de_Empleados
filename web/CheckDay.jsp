<%@page import="java.sql.*"%>
<%@page import="Controler.conexion" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Day</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" 
    rel="stylesheet" 
    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" 
    crossorigin="anonymous">
    <link rel="stylesheet" href="Encabezado.css">
    <link rel="stylesheet" href="Style-body.css">
    <link rel="stylesheet" href="Footer.css">
    <link rel="stylesheet" 
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
    <header class="encabezado">
        <div class="logoET">
            <a href="index.jsp">
                <img href="index.jsp" src="SRC/Logo.png" alt="Logo Empresa">
            </a>
        </div>
        <nav>
            <ul class="nav_links">
                <li><a href="Index.jsp">Inicio</a></li>
                <li><a href="Servicios.jsp">Servicios</a></li>
                <li><a href="Nosotros.jsp">Nosotros</a></li>
                <li><a href="CheckDay.jsp">Marcar Asistencia</a></li>
            </ul>
        </nav>
        <a href="login.jsp" class="boton_ingresar_registrarse"><button>Iniciar Sesión</button></a>
        <a onclick="openNav()" href="#" class="boton-menu"><button>Menú</button></a>
        
        <div class="overlay" id="mobile-menu">
            <a onclick="closeNav()" href="#" class="close">&times;</a>
            <div class="overlay-content">
                <a href="Index.jsp">Inicio</a>
                <a href="Servicios.jsp">Servicios</a>
                <a href="Nosotros.jsp">Nosotros</a>

                <div class="boton-nosotros">
                    <a href="login.jsp"><button>Iniciar Sesión</button></a>
                </div>
            </div>
        </div>
    </header>
    <%
        conexion cn=new conexion();
        Connection conex=cn.getConexion();
        cn.st=conex.createStatement();
     
    %>
    <div class="marcar">
        <form  class="login-form" >
            <h2>Marcar Asistencia</h2>
            <input type="text" placeholder="&#128100; Iduser" name="iduser"><br><br>
            <button type="submit" class="but" name="mark">Marcar</button>
            
        </form>
    </div>
    <% 
        if(request.getParameter("mark")!=null){
            String iduser=request.getParameter("iduser");
            String fecha="",hora="",tipo="";
            int count=-1;
            if(iduser.equals("")){}else{
                try {
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
                                out.println("<input type='text' class='invisible icheck' "
                                        + "data-fecha='" + fecha + "' data-hora='" + hora + "' data-tipo='" + tipo + "' "
                                        + "data-icon='success' data-titulo='Marcacion Correcta' data-user='" + iduser + "'>");
                            } else {
                                out.println("<input type='text' class='invisible icheck' "
                                        + "data-fecha='' data-hora='' data-tipo='' "
                                        + "data-icon='error' data-titulo='Usuario no Encontrado' data-user='" + iduser + "'>");
                            }
                } catch (Exception e) {
                    out.print(e);
                }
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

    <script type="text/javascript" src="JS/Slide.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="JS/alerts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
