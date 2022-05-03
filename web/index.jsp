<%--
  Created by IntelliJ IDEA.
  User: baseform
  Date: 4/26/22
  Time: 2:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="application.ConnectionDB.*"%>
<%@ page import="application.ConnectionDB" %>
<%@ page import="application.zoneManager" %>
<%@ page import="application.Zone"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>


<%
  // out JspWriter
  request.getParameter("id"); // HttpServletRequest
  //response; // HttpServletResponse

  request.getSession().setAttribute("teste", "abc");

  ConnectionDB conn = new ConnectionDB();
  Connection cnn = conn.getConnectX();

  List<Zone> zones = new ArrayList<>();

%>
<html>

<style>
  table, th, td {
    border:1px solid black;
  }
</style>

  <head>
    <title>blabla</title>
  </head>
  <body>

  <%= "yes!"+System.currentTimeMillis() %>

  <p>Zones</p><hr>

  <table style="width:100%">

   <thead>
    <tr >
      <th > Código Geográfico</th >
      <th > Nome da Zona</th >
      <th > teste </th >
    </tr >
   </thead>
    <%for(int i=0;i<=zones.size();++i){
        Zone iter = zones.get(i);
    }

    %>
   <tr>
     <td><%=Z%></td>
     <td>TESTE</td>
     <td>TESTE</td>
   </tr>



  </table>


  </body>
</html>
