/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.forumcourse;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Integer.parseInt;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static jdk.nashorn.internal.objects.NativeString.trim;

/**
 *
 * @author VikS
 */
@WebServlet(name = "AddAnswerServlet", urlPatterns = {"/AddAnswerServlet"})
public class AddAnswerServlet extends HttpServlet {

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
        PrintWriter out1 = response.getWriter();
                
        String htmlResponse;
        htmlResponse = "";
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection connect, connect1;
            connect = DriverManager.getConnection("jdbc:derby://localhost:1527/forum-db", "forumUser", "123456");
            Statement state1, state2, state3;
            state1 = connect.createStatement();
            
            String answerContent = request.getParameter("answerContent");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            int id_question = Integer.parseInt(trim(request.getParameter("id_question")));
            
            PreparedStatement stat4 = connect.prepareStatement("insert into Answers(AnswerContent, Id_Question, FirstName, LastName, DateAdd) values(?,?,?,?,?)");
                stat4.setString(1, answerContent);
                stat4.setInt(2, id_question);
                stat4.setString(3, firstName);
                stat4.setString(4, lastName);
                stat4.setTimestamp(5, java.sql.Timestamp.valueOf(java.time.LocalDateTime.now()));
                stat4.executeUpdate();
                
                htmlResponse = "<p class=\"response\">Congratulations! Your answer has been added successfully!</p>"; 
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddQuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AddQuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        }          
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Answer</title>");   
            out.println("<meta charset=\"UTF-8\">\n" +
                             "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\" />");   
            out.println("<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css\" integrity=\"sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm\" crossorigin=\"anonymous\">");
            out.println("</head>");
            out.println("<body>");
            out.println("<script src=\"https://code.jquery.com/jquery-3.2.1.slim.min.js\" integrity=\"sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN\" crossorigin=\"anonymous\"></script>\n" +
                            "<script src=\"https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js\" integrity=\"sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q\" crossorigin=\"anonymous\"></script>\n" +
                            "<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js\" integrity=\"sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl\" crossorigin=\"anonymous\"></script>");
            out.println("<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark\">\n" +
"            <a class=\"navbar-brand\" href=\"/ForumCourse\">All In One Forum</a>\n" +
"            <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarSupportedContent\" aria-controls=\"navbarSupportedContent\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\n" +
"              <span class=\"navbar-toggler-icon\"></span>\n" +
"            </button>\n" +
"\n" +
"            <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\n" +
"              <ul class=\"navbar-nav mr-auto\">\n" +
"                <li class=\"nav-item\">\n" +
"                  <a class=\"nav-link\" href=\"./Questions.jsp\">Questions</a>\n" +
"                </li>\n" +
"                <li class=\"nav-item\">\n" +
"                  <a class=\"nav-link\" href=\"./login.html\">Login</a>\n" +
"                </li>\n" +
"              </ul>\n" +
"            </div>\n" +
"        </nav>");
            out.println("<h1>Answer</h1>");
            out.println(htmlResponse);
            out.println("</body>");
            out.println("</html>");
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
