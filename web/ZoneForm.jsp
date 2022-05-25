<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="application.*" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.Comparator" %><%--
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

    if (!"-1".equals(request.getParameter("zId")) && request.getParameter("zId") != null) {
        zId = Integer.parseInt(request.getParameter("zId"));
        z = ZoneManager.getZone(conn, zId);
        x = true;
    }

    String errorMsg = null;
    boolean verify = false;

    //criar
    if (request.getMethod().equals("POST") && request.getParameter("op").equals("create")) {
        try {
            z = ZoneManager.addZone(request, conn);
            response.sendRedirect("index.jsp?hasError=" + (z != null));
        } catch (Exception e) {
            verify = true;
            errorMsg = e.getMessage();
        }

        //edit
    } else if (request.getMethod().equals("POST") && request.getParameter("op").equals("edit")) {

        try {
            z = ZoneManager.editZone(request, conn, zId);
            response.sendRedirect("index.jsp?hasError=" + (z != null));

        } catch (Exception e) {
            verify = true;
            errorMsg = e.getMessage();
        }


        //delete
    } else if (request.getMethod().equals("POST") && request.getParameter("op").equals("delete")) {
        try {
            z = ZoneManager.deleteZone(conn, zId);
            response.sendRedirect("index.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    Meter m = null;

    List<Meter> meters = MeterManager.getMeters(conn, zId);
    meters.sort(new Comparator<Meter>() {
        @Override
        public int compare(Meter o1, Meter o2) {
            return o1.getNomeMedidor().compareTo(o2.getNomeMedidor());
        }
    });

    if (z != null && z.getFk_medidorZona() > 0) {
        try {
            m = MeterManager.getMeter(conn, zId, z.getFk_medidorZona());
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

            <%if (x) {%>
                <label for="medidorZona">Medidor da Zona: </label>
                <Select id="medidorZona" name="medidorZona">
                    <option value="">--</option>
                    <%for (Meter me : meters) {%>
                        <option <%= m != null && m.getCodMedidor().equals(me.getCodMedidor()) ? "selected" : ""%> value="<%=me.getCodMedidor()%>"><%=me.getNomeMedidor()%></option>
                    <%}%>
                </Select>
            <%}%>

        </div>
        <div class="fFooter">
            <input class="button-4 meterBtn" type="submit" value="Adicionar">
            <%if (x) {%>
                <div class="delDiv" >
                    <button class="button-4 delete" id="delete"  data-link="index.jsp?zId=<%=z.getId()%>">Eliminar</button>
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
