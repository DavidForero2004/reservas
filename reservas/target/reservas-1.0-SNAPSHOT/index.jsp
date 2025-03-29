<%-- 
    Document   : index
    Created on : 28/03/2025, 3:43:27 p. m.
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LoginGymGold</title>
        <link rel="stylesheet" href="index.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"/>
    </head>
    <body>
        <div class="wrapper">
            <div class="logo">
                <img src="https://www.onlinelogomaker.com/blog/wp-content/uploads/2017/11/gym-logo.jpg" alt="">
            </div>
            <div class="text-center mt-4 name">
                logIn
            </div>
            <form class="p-3 mt-3" action="controladorUsuario" method="POST">
                <input type="hidden" name="action" value="1">

                <div class="form-field d-flex align-items-center">
                    <span class="fa-solid fa-envelope"></span>
                    <input type="text" name="correo" id="correo" placeholder="Correo">
                </div>
                <button type="submit" class="btn mt-3">Ingresar</button>
            </form>
            <div class="text-center fs-6">
                <a href="registroGym.jsp">Sign up</a>
            </div>
        </div>  
    </body>
</html>
