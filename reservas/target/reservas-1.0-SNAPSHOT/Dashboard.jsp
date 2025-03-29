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
        <%-- ... (código anterior igual) ... --%>
        <%
            HttpSession sessionObj = request.getSession(false);
            usuario user = (sessionObj != null) ? (usuario) sessionObj.getAttribute("userSession") : null;

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            controladorUsuario usuController = new controladorUsuario();
            List<reserva> Reservas = new ArrayList<>();

            if (user.getRol().equals(2)) { // Rol de usuario normal
                Reservas = usuController.ConsultarReservasUser(user.getId());
            } else if (user.getRol().equals(1)) { // Rol de administrador
                //reservas = usuController.ConsultarTodasReservas(); // Necesitarás implementar este método
            }
        %>
    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-8">
                                <h2>
                                    <% if (user.getRol().equals(1)) { %>
                                    Todas las <b>Reservas</b>
                                    <% } else { %>
                                    Mis <b>Reservas</b>
                                    <% } %>
                                </h2>
                            </div>
                            <div class="col-sm-4">
                                <div class="search-box">
                                    <i class="material-icons">&#xE8B6;</i>
                                    <input type="text" class="form-control" placeholder="Buscar&hellip;">
                                </div>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover table-bordered">
                        <thead>
                            <tr>
                                <th>#</th>
                                    <% if (user.getRol().equals(1)) { %>
                                <th>Usuario</th>
                                    <% } %>
                                <th>Fecha</th>
                                <th>Hora Inicio</th>
                                <th>Hora Fin</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (reservas.isEmpty()) {%>
                            <tr>
                                <td colspan="<%= user.getRol().equals(1) ? 7 : 6%>" class="text-center">
                                    No se encontraron reservas
                                </td>
                            </tr>
                            <% } else {
                                for (int i = 0; i < reservas.size(); i++) {
                                    Reserva r = reservas.get(i);
                            %>
                            <tr>
                                <td><%= i + 1%></td>
                                <% if (user.getRol().equals(1)) {%>
                                <td><%= r.getUsuario().getNombre()%></td>
                                <% }%>
                                <td><%= r.getFecha()%></td>
                                <td><%= r.getHoraInicio()%></td>
                                <td><%= r.getHoraFin()%></td>
                                <td><%= r.getEstado()%></td>
                                <td>
                                    <a href="#" class="view" title="Ver" data-toggle="tooltip">
                                        <i class="material-icons">&#xE417;</i>
                                    </a>
                                    <% if (user.getRol().equals(1) || r.getEstado().equals("PENDIENTE")) { %>
                                    <a href="#" class="edit" title="Editar" data-toggle="tooltip">
                                        <i class="material-icons">&#xE254;</i>
                                    </a>
                                    <a href="#" class="delete" title="Cancelar" data-toggle="tooltip">
                                        <i class="material-icons">&#xE872;</i>
                                    </a>
                                    <% } %>
                                </td>
                            </tr>
                            <% }
                            }%>
                        </tbody>
                    </table>
                </div>
            </div>  
        </div>   
        <%-- ... (resto del código igual) ... --%>

        <script src="dash.js"></script>
    </body>

</html>
