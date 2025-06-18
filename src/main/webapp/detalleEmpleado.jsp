<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.proyectito.model.Employee" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Detalles del Empleado</title>
</head>
<body>

<%
    Employee emp = (Employee) request.getAttribute("empleado");
    String error = (String) request.getAttribute("error");

    if (error != null) {
%>
<h2><%= error %></h2>
<%
} else {
    List<String> departamentos = emp.getDepartamentos();
    String departamentosTexto = (departamentos != null && !departamentos.isEmpty())
            ? String.join(", ", departamentos)
            : "No asignado";
%>

<h2>Detalles del Empleado</h2>
<ul>
    <li><strong>ID:</strong> <%= emp.getEmpNo() %></li>
    <li><strong>Nombre:</strong> <%= emp.getFirstName() %></li>
    <li><strong>Apellido:</strong> <%= emp.getLastName() %></li>
    <li><strong>Género:</strong> <%= emp.getGender() %></li>
    <li><strong>Fecha de nacimiento:</strong> <%= emp.getBirthDate() %></li>
    <li><strong>Fecha de contratación:</strong> <%= emp.getHireDate() %></li>
    <li><strong>Departamento(s):</strong> <%= departamentosTexto %></li>
</ul>

<h2>Títulos</h2>
<% if (emp.getTitulos() != null && !emp.getTitulos().isEmpty()) { %>
<ul>
    <% for (String t : emp.getTitulos()) { %>
    <li><%= t %></li>
    <% } %>
</ul>
<% } else { %>
<p>No hay títulos registrados.</p>
<% } %>

<h2>Salarios</h2>
<% if (emp.getSalarios() != null && !emp.getSalarios().isEmpty()) { %>
<ul>
    <% for (String s : emp.getSalarios()) { %>
    <li><%= s %></li>
    <% } %>
</ul>
<% } else { %>
<p>No hay salarios registrados.</p>
<% } %>

<br>
<a href="empleados">Volver a la lista</a>
<% } %>

</body>
</html>
