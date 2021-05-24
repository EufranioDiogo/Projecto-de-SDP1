<%-- 
    Document   : home
    Created on : May 21, 2021, 9:37:18 AM
    Author     : ed
--%>

<%@page import="org.apache.poi.ss.usermodel.CellType"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.ss.util.NumberToTextConverter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%!
    String DB_URI = "jdbc:postgresql://localhost:5432/ucandb_aux";
    String USER_NAME = "postgres";
    String USER_PASSWORD = "postgres";
    String webRootPath;
    String PORTFOLIO_NAME = "/home/ed/Documents/Portfolio_EufranioDiogo_SDP1.xls";
    Connection connection = null;
    HttpServletRequest req = null;
    HttpServletResponse res = null;
%>

<%!
    public void startupConfig() throws SQLException, ServletException, IOException
    {
        String query = "TRUNCATE TABLE portifolio;";
        PreparedStatement statement = connection.prepareStatement(query);

        statement.executeUpdate();

        try
        {
            setupPortfolio();
        } catch (Exception e)
        {
            goToErroPage();
        }

    }

    public void setupPortfolio() throws ServletException
    {

        try
        {
            File file = new File(PORTFOLIO_NAME);

            if (file.createNewFile())
            {
                System.out.println("File Created");
            } else
            {
                System.out.println("File Exists");
            }


            FileInputStream fileInputStream = new FileInputStream(file);
            HSSFWorkbook workbook = new HSSFWorkbook(fileInputStream);
            HSSFSheet workSheet = workbook.getSheetAt(0);
            HSSFRow row;
            Iterator< Row> rowIterator = workSheet.iterator();
            String previousItem = "";
            String actualItem = "";
            String designation = "";
            String splitCharacter = ":";
            String[] itemLevel = new String[20];
            int previousLevel = -1;
            int actualLevel = -1;
            Cell cell;

            while (rowIterator.hasNext())
            {
                row = (HSSFRow) rowIterator.next();
                Iterator< Cell> cellIterator = row.cellIterator();
                boolean flag = false;
                int i = 0;

                while (i < 2 && cellIterator.hasNext())
                {
                    cell = cellIterator.next();

                    if (flag == false) {
                        actualItem = cell.getStringCellValue();
                    } else {
                        designation = cell.getStringCellValue();
                    }

                    flag = !flag;
                    i++;
                }

                System.out.println(actualItem + " - " + designation);

                String[] vector = actualItem.split(splitCharacter);

                boolean result = vector.length == 2 && vector[1].equalsIgnoreCase("0") ? true : false;

                if (result) {
                    previousLevel = -1;
                    actualLevel = 0;
                    itemLevel[actualLevel] = vector[0];
                    previousItem = vector[0];

                    System.out.println("Previous: " + previousItem + ", Item: " + itemLevel[actualLevel]);

                    String query = "INSERT INTO portifolio(pk_producto, designacao) VALUES(?, ?);";
                    PreparedStatement statement = connection.prepareStatement(query);

                    statement.setString(1, itemLevel[actualLevel]);
                    statement.setString(2, designation);

                    try
                    {
                        statement.executeUpdate();
                    } catch (SQLException e)
                    {
                        System.out.println(e.getStackTrace());
                    }
                } else {
                    int actualSize = actualItem.split(splitCharacter).length;
                    int previousSize = previousItem.split(splitCharacter).length;

                    if (actualSize > previousSize) {
                        actualLevel++;
                        previousLevel++;
                        itemLevel[actualLevel] = actualItem;
                    } else if (actualSize == previousSize) {
                        actualLevel++;
                        itemLevel[actualLevel] = actualItem;
                        itemLevel[previousLevel] = actualItem;
                    } else if (actualSize < previousSize) {
                        previousLevel--;
                    }

                    previousItem = actualItem;
                    
                    String query = "INSERT INTO portifolio(pk_producto, designacao, fk_producto) VALUES(?, ?, ?);";
                    PreparedStatement statement = connection.prepareStatement(query);

                    statement.setString(1, actualItem);
                    statement.setString(2, designation);
                    statement.setString(3, itemLevel[previousLevel]);
                    try
                    {
                        statement.executeUpdate();
                    } catch (SQLException e)
                    {
                        System.out.println(e.getMessage());
                    }
                }
                
                System.out.println();
            }
        } catch (Exception e)
        {
            System.out.println("hbhb");
            System.out.println(e.getMessage());
            goToErroPage();
        }
    }

    public void goToErroPage()
    {
        try
        {
            res.sendRedirect("error_page.jsp");
        } catch (Exception e)
        {
            System.out.println(e.getStackTrace());
        }
        
    }

    public int getQuantChar(String string, String character) {
        int i = 0;
        int quant = 0;

        for (; i < string.length(); i++) {
            if (string.charAt(i) + "" == character) 
                quant += 1;
            }
        return quant;
    }
%>

<%
    req = request;
    res = response;
    webRootPath = getServletContext().getRealPath("/");

    System.out.println(webRootPath);
    try
    {
        Class.forName("org.postgresql.Driver");

        connection = DriverManager.getConnection(DB_URI, USER_NAME, USER_PASSWORD);

        if (connection != null)
        {
            startupConfig();
        } else
        {
            goToErroPage();
        }
    } catch (Exception e)
    {
        goToErroPage();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tela de Apresentação</title>
        <style>
            <%@include file="WEB-INF/CSS/universal.css"%>
            <%@include file="WEB-INF/CSS/home.css"%>
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="div-content-box">
                <h1 class="u-heading-1">Projecto de SDP1</h1>
                <p class="u-text">O seguinte projecto serve como critério de avaliação para o exame da cadeira de Sistemas Distribuidos e Paralelos 1, 
                    tendo como orientador o <b>Professor Doutor Aires Veloso</b>.</p>
                <p class="u-text">O projecto tem como objectivo a criação de uma loja virtual de materias de construção, onde teremos a 
                    aplicação das várias regras de negócios pedidas pelo cliente.</p>

                <h2 class="u-heading-2">Outros dados Adjacentes:</h2>
                <ul class="other-info-list">
                    <li class="other-info-item">ID: 21099</li>
                    <li class="other-info-item">Nome: Eufránio Diogo</li>
                    <li class="other-info-item">Número do Projecto: 3</li>
                </ul>

                <div class="bottom-control">
                    <a href="login.jsp" class="accept-and-continue-link">Aceitar e continuar</a>
                </div>
            </div>
        </div>
    </body>
</html>
