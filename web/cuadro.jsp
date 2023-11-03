<%@page import="Controler.conexion"%>
<%@page import="java.sql.*"%>
<%@page import="Controler.CalcularHoras"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Informacion</title>
        <link rel="stylesheet" href="cuadro.css"> 

    
</head>

    <% 
            String iduser = (String) session.getAttribute("iduser");
            conexion cn = new conexion();
            Connection conex = cn.getConexion();
            cn.st = conex.createStatement();
            String nombre = "",apellido= "",edad= "",dni= "",nacimiento= "",pais= "",sucursal= "",direccion="",mes="";
            
            if (iduser != null) {
                try {
                    cn.rs = cn.st.executeQuery("call SP_llamar_user_payments_works(" + iduser + ",0)");
                    while (cn.rs.next()) {
                        nombre = cn.rs.getString(10);
                        apellido=cn.rs.getString(11);
                        edad=cn.rs.getString(12);
                        dni=cn.rs.getString(13);
                        nacimiento=cn.rs.getString(14);
                        direccion=cn.rs.getString(15);
                        pais=cn.rs.getString(16);
                        sucursal=cn.rs.getString(20)+" - "+cn.rs.getString(23)+" - "+cn.rs.getString(22);
                        
                }   
                } catch (Exception e) {
                }
                   
                    
                    
                        
        
    
    %>
    <h1>Información de empleado</h1> <a href="login.jsp">Cerrar Sesion</a>
    <div class="info-container">   
        <h4>Nombre: <%= nombre%></h4>
        <h4>Apellidos: <%= apellido%></h4>
        <h4>Edad: <%= edad%></h4>
        <h4>DNI: <%= dni%></h4>
        <h4>Nacimiento: <%= nacimiento%></h4>
        <h4>Direccion: <%= direccion%></h4>
        <h4>Pais: <%= pais%></h4>
        <h4>Sucursal:<%= sucursal%></h4>
    </div>
    <% 
        //mostrarTabla(String iduser,String idPer){}
        String update="",horn="",pagn="",hors="",pags="",hord="",pagd="",horf="",pagf="",horp="",pagp="",horr="",pagr="",bono="",pago="";
        String idper=request.getParameter("periodobusc");
        if(idper==null){
            idper="0"; 
        }
        if(request.getParameter("buscar")!=null){
        try {
                cn.rs = cn.st.executeQuery("call SP_llamar_user_payments_works(" + iduser + ","+idper+")");
                while (cn.rs.next()) {
                    update = cn.rs.getString(31);
                    horn= cn.rs.getString(25);
                    pagn= cn.rs.getString(33);
                    hors= cn.rs.getString(26);
                    pags= cn.rs.getString(34);
                    hord= cn.rs.getString(27);
                    pagd= cn.rs.getString(35);
                    horf= cn.rs.getString(28);
                    pagf= cn.rs.getString(36);
                    horp= cn.rs.getString(29);
                    pagp= cn.rs.getString(37);
                    horr= cn.rs.getString(30);
                    pagr= cn.rs.getString(38);
                    bono= cn.rs.getString(39);
                    pago= cn.rs.getString(40);
                    mes=cn.rs.getString(44);
                }
            } catch (Exception e) {
            }
        }
    %>

    <h1>Tabla de Pagos <%=mes %></h1>
    <div class="form-container">
        <form method="POST">
            <button type="submit" onclick="" name="actualizar">Actualizar pagos</button>
            <select name="periodo">

                <%
                    try {
                        cn.rs = cn.st.executeQuery("call sp_read_users_periods(" + iduser + ")");
                        while (cn.rs.next()) {


                %>
                <option value="<%= cn.rs.getString(1)%>"><%= cn.rs.getString(2)%></option>
                <%
                        }
                    } catch (Exception e) {
                    }
                %>
            </select>
        </form>

        <form>
            <button type="submit" onclick="" name="buscar">Buscar Periodo</button>
            <select name="periodobusc">

                <%
                    try {
                        cn.rs = cn.st.executeQuery("call sp_read_users_periods(" + iduser + ")");
                        while (cn.rs.next()) {


                %>
                <option value="<%= cn.rs.getString(1)%>"><%= cn.rs.getString(2)%></option>
                <%
                        }
                    } catch (Exception e) {
                    }
                %>
            </select>
        </form>
    </div>
    
    
    
    <% 
        if(request.getParameter("actualizar") !=null){
            String idpe=request.getParameter("periodo");

            CalcularHoras cal=new CalcularHoras(iduser,idpe);
        }
            
     
    %>
<table class="styled-table">    
    <thead>
        <tr>
            <th>Descripción</th>
            <th>Días</th>
            <th>Monto a pagar</th>
            <th>Ultima Actualizacion</th>
        </tr>
    </thead>
    
    <tbody>
        <tr>
            <td>Horas laborados-L-V</td>
            <td><%= horn %></td>
            <td><%= pagn %></td>
            <td><%= update %></td>
        </tr>
        <tr>
            <td>Horas  laborados-sábados</td>
            <td><%= hors %></td>
            <td><%= pags %></td>
            <td><%= update %></td>
        </tr>
        <tr>
            <td>Horas  laborados-domingos</td>
            <td><%= hord %></td>
            <td><%= pagd %></td>
            <td><%= update %></td>
        </tr>
        <tr>
            <td>Horas  laborados-feriados</td>
            <td><%= horf %></td>
            <td><%= pagf %></td>
            <td><%= update %></td>
        </tr>
        <tr>
            <td>Horas  peridadas</td>
            <td><%= horp %></td>
            <td><%= pagp %></td>
            <td><%= update %></td>
        </tr>
        <tr>
            <td>Horas  recuperación</td>
            <td><%= horr %></td>
            <td><%= pagr %></td>
            <td><%= update %></td>
        </tr>
        <tr>
            <td>Bono de trabajo</td>
            <td>0</td>
            <td><%= bono %></td>
            <td><%= update %></td>
        </tr>
        <tr>
            <td>Pago total</td>
            <td>0</td>
            <td><%= pago %></td>
            <td><%= update %></td>
        </tr>

    </tbody>
    <%
        
       
    }
    %>
</table>
    
</html>
