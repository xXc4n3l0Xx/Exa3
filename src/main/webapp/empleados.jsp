<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.proyectito.model.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.Integer" %>
<html>
<head>
    <title>Lista de Empleados</title>
</head>
<body>

<%
    List<Employee> empleados = (List<Employee>) request.getAttribute("empleados");
    Integer paginaActual = (Integer) request.getAttribute("pagina");
    Integer totalPaginas = (Integer) request.getAttribute("totalPaginas");
    int anterior = (paginaActual > 1) ? paginaActual - 1 : 1;
    int siguiente = paginaActual + 1;
%>

<h1>Empleados (Página <%= paginaActual %>)</h1>

<form action="empleados" method="get">
    <label>Buscar por número de empleado:</label>
    <input type="number" name="emp_no" required>
    <button type="submit">Buscar</button>
</form>

<br/>

<p>Ordenar por:
    <a href="empleados?page=<%= paginaActual %>&orden=id">ID</a> |
    <a href="empleados?page=<%= paginaActual %>&orden=apellido">Apellido</a>
</p>

<table border="1">
    <tr>
        <th>ID</th><th>Nombre</th><th>Apellido</th><th>Contratación</th><th>Acción</th>
    </tr>
    <% for (Employee e : empleados) { %>
    <tr>
        <td><%= e.getEmpNo() %></td>
        <td><%= e.getFirstName() %></td>
        <td><%= e.getLastName() %></td>
        <td><%= e.getHireDate() %></td>
        <td><a href="detalleEmpleado?id=<%= e.getEmpNo() %>">Ver detalles</a></td>
    </tr>
    <% } %>
</table>

<%
    boolean busqueda = request.getAttribute("busqueda") != null && (Boolean) request.getAttribute("busqueda");
    if (!busqueda) {
%>
<div style="margin-top: 15px;">
    <% if (paginaActual > 1) { %>
    <a href="empleados?page=<%= anterior %>">Anterior</a>
    <% } %>

    <% if (totalPaginas != null && paginaActual < totalPaginas) { %>
    <% if (paginaActual > 1) { %> | <% } %>
    <a href="empleados?page=<%= siguiente %>">Siguiente</a>
    <% } %>
</div>

<% } %>

</body>
</html>
