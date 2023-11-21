<%@page import="Controler.conexion"%>
<%@page import="java.sql.*"%>
<%@page import="Controler.CalcularHoras"%>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Informacion</title>
        <link rel="stylesheet" href="cuadro.css"> 

    
</head>

    <% 
            conexion cn = new conexion();
            Connection conex = cn.getConexion();
            cn.st = conex.createStatement();
            String[] datosUser= (String[]) session.getAttribute("datos");
            String[] datPay= (String[]) session.getAttribute("pagos");
            String iduser= (String) session.getAttribute("iduser");
                     
    %>
    <h1>Información de empleado</h1> <a href="login.jsp">Cerrar Sesion</a>
    <div class="info-container">   
        <h4>Nombre:  <%= datosUser[0]%></h4>
        <h4>Apellidos:  <%= datosUser[1]%></h4>
        <h4>Edad:  <%= datosUser[2]%></h4>
        <h4>DNI:  <%= datosUser[3]%></h4>
        <h4>Nacimiento:  <%= datosUser[4]%></h4>
        <h4>Direccion:  <%= datosUser[5]%></h4>
        <h4>Pais:  <%= datosUser[6]%></h4>
        <h4>Sucursal:  <%= datosUser[7]%></h4>
    </div>

    <h1>Tabla de Pagos <%=datPay[15] %></h1>
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

        <form action="Buscar" method="post">
            <button type="submit" name="buscar">Buscar Periodo</button>
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
            <th>Horas</th>
            <th>Monto a pagar</th>
            <th>Ultima Actualizacion</th>
        </tr>
    </thead>
    
    <tbody>
        <tr>
            <td>Horas laborados-L-V</td>
            <td><%= datPay[1] %></td>
            <td><%= datPay[2] %></td>
            <td><%= datPay[0] %></td>
        </tr>
        <tr>
            <td>Horas  laborados-sábados</td>
            <td><%= datPay[3] %></td>
            <td><%= datPay[4] %></td>
            <td><%= datPay[0] %></td>
        </tr>
        <tr>
            <td>Horas  laborados-domingos</td>
            <td><%= datPay[5] %></td>
            <td><%= datPay[6] %></td>
            <td><%= datPay[0] %></td>
        </tr>
        <tr>
            <td>Horas  laborados-feriados</td>
            <td><%= datPay[7] %></td>
            <td><%= datPay[8] %></td>
            <td><%= datPay[0] %></td>
        </tr>
        <tr>
            <td>Horas  peridadas</td>
            <td><%= datPay[9] %></td>
            <td><%= datPay[10] %></td>
            <td><%= datPay[0] %></td>
        </tr>
        <tr>
            <td>Horas  recuperación</td>
            <td><%= datPay[11] %></td>
            <td><%= datPay[12] %></td>
            <td><%= datPay[0]%></td>
        </tr>
        <tr>
            <td>Bono de trabajo</td>
            <td>--</td>
            <td><%= datPay[13] %></td>
            <td><%= datPay[0] %></td>
        </tr>
        <tr>
            <td>Pago total</td>
            <td>--</td>
            <td><%= datPay[14] %></td>
            <td><%= datPay[0] %></td>
        </tr>

    </tbody>
</table>
    
</html>
