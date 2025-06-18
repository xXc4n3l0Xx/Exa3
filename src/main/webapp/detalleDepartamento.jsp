<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.proyectito.model.Department" %>
<%@ page import="com.proyectito.model.Employee" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Detalle del Departamento</title>
</head>
<body>

<%
  Department dept = (Department) request.getAttribute("departamento");
  String error = (String) request.getAttribute("error");

  if (error != null) {
%>
<h2><%= error %></h2>
<%
} else {
  List<Employee> empleados = dept.getEmpleados();
  int pagina = (request.getAttribute("pagina") != null) ? (Integer) request.getAttribute("pagina") : 1;
  int totalPaginas = (request.getAttribute("totalPaginas") != null) ? (Integer) request.getAttribute("totalPaginas") : 1;
  int anterior = (pagina > 1) ? pagina - 1 : 1;
  int siguiente = pagina + 1;
  String orden = (String) request.getAttribute("ordenActual");
%>

<h1>Departamento: <%= dept.getDeptName() %> (<%= dept.getDeptNo() %>)</h1>

<h2>Empleados asignados:</h2>

<p>Ordenar por:
  <a href="detalleDepartamento?id=<%= dept.getDeptNo() %>&orden=id">ID</a> |
  <a href="detalleDepartamento?id=<%= dept.getDeptNo() %>&orden=apellido">Apellido</a>
</p>

<table border="1">
  <tr>
    <th>ID</th><th>Nombre</th><th>Apellido</th><th>Contratación</th><th>Acción</th>
  </tr>
  <% for (Employee emp : empleados) { %>
  <tr>
    <td><%= emp.getEmpNo() %></td>
    <td><%= emp.getFirstName() %></td>
    <td><%= emp.getLastName() %></td>
    <td><%= emp.getHireDate() %></td>
    <td><a href="detalleEmpleado?id=<%= emp.getEmpNo() %>">Ver detalles</a></td>
  </tr>
  <% } %>
</table>

<br>
<a href="departamentos">Volver a la lista</a>

<div style="margin-top: 15px;">
  <% if (pagina > 1) { %>
  <a href="detalleDepartamento?id=<%= dept.getDeptNo() %>&page=<%= anterior %><%= (orden != null ? "&orden=" + orden : "") %>">Anterior</a>
  <% } %>

  <% if (pagina < totalPaginas) { %>
  <% if (pagina > 1) { %> | <% } %>
  <a href="detalleDepartamento?id=<%= dept.getDeptNo() %>&page=<%= siguiente %><%= (orden != null ? "&orden=" + orden : "") %>">Siguiente</a>
  <% } %>
</div>

<% } %>
</body>
</html>
