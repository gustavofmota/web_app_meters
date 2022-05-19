<%@ page import="java.util.List" %>
<%@ page import="application.Meter" %>
<%@ page import="application.*" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%--
  Created by IntelliJ IDEA.
  User: baseform
  Date: 5/5/22
  Time: 2:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ConnectionDB conn = (ConnectionDB) request.getSession().getAttribute("connection");

    int zId = Integer.parseInt(request.getParameter("zId"));
    //int mId = Integer.parseInt(request.getParameter("mId"));

    boolean hasError = request.getParameter("hasError").equals(Boolean.TRUE.toString());

    if (request.getMethod().equals("POST") && request.getParameter("op").equals("create")) {

        Meter meter = MeterManager.addMeter(request, conn, zId);
        hasError = meter == null;
    }

    List<Meter> meters = MeterManager.getMeters(conn, zId);

%>

<html>

<head>

    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css">

    <title>Web App Zones & Meters - Meters</title>
</head>
<body>

<header>
    <h1>Web App Zones & Meters</h1>
    <div class="right">
        <h1>Beta Version</h1>
    </div>
</header>

<div class="container">
    <div class="containerHeader">
        <h2>Meters</h2>
    </div>
    <div class="grid">
        <div class="box click ">
            <a id="plus" method="post" href="MeterForm.jsp?zId=<%=zId%>">
                <p class="light">+</p>
            </a>
        </div>

        <% if (hasError) { %>

        <%--   ADICIONAR POP-UP --%>
        <p>Something went wrong</p>
        <%--   ADICIONAR POP-UP --%>

        <% }%>

        <%for (Meter m : meters) {%>
            <div class="box">
                <div class="zoneWrapper" data-zid="<%=zId%>">
                    <div class="boxHeader">
                        <div class="name">
                            <p><%=StringEscapeUtils.escapeHtml4(m.getNomeMedidor())%></p>
                        </div>
                        <div class="leftBtn">
                            <button class="button" data-link="MeterForm.jsp?mId=<%=m.getId()%>&zId=<%=zId%>">Editar</button>
                            <button class="button" name="mId" value="<%=m.getId()%>">Eliminar</button>
                        </div>
                    </div>
                    <div class="boxBody boxWrapper">
                        <p>Código do Medidor: <a class="light"><%=m.getCodMedidor()%></a></p>
                        <p>Supply By: <a class="light"><%=m.getSuply_by()%></a></p>
                        <p>Código das Unidades: <a class="light"><%=m.getCodUni()%></a></p>
                        <p>Tipo de Medidor: <a class="light"><%=m.getTipoMedidor()%></a></p>
                    </div>
                </div>
            </div>
        <%}%>
    </div>
</div>








<%--
<div class="metersHeader">
    <h2>Meters</h2>
</div>

<div class="main">

    <div class="mybox click ">
        <a id="plus" method="post" href="MeterForm.jsp?zId=<%=zId%>">
            <p class="light">+</p>
        </a>
    </div>

    <% if (hasError) { %>

    &lt;%&ndash;    ADICIONAR POP-UP &ndash;%&gt;
    <p>Something went wrong</p>
    &lt;%&ndash;    ADICIONAR POP-UP  &ndash;%&gt;

    <% }%>

    <%for (Meter m : meters) {%>
    <div class="myBox">
        <div class="zoneWrapper">
            <div class="boxHeader">
                <p><%=m.getNomeMedidor()%>
                </p>
                <div class="leftBtn">
                    <button class="button-4" data-link="ZoneForm.jsp?mId=<%=m.getId()%>">Editar</button>
                    <button type="submit" class="button-4" name="mId" value="<%=m.getId()%>">Eliminar</button>
                </div>
            </div>

            <div class="boxBody">

                <table>
                    <tr>
                        <td>Código do Medidor: <a class="light"><%=m.getCodMedidor()%>
                        </a></td>
                    </tr>

                    <tr>
                        <td>Supply By: <a class="light"><%=m.getSuply_by()%>
                        </a></td>
                    </tr>

                    <tr>
                        <td>Código das Unidades: <a class="light"><%=m.getCodUni()%>
                        </a></td>
                    </tr>

                    <tr>
                        <td>Tipo de Medidor: <a class="light"><%=m.getTipoMedidor()%>
                        </a></td>
                    </tr>
                </table>

            </div>
        </div>
    </div>
    <%}%>
</div>
--%>

<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>

<footer>
    <h6>© Developed by Gustavo Mota 2022 ©</h6>
</footer>
</body>
</html>
