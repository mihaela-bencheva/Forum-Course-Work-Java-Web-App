<%@page import = "java.text.*" %>
<%@page import = "java.sql.Date" %>
<%@page import = "java.io.*,java.util.*,java.sql.*"%>
<%@page import = "javax.servlet.http.*,javax.servlet.*" %>

<%@page language = "java" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User</title>
        <link rel="stylesheet" type="text/css" href="styles.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    </head>
    <body>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="/ForumCourse">All In One Forum</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                  <a class="nav-link" href="./Questions.jsp">Questions</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="./questionForm.html">Ask a question</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="./login.html">Login</a>
                </li>
              </ul>
            </div>
        </nav>
        <div class="container">
            <div class="users_questions_btn">
        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection connect, connect1;
                connect = DriverManager.getConnection("jdbc:derby://localhost:1527/forum-db", "forumUser", "123456");
                
                Statement state1, state2, state3;
                String str1, str2, str3, str4, customer_email, password;
                int num, num1, num2;
                state1 = connect.createStatement();
                
                customer_email = request.getParameter("email");
                password = request.getParameter("pwd");
                String strQuery1 = "SELECT ID, PASSWORD FROM FORUMUSER.USERS WHERE EMAIL LIKE '"+ customer_email +"'";
                ResultSet result1 = state1.executeQuery(strQuery1);
                
                boolean isUserLoginDataCorrect = false;
                int userId = 0;

                while (result1.next()) {
                    userId = result1.getInt("Id");
                    
                    if (password.equals(result1.getString("Password"))) {
                        isUserLoginDataCorrect = true;
                        break;
                    }
                }

               if (isUserLoginDataCorrect == true)  {
                    Cookie userEmail = new Cookie("userEmail", customer_email);

                    // Set expiry date after 24 Hrs for both the cookies.
                    userEmail.setMaxAge(60*60*24);

                    // Add both the cookies in the response header.
                    response.addCookie( userEmail );
                    
                    out.println("<form name=\"form\" method=\"POST\" action=\"UserQuestions.jsp\">");
                    out.println("<button type=\"submit\" id=\"user_questions\" class=\"btn btn-primary\">See your questions</button>");
                    out.println("<input type=\"hidden\" id=\"id_user\" name=\"id_user\" value=\""+userId+ " \">");
                    out.println("</form>");
               }
            } catch (Exception e) {
                out.println("done exception" + e);
            }
        %>
        </div>
        </div>
    </body>
</html>
