/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.estado;
import persistencia.estadoJpaController;

/**
 *
 * @author david
 */
@WebServlet(name = "controladorEstado", urlPatterns = {"/controladorEstado"})
public class controladorEstado extends HttpServlet {
        protected estadoJpaController estadoJPAController = new estadoJpaController();

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
        processRequest(request, response);
    }

    public void registrarEstados() {
        try {
            estado EstadoPendiente = new estado();
            EstadoPendiente.setNombre("pendiente");

            estado EstadoConfirmada = new estado();
            EstadoConfirmada.setNombre("confirmada");

            estado EstadoActiva = new estado();
            EstadoActiva.setNombre("activa");

            estado EstadoCancelada = new estado();
            EstadoCancelada.setNombre("cancelada");

            estado EstadoTerminada = new estado();
            EstadoTerminada.setNombre("terminada");
            
            estadoJPAController.create(EstadoActiva);
            estadoJPAController.create(EstadoPendiente);
            estadoJPAController.create(EstadoConfirmada);
            estadoJPAController.create(EstadoTerminada);
           
        } catch (Exception sql) {
            System.out.println("error: " + sql);
        }
    }
    
    public List<estado> raerEstados(){
        estadoJpaController estadoJPA = new estadoJpaController();
        return estadoJPA.findestadoEntities();
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
