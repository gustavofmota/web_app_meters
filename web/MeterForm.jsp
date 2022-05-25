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
    boolean x = false;
    int mId = -1;
    int zId = Integer.parseInt(request.getParameter("zId"));
    Meter m = new Meter();

    if (request.getParameter("mId") != null) {
        mId = Integer.parseInt(request.getParameter("mId"));
        m = MeterManager.getMeter(conn, zId, mId);
        x = true;
    }

    String errorMsg = null;
    Meter meter = new Meter();
    boolean verify = false;
    boolean idVer = false;



    /*Adicionar Meter*/
    if (request.getMethod().equals("POST") && request.getParameter("op").equals("create")) {
        try {

            meter = MeterManager.addMeter(request, conn, zId);
            idVer = true;
            response.sendRedirect("meters.jsp?zId=" + zId + "&hasError=" + (meter != null));
        } catch (Exception e) {
            verify = true;
            errorMsg = e.getMessage();
        }
         /*if(meter==null)
         response.sendRedirect("meters.jsp?zId="+zId+"&hasError=" + (meter==null));*/

    /*Editar medidor*/
    } else if (request.getMethod().equals("POST") && request.getParameter("op").equals("edit")) {
        try {
            meter = MeterManager.editMeter(request, conn, zId, mId);
            response.sendRedirect("meters.jsp?zId=" + zId + "&hasError=" + (meter != null));
        } catch (Exception e) {
            verify = true;
            errorMsg = e.getMessage();
        }
    }
    else if (request.getMethod().equals("POST") && request.getParameter("op").equals("delete")) {
        try{
             //meter = MeterManager.
        } catch (Exception e) {
            e.printStackTrace();
        }
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


<div>
    <%if (verify) {%>
    <p>Something went wrong: <%=errorMsg%>
    </p>
    <%}%>
</div>

<div class="formContainer">

    <form method="POST">
        <div class="fBody">
            <input id="change" type="hidden" <%if(x){%>value="edit"<%}else{%> value="create"<%}%> name="op">
            <input type="hidden" value="<%=zId%>" name="zId">


            <input type="hidden" <%if(x){%>value="<%=m.getId()%>"<%}%> name="id">

            <label for="codMed">Código do Medidor: </label>
            <input type="text" id="codMed" name="codMed" <%if(x){%>value="<%=m.getCodMedidor()%>"<%}%>>

            <label for="nomeMed">Nome Medidor: </label>
            <input type="text" id="nomeMed" name="nomeMed" <%if(x){%>value="<%=m.getNomeMedidor()%>"<%}%>>

            <label for="supply_by">Supply By: </label>
            <input type="text" id="supply_by" name="supply_by" <%if(x){%>value="<%=m.getSuply_by()%>"<%}%>>

            <label for="codUni">Código de Unidades: </label>
            <input type="text" id="codUni" name="codUni" <%if(x){%>value="<%=m.getCodUni()%>"<%}%>>

            <label for="tipoMed">Tipo de Medidor: </label>
            <input type="text" id="tipoMed" name="tipoMed" <%if(x){%>value="<%=m.getTipoMedidor()%>"<%}%>>

        </div>

        <div class="fFooter">
            <input class="button-4 meterBtn" type="submit" value="Adicionar">
            <%if (x) {%>
            <div class="delDiv" >
                <button class="button-4 delete" id="delete"  data-link="index.jsp?zId=<%=zId%>">Eliminar</button>
            </div>
            <%}%>
        </div>
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
