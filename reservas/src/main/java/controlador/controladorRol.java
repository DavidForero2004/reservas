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
import modelo.rol;
import persistencia.rolJpaController;

/**
 *
 * @author david
 */
@WebServlet(name = "controladorRol", urlPatterns = {"/controladorRol"})
public class controladorRol extends HttpServlet {

    protected rolJpaController rolJPAController = new rolJpaController();

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

    public void registroRoles() {
        try {
            rol Rol = new rol();
            Rol.setNombre("Administrador");
            rolJPAController.create(Rol);

            Rol.setNombre("Cliente");
            rolJPAController.create(Rol);
        } catch (Exception ex) {
            System.out.println("error: " + ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
