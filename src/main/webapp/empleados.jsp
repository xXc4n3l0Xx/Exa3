<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.proyectito.model.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.Integer" %>
<html>
<head>
    <title>Lista de Empleados</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('images/empleados_info.jpg');
            background-size: cover;
            background-position: center;
            color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 50px auto;
            background-color: rgba(0, 0, 0, 0.75);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.6);
        }

        h1 {
            text-align: center;
            color: #00e0ff;
            margin-bottom: 25px;
        }

        form {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            margin-right: 10px;
        }

        input[type="number"] {
            padding: 6px;
            border-radius: 6px;
            border: none;
            width: 120px;
        }

        button {
            padding: 7px 15px;
            background-color: #00ccff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            color: black;
        }

        button:hover {
            background-color: #009fcc;
        }

        p {
            text-align: center;
            margin: 10px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        table th, table td {
            padding: 8px;
            border: 1px solid #ffffff;
            text-align: center;
            font-size: 0.95em;
        }

        table th {
            background-color: rgba(255, 255, 255, 0.2);
            font-weight: bold;
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

        .pagination {
            text-align: center;
            margin-top: 25px;
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

        .volver {
            display: block;
            margin: 30px auto 10px auto;
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
    </style>
</head>
<body>

<div class="container">
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
        <input type="number" name="emp_no" min="1" required>
        <button type="submit">Buscar</button>
    </form>

    <p>Ordenar por:
        <a href="empleados?page=<%= paginaActual %>&orden=id">ID</a> |
        <a href="empleados?page=<%= paginaActual %>&orden=apellido">Apellido</a>
    </p>

    <table>
        <thead>
        <tr>
            <th style="width: 10%;">ID</th>
            <th style="width: 20%;">Nombre</th>
            <th style="width: 25%;">Apellido</th>
            <th style="width: 25%;">Contratación</th>
            <th style="width: 20%;">Acción</th>
        </tr>
        </thead>
        <tbody>
        <% for (Employee e : empleados) { %>
        <tr>
            <td><%= e.getEmpNo() %></td>
            <td><%= e.getFirstName() %></td>
            <td><%= e.getLastName() %></td>
            <td><%= e.getHireDate() %></td>
            <td><a href="detalleEmpleado?id=<%= e.getEmpNo() %>">Ver detalles</a></td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <%
        boolean busqueda = request.getAttribute("busqueda") != null && (Boolean) request.getAttribute("busqueda");
        if (!busqueda) {
    %>
    <div class="pagination">
        <% if (paginaActual > 1) { %>
        <a class="navegacion" href="empleados?page=<%= anterior %>">Anterior</a>
        <% } %>
        <% if (totalPaginas != null && paginaActual < totalPaginas) { %>
        <a class="navegacion" href="empleados?page=<%= siguiente %>">Siguiente</a>
        <% } %>
    </div>
    <% } %>

    <a href="index.jsp" class="volver">← Volver al inicio</a>
</div>

</body>
</html>
