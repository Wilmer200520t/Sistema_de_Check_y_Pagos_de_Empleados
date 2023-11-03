<%@page import="java.sql.*"%>
<%@page import="Controler.conexion" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
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
        <form style="text-align: center" >
            <h1>Iniciar sesión </h1>
                 <input type="text" name="iduser" placeholder="&#128100; Usuario" class="cajaentradatexto">
                 <input type="txt" name="txtpassword"
                        placeholder="&#128274; Contraseña" class="cajaentradatexto">
                 <button type="submit" name="inicio" class="but" >Iniciar Sesion</button>
        </form>
    </div>
    <% 
        if (request.getParameter("inicio") != null) {
                    String id = request.getParameter("iduser");
                    String password = request.getParameter("txtpassword");
                    String error="";
                    String promisseid="";
                    String passpromisse="";
                    int tuser=-1;
                    
                if (id.equals("") || password.equals("") ) {
                    out.println("<input type='text' class='invisible login' "
                                        + "data-text='Asegurese que el campo iduser y contraseña no este vacio.' "
                                        + "data-icon='error' data-titulo='Rellene todos los campos' data-user='' data-num='camposvacios'>");
                }else{
                    try {
                            int count = 0;
                            String dbid = "", dbpass = "";
                            cn.rs=cn.st.executeQuery("call sp_login_users("+id+",'"+password+"',@error,@promisse,@passpromisse)");
                            while(cn.rs.next()){
                                error=cn.rs.getString(1);
                                promisseid=cn.rs.getString(2);
                                passpromisse=cn.rs.getString(3);
                                tuser=cn.rs.getInt(4);
                            }
                            if(error==null){
                                if (passpromisse.equals(password)) {
                                        String dir = "";
                                        if (tuser == 1) {
                                            dir = "cuadro.jsp";
                                        } else if (tuser == 2) {
                                            dir = "registro.jsp";
                                        }
                                        try {
                                            response.sendRedirect(dir);
                                            session.setAttribute("iduser", id);
                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    
                                }else{
                                    out.println("<input type='text' class='invisible login' "
                                        + "data-text='La contraseña no coincide con el id de usuario.' "
                                        + "data-icon='error' data-titulo='Contraseña incorrecta' data-user='"+id+"'>");
                                }
                                
                            }else{
                                out.println("<input type='text' class='invisible login' "
                                        + "data-text='"+error+"' "
                                        + "data-icon='error' data-titulo='Error' data-user='"+id+"'>");
                            }
                            
                            
                    } catch (Exception e) {
                        System.err.println(e);
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
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
     <script type="text/javascript" src="JS/alerts.js"></script>
    <script type="text/javascript" src="JS/Slide.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
