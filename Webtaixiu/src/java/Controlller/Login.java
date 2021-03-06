/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlller;

import DAO.DAOUser;
import DTO.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String User = request.getParameter("username");
        String Pass = request.getParameter("password");
        DAOUser dao = new DAOUser();
        int Check = dao.login(User, Pass);
        if (Check == 1) {
            out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
            out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
            out.println("<script>");
            out.println("$(document).ready(function(){");
            out.println("swal('Login Success!','successfull', 'success');");
            out.println("});");
            out.println("</script>");
            HttpSession session = request.getSession();
            session.setAttribute("Check", "login");
            session.setAttribute("Name", User);
            session.setAttribute("role", Check);
            RequestDispatcher rd = request.getRequestDispatcher("./homepage.jsp");
            rd.include(request, response);
        } else if (Check == 2) {
            out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
            out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
            out.println("<script>");
            out.println("$(document).ready(function(){");
            out.println("swal('Login Success!','successfull', 'success');");
            out.println("});");
            out.println("</script>");
            HttpSession session = request.getSession();
            session.setAttribute("Check", "login");
            session.setAttribute("Name", User);
            session.setAttribute("role", Check);
            User user = dao.getUserbyUsername(session.getAttribute("Name").toString());
            session.setAttribute("point", user.getPoint());
            RequestDispatcher rd = request.getRequestDispatcher("./homepage.jsp");
            rd.include(request, response);
        } else {
            out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
            out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
            out.println("<script>");
            out.println("$(document).ready(function(){");
            out.println("swal('Login Fail!','Your Username or Password is incorrect', 'error');");
            out.println("});");
            out.println("</script>");
            RequestDispatcher rd = request.getRequestDispatcher("./index.jsp");
            rd.include(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
