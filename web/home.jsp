<%-- 
    Document   : home
    Created on : May 21, 2021, 9:37:18 AM
    Author     : ed
--%>

<%@page import="org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator"%>
<%@page import="org.apache.poi.ss.usermodel.FormulaEvaluator"%>
<%@page import="org.apache.poi.ss.usermodel.DataFormatter"%>
<%@page import="java.io.FileNotFoundException"%>
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
    DataFormatter objDefaultFormat;
    FormulaEvaluator objFormulaEvaluator;

%>

<%!    public void startupConfig() throws SQLException, ServletException, IOException
    {
        String query = "TRUNCATE TABLE portifolio;";
        PreparedStatement statement = connection.prepareStatement(query);

        statement.executeUpdate();

        try
        {
            setupPortfolio();
        } catch (Exception e)
        {

        }

    }

    public void setupPortfolio()
    {
        File file = new File(PORTFOLIO_NAME);

        try
        {
            if (file.createNewFile())
            {
                System.out.println("File Created");
            } else
            {
                System.out.println("File Exists");
            }
        } catch (IOException e)
        {
            System.out.println("IO Exception creating the file");
        }

        FileInputStream fileInputStream = null;

        try
        {
            fileInputStream = new FileInputStream(file);
        } catch (FileNotFoundException e)
        {
            System.out.println("File not founde");
        }

        HSSFWorkbook workbook = null;

        try
        {
            workbook = new HSSFWorkbook(fileInputStream);
        } catch (IOException e)
        {
            System.out.println("IO EXCEPTION");
        }

        objDefaultFormat = new DataFormatter();
        objFormulaEvaluator = new HSSFFormulaEvaluator((HSSFWorkbook) workbook);

        HSSFSheet workSheet = workbook.getSheetAt(0);
        HSSFRow row;
        Iterator< Row> rowIterator = workSheet.iterator();
        String previousItem = "";
        String actualItem = "";
        String designation = "";
        String splitCharacter = "\\.";
        String[] fatherList = new String[20];
        int actualFatherIndex = -1;
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
                objFormulaEvaluator.evaluate(cell); // This will evaluate the cell, And any type of cell will return string val-ue
                String cellValueStr = objDefaultFormat.formatCellValue(cell, objFormulaEvaluator);

                System.err.println("0 Home setupPortifolio{}\tcellValueStr: " + cellValueStr);

                if (flag == false)
                {
                    actualItem = cellValueStr;
                } else
                {
                    designation = cellValueStr;
                }

                flag = !flag;
                i++;
            }

            System.out.println(actualItem + " - " + designation);

            boolean result = actualItem.length() == 1 ? true : false;

            if (result)
            {
                actualFatherIndex = -1;
                previousItem = actualItem;
                System.out.println(previousItem);

                String query = "INSERT INTO portifolio(pk_producto, designacao) VALUES(?, ?);";

                try
                {
                    PreparedStatement statement = connection.prepareStatement(query);

                    statement.setString(1, actualItem);
                    statement.setString(2, designation);

                    statement.executeUpdate();
                } catch (SQLException e)
                {
                    System.out.println("SQL EXCEPTION: " + e.toString());
                    System.out.println(e.getStackTrace());
                }
            } else
            {
                int actualSize = actualItem.split(splitCharacter).length;
                int previousSize = previousItem.split(splitCharacter).length;

                if (actualSize > previousSize)
                {
                    actualFatherIndex++;
                    fatherList[actualFatherIndex] = previousItem;
                } else if (actualSize < previousSize)
                {
                    int quantStepsBack = previousSize - actualSize;

                    actualFatherIndex -= quantStepsBack;
                }

                String query = "INSERT INTO portifolio(pk_producto, designacao, fk_producto) VALUES(?, ?, ?);";

                System.out.println("\nChegou");
                try
                {
                    PreparedStatement statement = connection.prepareStatement(query);

                    statement.setString(1, actualItem);
                    statement.setString(2, designation);
                    statement.setString(3, fatherList[actualFatherIndex]);
                    statement.executeUpdate();
                    System.out.println("NJNJDSNDJ");
                } catch (SQLException e)
                {
                    System.out.println("SQL EXCEPTION: " + e.toString());
                    System.out.println(e.getMessage());
                }
                previousItem = actualItem;
            }

            System.out.println();
        }
        System.out.println("Saiu");
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

    public int getQuantChar(String string, String character)
    {
        int i = 0;
        int quant = 0;

        for (; i < string.length(); i++)
        {
            if (string.charAt(i) + "" == character)
            {
                quant += 1;
            }
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
        <title>Tela de Apresenta????o</title>
        <style>
            <%@include file="WEB-INF/CSS/universal.css"%>
            <%@include file="WEB-INF/CSS/home.css"%>
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="div-content-box">
                <h1 class="u-heading-1">Projecto de SDP1</h1>
                <p class="u-text">O seguinte projecto serve como crit??rio de avalia????o para o exame da cadeira de Sistemas Distribuidos e Paralelos 1, 
                    tendo como orientador o <b>Professor Doutor Aires Veloso</b>.</p>
                <p class="u-text">O projecto tem como objectivo a cria????o de uma loja virtual de materias de constru????o, onde teremos a 
                    aplica????o das v??rias regras de neg??cios pedidas pelo cliente.</p>

                <h2 class="u-heading-2">Outros dados Adjacentes:</h2>
                <ul class="other-info-list">
                    <li class="other-info-item">ID: 21099</li>
                    <li class="other-info-item">Nome: Eufr??nio Diogo</li>
                    <li class="other-info-item">N??mero do Projecto: 3</li>
                </ul>

                <div class="bottom-control">
                    <a href="login.jsp" class="accept-and-continue-link">Aceitar e continuar</a>
                </div>
            </div>
        </div>
    </body>
</html>
