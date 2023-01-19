<%@page import="java.sql.DriverManager"%>
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
        <title>Question</title>
        <link rel="stylesheet" type="text/css" href="styles.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    </head>
    <body class="qa_page">
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
                  <a class="nav-link" href="./QuestionsServlet">Questions</a>
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
        <h1>Question</h1>
        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection connect, connect1;
                connect = DriverManager.getConnection("jdbc:derby://localhost:1527/forum-db", "forumUser", "123456");
                
                Statement state1, state2, state3;
                String str1, str2, str3, str4, id_question;
                int num, num1, num2;
                state1 = connect.createStatement();
                
                id_question = request.getParameter("id_question");
                
                String strQuery1 = "SELECT * FROM FORUMUSER.QUESTIONS WHERE Id = " + id_question;
                ResultSet result1 = state1.executeQuery(strQuery1);
                
                while (result1.next()) {
                    out.println("<div class=\"question_block\">");
                    out.println("<div class=\"question_content_block\">");
                    out.println("<p class=\"question_title\">"+result1.getString("QuestionTitle")+"</p>");
                    out.println("<p class=\"question_content\">"+result1.getString("QuestionContent")+"</p>");
                    out.println("</div>");
                    out.println("<p class=\"question_author_name\">"+result1.getString("FirstName")+" "+result1.getString("LastName")+"</p>");
                    out.println("<p class=\"question_date_add\">"+result1.getString("DateAdd")+"</p>");
                    out.println("</div>");
                }
            } catch (Exception e) {
                out.println("done exception" + e);
            }
        %>
        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection connect, connect1;
                connect = DriverManager.getConnection("jdbc:derby://localhost:1527/forum-db", "forumUser", "123456");
                
                Statement state1, state2, state3;
                String str1, str2, str3, str4, id_question;
                int num, num1, num2;
                state1 = connect.createStatement();
                
                id_question = request.getParameter("id_question");
                
                String strQuery1 = "SELECT * FROM FORUMUSER.ANSWERS WHERE Id_Question = " + id_question;
                ResultSet result1 = state1.executeQuery(strQuery1);
                
                while (result1.next()) {
                    out.println("<div class=\"answer_block\">");
                    out.println("<p class=\"answer_content\">"+result1.getString("AnswerContent")+"</p>");
                    out.println("<p class=\"answer_author_name\">"+result1.getString("FirstName")+" "+result1.getString("LastName")+"</p>");
                    out.println("<p class=\"answer_date_add\">"+result1.getString("DateAdd")+"</p>");
                    out.println("</div>");
                }
            } catch (Exception e) {
                out.println("done exception" + e);
            }
        %>
        <div class="row" id="answer_form">
                    <div class="col-lg-8 col-md-8">
                        <form name="form" method="POST" action="AddAnswerServlet">
                            <div class="form-group">
                                <label for="firstName">First name</label>
                                <input type="text" class="form-control" name="firstName" id="firstName">
                            </div>
                            <div class="form-group">
                                <label for="lastName">Last name</label>
                                <input type="text" class="form-control" name="lastName" id="lastName">
                            </div>
                            <div class="form-group">
                                <label for="answerContent">Answer</label>
                                <input type="text" class="form-control" name="answerContent" id="answerContent">
                            </div>
                            <%
                                try {
                                    String id_question;

                                    id_question = request.getParameter("id_question");

                                    out.println("<input type=\"hidden\" id=\"id_question\" name=\"id_question\" value=\""+id_question+" \">");
                                } catch (Exception e) {
                                    out.println("done exception" + e);
                                }
                            %>
                            <button type="submit" class="btn btn-primary">Submit</button>
                      </form>
                    </div>
                </div>
        </div>
    </body>
</html>
