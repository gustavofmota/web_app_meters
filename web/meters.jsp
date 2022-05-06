<%@ page import="java.util.List" %>
<%@ page import="application.Meter" %>
<%@ page import="application.*" %>
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

    int zId = Integer.parseInt(request.getParameter("id"));
    //int mId = Integer.parseInt(request.getParameter("mId"));

    List<Meter> meters = MeterManager.getMeters(conn, zId);


%>

<html>

<head>

    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/myStyle_meters.css">

    <title>Web App Zones & Meters - Meters</title>
</head>
<body>

<header>
    <h1>Web App Zones & Meters</h1>
    <div class="right">
        <h1>Beta Version</h1>
    </div>
</header>

<div class="zonesHeader">
    <h2>Meters</h2>
</div>

<div class="main">

    <a href="MeterForm.jsp?id=<%=zId%>">
        <div class="mybox click ">
            <p class="light">+</p>
        </div>
    </a>

    <%for (Meter m : meters) {%>
    <div class="myBox">
        <div class="boxHeader">
            <p><%=m.getNomeMedidor()%>
            </p>
            <div class="leftBtn">
                <button class="button-4" role="button">Editar</button>
                <button type="submit" class="button-4" role="button" name="mId" value="<%=m.getId()%>">Eliminar</button>
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
    <%}%>
</div>

<footer>
    <h6>© Developed by Gustavo Mota 2022 ©</h6>
</footer>
</body>
</html>
