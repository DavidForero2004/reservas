/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.reserva;
import modelo.rol;
import modelo.usuario;
import persistencia.reservaJpaController;
import persistencia.usuarioJpaController;

/**
 *
 * @author david
 */
@WebServlet(name = "controladorUsuario", urlPatterns = {"/controladorUsuario"})
public class controladorUsuario extends HttpServlet {

    protected usuarioJpaController usuJPAController = new usuarioJpaController();
    String mensaje = "none";

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
        String action = request.getParameter("action");

        controladorRol Rol = new controladorRol();
        Rol.registroRoles();

        controladorEstado Estado = new controladorEstado();
        Estado.registrarEstados();
        switch (action) {
            case "1":
                //Logica del login
                String correoLogin = request.getParameter("correo");
                boolean IsLogin = comprobarAcceso(correoLogin, request);
                if (IsLogin) {
                    response.sendRedirect("Dashboard.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                    mensaje = "Usuario invalido";
                }
                break;
            case "2":

                //Logica del registro
                String nombre = request.getParameter("nombre");
                String correo = request.getParameter("correo");
                String telefono = request.getParameter("telefono");

                boolean isTrue = registroUsuario(nombre, correo, telefono);

                if (isTrue) {
                    mensaje = "Registro completado con exito";
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("registroGym.jsp");
                    mensaje = "Ha ocurrido un error con el registro";
                }
                break;
            default:
                throw new AssertionError();
        }
    }

    protected boolean registroUsuario(String nombre, String correo, String telefono) {

        try {
            rol ROL = new rol();
            ROL.setId(2);
            usuario usu = new usuario();
            usu.setNombre(nombre);
            usu.setCorreo(correo);
            usu.setTelefono(telefono);
            usu.setRol(ROL);

            usuJPAController.create(usu);

            return true;

        } catch (Exception SQLex) {

            System.out.println(SQLex);
            return false;
        }
    }
    

    public boolean comprobarAcceso(String email, HttpServletRequest request) {
        List<usuario> listUser = usuJPAController.findusuariosByEmail(email);

            if (listUser != null) {
                HttpSession misession = request.getSession(true);
                misession.setAttribute("userSession", listUser);
                return true;  
            }
        

        System.out.println("Ningún correo coincidió");
        return false;  // Retorna false solo después de revisar todos
    }

    public List<reserva> ConsultarReservasUser(int id) {
        reservaJpaController reservaJPA = new reservaJpaController();
        return reservaJPA.findReservasByUser(id);
    }

     public List<reserva> ConsultarReservas() {
        reservaJpaController reservaJPA = new reservaJpaController();
        return reservaJPA.findreservaEntities();
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
