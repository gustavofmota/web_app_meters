<%@ page import="application.Zone" %>
<%@ page import="java.util.List" %>
<%@ page import="application.ZoneManager" %>
<%@ page import="application.ConnectionDB" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: baseform
  Date: 5/6/22
  Time: 4:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ConnectionDB conn = (ConnectionDB) request.getSession().getAttribute("connection");
    Zone z = new Zone();
    boolean x = false;
    int zId = -1;

    if(request.getParameter("zId") != null){
        zId = Integer.parseInt(request.getParameter("zId"));
        z = ZoneManager.getZone(conn, zId);
        x = true;
    }

    String errorMsg = null;
    boolean verify = false;

    if (request.getMethod().equals("POST") && request.getParameter("op").equals("create")) {
        try {
            z = ZoneManager.addZone(request, conn);
            response.sendRedirect("index.jsp?hasError=" + (z != null));
        }catch (Exception e){
            verify = true;
            errorMsg = e.getMessage();
        }

    } else if (request.getMethod().equals("POST") && request.getParameter("op").equals("edit")) {

        try {
            z = ZoneManager.editZone(request, conn, zId);
            response.sendRedirect("index.jsp?hasError=" + (z != null));

        } catch (Exception e) {
            e.printStackTrace();
        }

    } else if (request.getMethod().equals("POST") && request.getParameter("op").equals("delete")) {
        try{
            z = ZoneManager.deleteZone(conn,zId);
            response.sendRedirect("index.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
        }
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

<header>
    <div class="left">
        <h1>Web App Zones & Meters</h1>
    </div>
    <div class="home centerHome btn hover">
        <a href="index.jsp">
            <p>Home</p>
        </a>
    </div>
    <div class="right">
        <h1>Beta Version</h1>
    </div>
</header>

<div class="spacer">

</div>

<div class="delDiv">
    <button class="button-4 delete" data-link="index.jsp?zId=<%=z.getId()%>">Eliminar</button>
</div>

<div>
    <%if (verify) {%>
    <p>Something went wrong: <%=errorMsg%>
    </p>
    <%}%>
</div>

<div class="formContainer">

    <form method="POST" autocomplete="off">
        <div class="fBody">
            <input type="hidden" <%if(x){%>value="edit"<%}else{%> value="create"<%}%> name="op">


            <input type="hidden" value="<%= zId %>" name="zId">

            <label for="codGeo">Código Geográfico: </label>
            <input type="text" id="codGeo" name="codGeo" <%if(x){%>value="<%=z.getCodGeo()%>"<%}%>>

            <label for="nomeZ">Nome da Zona: </label>
            <input type="text" id="nomeZ" name="nomeZ" <%if(x){%>value="<%=z.getNome()%>"<%}%>>

            <label for="totalCond">Tamanho Total das condutas: </label>
            <input type="text" id="totalCond" name="totalCond" <%if(x){%>value="<%=z.getTotalCond()%>"<%}%>>

            <label for="populacao">População: </label>
            <input type="text" id="populacao" name="populacao" <%if(x){%>value="<%=z.getPopulacao()%>"<%}%>>

        </div>

        <input class="button-4 meterBtn" type="submit" value="Adicionar">
    </form>


</div>

<footer>
    <h6>© Developed by Gustavo Mota 2022 ©</h6>
</footer>

<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
</body>
</html>
