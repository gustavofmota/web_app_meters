<%--
  Created by IntelliJ IDEA.
  User: baseform
  Date: 4/26/22
  Time: 2:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="application.ConnectionDB" %>
<%@ page language="java" import="application.Zone" %>
<%@ page import="application.ZoneManager" %>
<%@ page import="" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>


<%
    // out JspWriter
    request.getParameter("id"); // HttpServletRequest
    //response; // HttpServletResponse
    Class<?> aClass = Class.forName("org.postgresql.Driver");

    ConnectionDB connection = (ConnectionDB) request.getSession().getAttribute("connection");
if(connection == null){
    connection =  new ConnectionDB();
    request.getSession().setAttribute("connection",connection);
}


    ConnectionDB conn = connection;

    List<Zone> zones = ZoneManager.getZones(conn);
%>
<html>

<head>

    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/myStyle.css">

    <title>Web App Zones & Meters - Zones</title>
</head>
<body>

<header>
    <h1>Web App Zones & Meters</h1>
    <div class="right">
        <h1>Beta Version</h1>
    </div>
</header>

<div class="zonesHeader">
    <h2>Zones</h2>
</div>

<div class="main">
    <a href="#">
        <div class="mybox click ">
            <p class="light">+</p>
        </div>
    </a>

    <% for (Zone z : zones) {%>
    <div class="myBox">
        <a href="meters.jsp?id=<%=z.getId()%>">
        <div class="boxHeader">
            <p><%=StringEscapeUtils.escapeHtml4(z.getNome())%>
            </p>
            <div class="leftBtn">
                <button class="button-4" role="button">Editar</button>
                <button class="button-4" role="button" value="">Eliminar</button>
            </div>
        </div>

        <div class="boxBody">

            <table>
                <tr>
                    <td>Código Geográfico: <a class="light"><%=StringEscapeUtils.escapeHtml4(z.getCodGeo())%>
                    </a></td>
                </tr>

                <tr>
                    <td>Comprimento das Condutas: <a class="light"><%=(z.getTotalCond())%>
                    </a></td>
                </tr>

                <tr>
                    <td>População: <a class="light"><%=z.getPopulacao()%>
                    </a></td>
                </tr>
            </table>

        </div>
        </a>
    </div>
    <%}%>
</div>

<footer>
    <h6>© Developed by Gustavo Mota 2022 ©</h6>
</footer>
</body>
</html>
