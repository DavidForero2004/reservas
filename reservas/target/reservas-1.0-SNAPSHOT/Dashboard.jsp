<%-- 
    Document   : Dashboard
    Created on : 28/03/2025, 6:25:14 p. m.
    Author     : david
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.reserva"%>
<%@page import="java.util.List"%>
<%@page import="controlador.controladorUsuario"%>
<%@page import="modelo.usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="dash.css"/>
        <title>ReservasGymGold</title>
    </head>

    <body>
        <%
            HttpSession sessionObj = request.getSession(false);
            usuario user = (sessionObj != null) ? (usuario) sessionObj.getAttribute("userSession") : null;
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            controladorUsuario usuController = new controladorUsuario();

            List<reserva> Reservas = new ArrayList<>();

            if (user.getRol().getId().equals(2)) {
                // Rol de usuario normal
                Reservas = usuController.ConsultarReservasUser(user.getId());
            } else if (user.getRol().getId().equals(1)) {
                // Rol de administrador
                Reservas = usuController.ConsultarReservas();
            }
        %>
    <body>

        <% int i = 1;

            for (reserva res : Reservas) {

        %>

        <table>
            <thead>
            <th>id</th>
            <th>nombre</th>
            <th>correo</th>
            <th>telefono</th>
            <th>Fecha</th>
            <th>hora Inicio</th>
            <th>Hora Fin</th>
            <th>Estado</th>
        </thead>
        <tbody>
            <td><%=i%></td>
            <td><%=res.getUsuario().getNombre()%></td>
            <td><%=res.getUsuario().getCorreo()%></td>
            <td><%=res.getUsuario().getTelefono()%></td>
            <td><%=res.getFecha()%></td>
            <td><%=res.getHoraInicio()%></td>
            <td><%=res.getHoraFin()%></td>
            <td><%=res.getEstado()%></td>
        </tbody>
        </table>

<%               i++;
    }
%>
<script src="dash.js"></script>
</body>

</html>
