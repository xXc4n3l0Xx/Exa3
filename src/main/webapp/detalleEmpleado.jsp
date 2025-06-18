<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.proyectito.model.Employee" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Detalles del Empleado</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('images/detalle_empleado.jpg');
            background-size: cover;
            background-position: center;
            margin: 0;
            padding: 0;
            color: #ffffff;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 30px;
            background-color: rgba(0, 0, 0, 0.8);
            border-radius: 15px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.6);
        }

        h2 {
            text-align: center;
            color: #00ccff;
            border-bottom: 1px solid #00ccff;
            padding-bottom: 8px;
            margin-top: 30px;
            font-size: 1.5em;
        }

        table.info-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table.info-table td {
            padding: 6px 10px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
            vertical-align: top;
        }

        .label {
            font-weight: bold;
            color: #ffcc00;
            width: 40%;
        }

        .value {
            color: #ffffff;
        }

        .chips {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: flex-start;
            margin-top: 10px;
        }

        .chip {
            background-color: #00ccff;
            color: #000;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.9em;
            font-weight: bold;
        }

        .salario-table {
            width: 100%;
            margin-top: 10px;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.05);
        }

        .salario-table th, .salario-table td {
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 6px 10px;
            text-align: center;
            font-size: 0.9em;
        }

        .salario-table th {
            color: #00ccff;
            font-weight: bold;
        }

        a {
            display: block;
            margin: 30px auto 10px auto;
            text-align: center;
            background-color: #00ccff;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            color: #000000;
            width: fit-content;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #009fcc;
        }

        p {
            text-align: center;
            color: #cccccc;
        }
    </style>
</head>
<body>

<%
    Employee emp = (Employee) request.getAttribute("empleado");
    String error = (String) request.getAttribute("error");

    if (error != null) {
%>
<div class="container">
    <h2><%= error %></h2>
</div>
<%
} else {
    List<String> departamentos = emp.getDepartamentos();
    String departamentosTexto = (departamentos != null && !departamentos.isEmpty())
            ? String.join(", ", departamentos)
            : "No asignado";
%>

<div class="container">
    <h2>Detalles del Empleado</h2>
    <table class="info-table">
        <tr><td class="label">ID:</td><td class="value"><%= emp.getEmpNo() %></td></tr>
        <tr><td class="label">Nombre:</td><td class="value"><%= emp.getFirstName() %></td></tr>
        <tr><td class="label">Apellido:</td><td class="value"><%= emp.getLastName() %></td></tr>
        <tr><td class="label">Género:</td><td class="value"><%= emp.getGender() %></td></tr>
        <tr><td class="label">Fecha de nacimiento:</td><td class="value"><%= emp.getBirthDate() %></td></tr>
        <tr><td class="label">Fecha de contratación:</td><td class="value"><%= emp.getHireDate() %></td></tr>
        <tr><td class="label">Departamento(s):</td><td class="value"><%= departamentosTexto %></td></tr>
    </table>

    <div class="section">
        <h2>Títulos</h2>
        <% if (emp.getTitulos() != null && !emp.getTitulos().isEmpty()) { %>
        <div class="chips">
            <% for (String t : emp.getTitulos()) { %>
            <div class="chip"><%= t %></div>
            <% } %>
        </div>
        <% } else { %>
        <p>No hay títulos registrados.</p>
        <% } %>
    </div>

    <div class="section">
        <h2>Salarios</h2>
        <% if (emp.getSalarios() != null && !emp.getSalarios().isEmpty()) { %>
        <table class="salario-table">
            <thead>
            <tr><th>Sueldo</th><th>Desde</th><th>Hasta</th></tr>
            </thead>
            <tbody>
            <% for (String s : emp.getSalarios()) {
                String[] partes = s.replace("$", "").replace("(", "").replace(")", "").split(" ");
            %>
            <tr>
                <td>$<%= partes[0] %></td>
                <td><%= partes[1] %></td>
                <td><%= partes[3] %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p>No hay salarios registrados.</p>
        <% } %>
    </div>

    <a href="empleados">← Volver a la lista de empleados</a>
</div>
<% } %>

</body>
</html>
