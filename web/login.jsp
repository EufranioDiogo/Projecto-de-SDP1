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
    String userName = null;
    String password = null;
    int userLevel = 0;
%>

<%!
    public boolean checkIfUserExists(String userName, String password) {
        try
        {
            String query = "SELECT nome_usuario FROM users WHERE nome_usuario = ?, password = ?;";
            PreparedStatement statement = connection.prepareStatement(query);

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                return true;
            }
        } catch (SQLException e)
        {
            System.out.println(e.getMessage());
        }
        return false;
    }
%>

<%
    
    userName = request.getParameter("userName");
    password = request.getParameter("password");
    
    if (userName != null && password != null) {
        try {
            Class.forName("org.postgresql.Driver");

            connection = DriverManager.getConnection(DB_URI, USER_NAME, USER_PASSWORD);

            if (connection != null) {
                boolean userExists = checkIfUserExists(userName, password);
                
                if (userExists) {
                    response.sendRedirect("/startPage.jsp");
                }
            } else {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/error_page");
                dispatcher.forward(request, response);
            }
        } catch(Exception e) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/error_page");
            dispatcher.forward(request, response);
    }
    }
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Screen</title>
    </head>
    <body>
        <form action="/login.jsp" method="POST">
            UserName: <input type="text" name="userName" placeholder="UserName"><br>
            Password: <input type="password" name="password">
            <input type="submit" value="Logar">
        </form>
    </body>
</html>
