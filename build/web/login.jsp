<%-- 
    Document   : login
    Created on : May 20, 2021, 10:48:12 PM
    Author     : ed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%! 
    String DB_URI = "jdbc:postgresql://localhost:5432/ucandb_aux";
    String USER_NAME = "postgres";
    String USER_PASSWORD = "postgres";
    Connection connection = null;
%>

<%!

%>

<%
    try {
        Class.forName("org.postgresql.Driver");

        connection = DriverManager.getConnection(DB_URI, USER_NAME, USER_PASSWORD);

        if (connection != null) {
            
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/error_page");
            dispatcher.forward(request, response);
        }
    } catch(Exception e) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/error_page");
        dispatcher.forward(request, response);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Screen</title>
    </head>
    <body>
        
    </body>
</html>
