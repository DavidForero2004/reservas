/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.estado;

/**
 *
 * @author david
 */
@WebServlet(name = "controladorEstado", urlPatterns = {"/controladorEstado"})
public class controladorEstado extends HttpServlet {

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
        } catch (Exception sql) {
            System.out.println("error: " + sql);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
