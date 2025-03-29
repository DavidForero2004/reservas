<%@page import="modelo.estado"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <title>ReservasGymGold</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <!-- DataTables -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap4.min.css">
        <style>
            .table-responsive {
                margin: 30px 0;
            }
            .table-wrapper {
                background: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 1px 1px rgba(0,0,0,.05);
            }
            .table-title {
                padding-bottom: 15px;
                background: #343a40;
                color: #fff;
                padding: 16px 30px;
                margin: -20px -20px 10px;
                border-radius: 5px 5px 0 0;
            }
            .table-title h2 {
                margin: 5px 0 0;
                font-size: 24px;
            }
        </style>
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
            //List<estado> Estados = new ArrayList<>();

            if (user.getRol().getId().equals(2)) {
                Reservas = usuController.ConsultarReservasUser(user.getId());
            } else if (user.getRol().getId().equals(1)) {
                Reservas = usuController.ConsultarReservas();
            }

            SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
        %>

        <div class="container-lg">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2>Gestión de <b>Reservas</b></h2>
                            </div>
                            <div class="col-sm-6">

                                <a href="#addReservaModal" class="btn btn-success" data-toggle="modal">
                                    <i class="fas fa-plus"></i> <span>Nueva Reserva</span>
                                </a>

                            </div>
                        </div>
                    </div>

                    <table id="reservasTable" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                    
                                <th>Usuario</th>
                                <th>Fecha</th>
                                <th>Hora Inicio</th>
                                <th>Hora Fin</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% int i = 1;
                                for (reserva res : Reservas) {%>
                            <tr>
                                <td><%=i%></td>
                                
                                <td><%=res.getUsuario().getNombre()%></td>
                               
                                <td><%=sdfDate.format(res.getFecha())%></td>
                                <td><%=res.getHoraInicio()%></td>
                                <td><%=res.getHoraFin()%></td>
                                <td><%=res.getEstado().getNombre() %> </td>
                                <td>
                                    <a href="#editReservaModal" class="edit" data-toggle="modal" 
                                       data-id="<%=res.getId()%>"
                                       data-fecha="<%=sdfDate.format(res.getFecha())%>"
                                       data-horainicio="<%=res.getHoraInicio()%>"
                                       data-horafin="<%=res.getHoraFin()%>"
                                       data-estado="<%=res.getEstado().getNombre()%>">
                                        <i class="fas fa-edit" title="Editar"></i>
                                    </a>
                                    <a href="#deleteReservaModal" class="delete" data-toggle="modal" 
                                       data-id="<%=res.getId()%>">
                                        <i class="fas fa-trash" title="Eliminar"></i>
                                    </a>
                                </td>
                            </tr>
                            <% i++;
                                }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Add Modal HTML -->
        <div id="addReservaModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="addReservaForm" action="controladorReserva" method="POST">
                        <input type="hidden" value="<%=user.getId()%>" name="id">

                        <div class="modal-header">                      
                            <h4 class="modal-title">Agregar Reserva</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">                    
                            <div class="form-group">
                                <label>Fecha</label>
                                <input type="date" class="form-control" name="fecha" required>
                            </div>
                            <div class="form-group">
                                <label>Hora Inicio</label>
                                <input type="time" class="form-control" name="horaInicio" required>
                            </div>
                            <div class="form-group">
                                <label>Hora Fin</label>
                                <input type="time" class="form-control" name="horaFin" required>
                            </div>
                            <input type="hidden" name="action" value="create">
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                            <input type="submit" class="btn btn-success" value="Guardar">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Modal HTML -->
        <div id="editReservaModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="editReservaForm" action="ReservaController" method="POST">
                        <div class="modal-header">                      
                            <h4 class="modal-title">Editar Reserva</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">                    
                            <input type="hidden" name="id" id="editId">
                            <div class="form-group">
                                <label>Fecha</label>
                                <input type="date" class="form-control" name="fecha" id="editFecha" required>
                            </div>
                            <div class="form-group">
                                <label>Hora Inicio</label>
                                <input type="time" class="form-control" name="horaInicio" id="editHoraInicio" required>
                            </div>
                            <div class="form-group">
                                <label>Hora Fin</label>
                                <input type="time" class="form-control" name="horaFin" id="editHoraFin" required>
                            </div>
                            <div class="form-group">
                                <label>Estado</label>
                                <select class="form-control" name="estado" id="editEstado" required>
                                    <option value="PENDIENTE">PENDIENTE</option>
                                    <option value="CONFIRMADA">CONFIRMADA</option>
                                    <option value="CANCELADA">CANCELADA</option>
                                </select>
                            </div>
                            <input type="hidden" name="action" value="update">
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                            <input type="submit" class="btn btn-info" value="Actualizar">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Delete Modal HTML -->
        <div id="deleteReservaModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="deleteReservaForm" action="controladorReserva" method="POST">
                        <div class="modal-header">                      
                            <h4 class="modal-title">Eliminar Reserva</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">                    
                            <input type="hidden" name="id" id="deleteId">
                            <p>¿Estás seguro que deseas eliminar esta reserva?</p>
                            <p class="text-warning"><small>Esta acción no se puede deshacer</small></p>
                            <input type="hidden" name="action" value="delete">
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                            <input type="submit" class="btn btn-danger" value="Eliminar">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- jQuery, Popper.js, Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <!-- DataTables JS -->
        <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap4.min.js"></script>

        <script>
            $(document).ready(function () {
                // Inicializar DataTable
                $('#reservasTable').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.11.3/i18n/es_es.json"
                    }
                });

                // Manejar edición - llenar modal con datos
                $('#editReservaModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var id = button.data('id');
                    var fecha = button.data('fecha');
                    var horaInicio = button.data('horainicio');
                    var horaFin = button.data('horafin');
                    var estado = button.data('estado');

                    var modal = $(this);
                    modal.find('#editId').val(id);
                    modal.find('#editFecha').val(fecha);
                    modal.find('#editHoraInicio').val(horaInicio);
                    modal.find('#editHoraFin').val(horaFin);
                    modal.find('#editEstado').val(estado);
                });

                // Manejar eliminación - pasar ID al modal
                $('#deleteReservaModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var id = button.data('id');

                    var modal = $(this);
                    modal.find('#deleteId').val(id);
                });

                // Validación básica de formulario
                $('#addReservaForm, #editReservaForm').submit(function (e) {
                    var horaInicio = $(this).find('[name="horaInicio"]').val();
                    var horaFin = $(this).find('[name="horaFin"]').val();

                    if (horaInicio >= horaFin) {
                        alert('La hora de fin debe ser posterior a la hora de inicio');
                        e.preventDefault();
                    }
                });
            });
        </script>
    </body>
</html>