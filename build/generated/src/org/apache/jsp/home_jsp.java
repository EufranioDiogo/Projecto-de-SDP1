package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import ;

public final class home_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

 
    String DB_URI = "jdbc:postgresql://localhost:5432/ucandb_aux";
    String USER_NAME = "postgres";
    String USER_PASSWORD = "postgres";
    Connection connection = null;


public void startupConfig() throws SQLException {
    String query = "TRUNCATE TABLE portifolio;";
    PreparedStatement statement = connection.prepareStatement(query);

    setupPortfolio();
}

public void setupPortfolio() {
    
}

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');

    try {
        Class.forName("org.postgresql.Driver");

        connection = DriverManager.getConnection(DB_URI, USER_NAME, USER_PASSWORD);

        if (connection != null) {
            startupConfig();
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/error_page");
            dispatcher.forward(request, response);
        }
    } catch(Exception e) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/error_page");
        dispatcher.forward(request, response);
    }

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Tela de Apresentação</title>\n");
      out.write("        <style>\n");
      out.write("            * {\n");
      out.write("                margin: 0;\n");
      out.write("                padding: 0;\n");
      out.write("            }\n");
      out.write("            \n");
      out.write("            .main-container {\n");
      out.write("                width: 100%;\n");
      out.write("                height: 100vh;\n");
      out.write("                display: flex;\n");
      out.write("                justify-content: center;\n");
      out.write("                align-items: center;\n");
      out.write("                font-family: Arial, Helvetica, sans-serif;\n");
      out.write("            }\n");
      out.write("            \n");
      out.write("            .div-content-box {\n");
      out.write("                width: 50%;\n");
      out.write("                height: 60%;\n");
      out.write("                border-radius: 1rem;\n");
      out.write("                position: relative;\n");
      out.write("            }\n");
      out.write("            .u-heading-1 {\n");
      out.write("                margin-bottom: 1.5rem;\n");
      out.write("            }\n");
      out.write("            .u-heading-2 {\n");
      out.write("                margin: 1rem 0;\n");
      out.write("            }\n");
      out.write("            .u-text {\n");
      out.write("                line-height: 1.5;\n");
      out.write("                margin: 1rem 0;\n");
      out.write("            }\n");
      out.write("            \n");
      out.write("            .other-info-list {\n");
      out.write("                list-style-position: inside;\n");
      out.write("            }\n");
      out.write("            .other-info-item {\n");
      out.write("                margin: 0.25rem 0;\n");
      out.write("            }\n");
      out.write("            .bottom-control {\n");
      out.write("                margin-top: 2rem;\n");
      out.write("                width: 100%;\n");
      out.write("            }\n");
      out.write("            .accept-and-continue-link {\n");
      out.write("                padding: 1rem;\n");
      out.write("                border-radius: 0.5rem;\n");
      out.write("                background-color: #fca383;\n");
      out.write("                color: white;\n");
      out.write("                font-weight: bold;\n");
      out.write("                text-decoration: none;\n");
      out.write("                transition: 0.5s;\n");
      out.write("            }\n");
      out.write("            .accept-and-continue-link:hover {\n");
      out.write("                background-color: #ff7f50;\n");
      out.write("            }\n");
      out.write("            \n");
      out.write("        </style>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div class=\"main-container\">\n");
      out.write("            <div class=\"div-content-box\">\n");
      out.write("                <h1 class=\"u-heading-1\">Projecto de SDP1</h1>\n");
      out.write("                <p class=\"u-text\">O seguinte projecto serve como critério de avaliação para o exame da cadeira de Sistemas Distribuidos e Paralelos 1, \n");
      out.write("                    tendo como orientador o <b>Professor Doutor Aires Veloso</b>.</p>\n");
      out.write("                <p class=\"u-text\">O projecto tem como objectivo a criação de uma loja virtual de materias de construção, onde teremos a \n");
      out.write("                    aplicação das várias regras de negócios pedidas pelo cliente.</p>\n");
      out.write("                \n");
      out.write("                <h2 class=\"u-heading-2\">Outros dados Adjacentes:</h2>\n");
      out.write("                <ul class=\"other-info-list\">\n");
      out.write("                    <li class=\"other-info-item\">ID: 21099</li>\n");
      out.write("                    <li class=\"other-info-item\">Nome: Eufránio Diogo</li>\n");
      out.write("                    <li class=\"other-info-item\">Número do Projecto: 3</li>\n");
      out.write("                </ul>\n");
      out.write("                \n");
      out.write("                <div class=\"bottom-control\">\n");
      out.write("                    <a href=\"login.jsp\" class=\"accept-and-continue-link\">Aceitar e continuar</a>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
