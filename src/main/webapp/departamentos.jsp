<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.proyectito.model.Department" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.Integer" %>
<html>
<head>
    <title>Lista de Departamentos</title>
</head>
<body>

<%
    List<Department> departamentos = (List<Department>) request.getAttribute("departamentos");
    Integer paginaActual = (Integer) request.getAttribute("pagina");
    Integer totalPaginas = (Integer) request.getAttribute("totalPaginas");
    int anterior = (paginaActual > 1) ? paginaActual - 1 : 1;
    int siguiente = paginaActual + 1;
%>

<h1>Departamentos (Página <%= paginaActual %> de <%= totalPaginas %>)</h1>

<table border="1">
    <tr>
        <th>ID</th><th>Nombre</th><th>Acción</th>
    </tr>
    <%
        for (Department d : departamentos) {
    %>
    <tr>
        <td><%= d.getDeptNo() %></td>
        <td><%= d.getDeptName() %></td>
        <td><a href="detalleDepartamento?id=<%= d.getDeptNo() %>">Ver detalles</a></td>
    </tr>
    <% } %>
</table>

<div style="margin-top: 15px;">
    <% if (paginaActual > 1) { %>
    <a href="departamentos?page=<%= anterior %>">Anterior</a>
    <% } %>

    <% if (paginaActual < totalPaginas) { %>
    <% if (paginaActual > 1) { %> | <% } %>
    <a href="departamentos?page=<%= siguiente %>">Siguiente</a>
    <% } %>
</div>

</body>
</html>
