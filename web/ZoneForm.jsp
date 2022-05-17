<%@ page import="application.Zone" %>
<%@ page import="java.util.List" %>
<%@ page import="application.ZoneManager" %>
<%@ page import="application.ConnectionDB" %><%--
  Created by IntelliJ IDEA.
  User: baseform
  Date: 5/6/22
  Time: 4:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ConnectionDB conn = (ConnectionDB) request.getSession().getAttribute("connection");
    int zId = Integer.parseInt(request.getParameter("zId"));

    if(request.getMethod().equals("POST") && request.getParameter("op").equals("create")) {

        Zone zone = ZoneManager.addZone(request, conn);
        response.sendRedirect("index.jsp?hasError=" + (zone!=null));
    }


%>


<html>
<head>

    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/myStyle_meters.css">
    <link rel="stylesheet" href="css/Form.css">


    <title>Web App Zones & Meters - Zones</title>
</head>
<body>

<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>

<header>
    <h1>Web App Zones & Meters</h1>
    <div class="right">
        <h1>Beta Version</h1>
    </div>
</header>

<div class="spacer">

</div>

<div class="formContainer">

    <form method="POST" autocomplete="off">
        <div class="fBody">
            <input type="hidden" value="create" name="op">


            <input type="hidden" value="<%= zId %>" name="zId">

            <label for="codGeo">Código Geográfico: </label>
            <input type="text" id="codGeo" name="codGeo">

            <label for="nomeZ">Nome da Zona: </label>
            <input type="text" id="nomeZ" name="nomeZ">

            <label for="totalCond">Tamanho Total das condutas: </label>
            <input type="text" id="totalCond" name="totalCond">

            <label for="populacao">População: </label>
            <input type="text" id="populacao" name="populacao">

        </div>

        <input class="button-4 meterBtn" type="submit" value="Adicionar">
    </form>


</div>

<footer>
    <h6>© Developed by Gustavo Mota 2022 ©</h6>
</footer>

</body>
</html>
