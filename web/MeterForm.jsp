<%@ page import="application.Meter" %>
<%@ page import="java.util.List" %>
<%@ page import="application.MeterManager" %>
<%@ page import="application.ConnectionDB" %>
<%@ page import="application.*" %><%--
  Created by IntelliJ IDEA.
  User: baseform
  Date: 5/6/22
  Time: 4:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ConnectionDB conn = (ConnectionDB) request.getSession().getAttribute("connection");
    int zId=-1;
    int mId=-1;
    zId = Integer.parseInt(request.getParameter("zId"));
    if(request.getParameter("mId") != null){
        mId = Integer.parseInt(request.getParameter("mId"));
        Meter m = MeterManager.getMeter(conn, zId,mId);
    }
    String errorMsg = null;
    Meter meter = new Meter();
    boolean verify = false;
    boolean idVer = false;



    if(request.getMethod().equals("POST") && request.getParameter("op").equals("create")) {
         try{

             meter = MeterManager.addMeter(request, conn, zId);
             idVer = true;
         }
         catch (Exception e){
             verify = true;
             errorMsg = e.getMessage();
         }

         /*if(meter==null)
         response.sendRedirect("meters.jsp?zId="+zId+"&hasError=" + (meter==null));*/
    }

        /*;*/

%>


<html>
<head>

    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/myStyle_meters.css">
    <link rel="stylesheet" href="css/Form.css">


    <title>Web App Zones & Meters - Meters</title>
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

<div>
    <%if(verify){%>
        <p>Something went wrong: <%=errorMsg%></p>
    <%}%>
</div>

<div class="formContainer">

    <form method="POST">
        <div class="fBody">
            <input type="hidden" value="create" name="op">
            <input type="hidden" value="<%=zId%>" name="zId">


            <input type="hidden" value="<% %>" name="id">

            <label for="codMed">Código do Medidor: </label>
            <input type="text" id="codMed" name="codMed" >

            <label for="nomeMed">Nome Medidor: </label>
            <input type="text" id="nomeMed" name="nomeMed">

            <label for="supply_by">Supply By: </label>
            <input type="text" id="supply_by" name="supply_by">

            <label for="codUni">Código de Unidades: </label>
            <input type="text" id="codUni" name="codUni">

            <label for="tipoMed">Tipo de Medidor: </label>
            <input type="text" id="tipoMed" name="tipoMed">

        </div>

        <input class="button-4 meterBtn" type="submit" value="Adicionar">
    </form>


</div>

<footer>
    <h6>© Developed by Gustavo Mota 2022 ©</h6>
</footer>

</body>
</html>
