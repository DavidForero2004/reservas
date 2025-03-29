/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.estado;
import modelo.reserva;
import modelo.usuario;
import persistencia.exceptions.NonexistentEntityException;
import persistencia.reservaJpaController;

/**
 *
 * @author david
 */
@WebServlet(name = "controladorReserva", urlPatterns = {"/controladorReserva"})
public class controladorReserva extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        switch (action) {
            case "create":
                String fechaStr = request.getParameter("fecha");

                SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd"); // adapta al formato que te envía el form
                Date fecha = null;

                try {
                    fecha = formato.parse(fechaStr);
                } catch (ParseException e) {
                    System.out.println(e);
                }

                String HoraInicio = request.getParameter("horaInicio");
                String HoraFin = request.getParameter("horaFin");
                int id_usuario = Integer.parseInt(request.getParameter("id"));
                int id_estado = 1;

                boolean isCorrect = crearReserva(fecha, HoraInicio, HoraFin, id_usuario, id_estado);
                if (isCorrect) {
                    response.sendRedirect("Dashboard.jsp");
                }
                break;
            case "delete":
                int id = Integer.parseInt(request.getParameter("id"));
                System.out.println("id" + id);
                reservaJpaController reservaJPA = new reservaJpaController();
                 {
                    try {
                        reservaJPA.destroy(id);
                        response.sendRedirect("Dashboard.jsp");
                    } catch (NonexistentEntityException ex) {
                        Logger.getLogger(controladorReserva.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                break;

            default:
                throw new AssertionError();
        }

    }

    protected boolean crearReserva(Date fecha, String HoraInicio, String HoraFin, Integer id_usuario, Integer id_estado) {

        try {
            usuario Usuario = new usuario();
            Usuario.setId(id_usuario);

            estado Estado = new estado();
            Estado.setId(id_estado);

            reserva res = new reserva();
            res.setFecha(fecha);
            res.setHoraInicio(HoraInicio);
            res.setHoraFin(HoraFin);
            res.setUsuario(Usuario);
            res.setEstado(Estado);

            reservaJpaController reservaJPA = new reservaJpaController();

            reservaJPA.create(res);
            return true;

        } catch (Exception ex) {
            System.out.println(ex);
            return false;
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
