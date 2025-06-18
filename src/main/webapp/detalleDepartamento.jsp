<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.proyectito.model.Department" %>
<%@ page import="com.proyectito.model.Employee" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Detalle del Departamento</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-image: url('images/departamento_detalles.jpg');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      color: #ffffff;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 1000px;
      margin: 50px auto;
      padding: 30px;
      background-color: rgba(0, 0, 0, 0.8);
      border-radius: 15px;
      box-shadow: 0 12px 30px rgba(0, 0, 0, 0.6);
    }

    h1, h2 {
      text-align: center;
      color: #00ccff;
      margin-bottom: 20px;
    }

    .order-links {
      text-align: center;
      margin-bottom: 15px;
    }

    .order-links a {
      color: #00ccff;
      text-decoration: none;
      font-weight: bold;
      margin: 0 6px;
    }

    .order-links a:hover {
      text-decoration: underline;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: rgba(255, 255, 255, 0.05);
      margin-top: 10px;
    }

    th, td {
      padding: 10px;
      border: 1px solid rgba(255, 255, 255, 0.2);
      text-align: center;
      font-size: 0.95em;
    }

    th {
      background-color: rgba(255, 255, 255, 0.15);
      color: #00ccff;
    }

    tr:hover {
      background-color: rgba(255, 255, 255, 0.08);
    }

    a {
      color: #00ccff;
      text-decoration: none;
      font-weight: bold;
    }

    a:hover {
      text-decoration: underline;
    }

    .volver {
      display: block;
      margin: 30px auto 15px auto;
      text-align: center;
      background-color: #00ccff;
      padding: 10px 20px;
      border-radius: 8px;
      text-decoration: none;
      font-weight: bold;
      color: #000000;
      width: fit-content;
      transition: background-color 0.3s ease;
    }

    .volver:hover {
      background-color: #009fcc;
    }

    .pagination {
      text-align: center;
      margin-top: 15px;
    }

    .pagination .navegacion {
      display: inline-block;
      margin: 5px 8px;
      padding: 7px 14px;
      font-size: 0.9em;
      background-color: transparent;
      border: 2px solid #00ccff;
      border-radius: 6px;
      color: #00ccff;
      font-weight: bold;
      text-decoration: none;
      transition: all 0.3s ease;
    }

    .pagination .navegacion:hover {
      background-color: #00ccff;
      color: #000000;
    }
  </style>
</head>
<body>

<%
  Department dept = (Department) request.getAttribute("departamento");
  String error = (String) request.getAttribute("error");

  if (error != null) {
%>
<div class="container">
  <h2><%= error %></h2>
</div>
<%
} else {
  List<Employee> empleados = dept.getEmpleados();
  int pagina = (request.getAttribute("pagina") != null) ? (Integer) request.getAttribute("pagina") : 1;
  int totalPaginas = (request.getAttribute("totalPaginas") != null) ? (Integer) request.getAttribute("totalPaginas") : 1;
  int anterior = (pagina > 1) ? pagina - 1 : 1;
  int siguiente = pagina + 1;
  String orden = (String) request.getAttribute("ordenActual");
%>

<div class="container">
  <h1>Departamento: <%= dept.getDeptName() %> (<%= dept.getDeptNo() %>)</h1>
  <h2>Empleados asignados</h2>

  <div class="order-links">
    Ordenar por:
    <a href="detalleDepartamento?id=<%= dept.getDeptNo() %>&orden=id">ID</a> |
    <a href="detalleDepartamento?id=<%= dept.getDeptNo() %>&orden=apellido">Apellido</a>
  </div>

  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>Nombre</th>
      <th>Apellido</th>
      <th>Contratación</th>
      <th>Acción</th>
    </tr>
    </thead>
    <tbody>
    <% for (Employee emp : empleados) { %>
    <tr>
      <td><%= emp.getEmpNo() %></td>
      <td><%= emp.getFirstName() %></td>
      <td><%= emp.getLastName() %></td>
      <td><%= emp.getHireDate() %></td>
      <td><a href="detalleEmpleado?id=<%= emp.getEmpNo() %>">Ver detalles</a></td>
    </tr>
    <% } %>
    </tbody>
  </table>

  <a href="departamentos" class="volver">← Volver a lista de departamentos</a>

  <% if (totalPaginas > 1) { %>
  <div class="pagination">
    <% if (pagina > 1) { %>
    <a class="navegacion" href="detalleDepartamento?id=<%= dept.getDeptNo() %>&page=<%= anterior %><%= (orden != null ? "&orden=" + orden : "") %>">Anterior</a>
    <% } %>
    <% if (pagina < totalPaginas) { %>
    <a class="navegacion" href="detalleDepartamento?id=<%= dept.getDeptNo() %>&page=<%= siguiente %><%= (orden != null ? "&orden=" + orden : "") %>">Siguiente</a>
    <% } %>
  </div>
  <% } %>
</div>

<% } %>

</body>
</html>
