<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.proyectito.model.Department" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.Integer" %>
<html>
<head>
    <title>Lista de Departamentos</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('images/departamento.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            margin: 0;
            padding: 0;
            color: #ffffff;
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            background-color: rgba(0, 0, 0, 0.8);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.6);
        }

        h1 {
            text-align: center;
            color: #00ccff;
            border-bottom: 1px solid #00ccff;
            padding-bottom: 10px;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 10px 14px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
        }

        th {
            background-color: rgba(255, 255, 255, 0.15);
            color: #00ccff;
        }

        td {
            font-size: 0.95em;
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

        .pagination {
            text-align: center;
            margin-top: 20px;
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
    List<Department> departamentos = (List<Department>) request.getAttribute("departamentos");
    Integer paginaActual = (Integer) request.getAttribute("pagina");
    Integer totalPaginas = (Integer) request.getAttribute("totalPaginas");
    int anterior = (paginaActual > 1) ? paginaActual - 1 : 1;
    int siguiente = paginaActual + 1;
%>

<div class="container">
    <h1>Departamentos (Página <%= paginaActual %> de <%= totalPaginas %>)</h1>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Acción</th>
        </tr>
        </thead>
        <tbody>
        <% for (Department d : departamentos) { %>
        <tr>
            <td><%= d.getDeptNo() %></td>
            <td><%= d.getDeptName() %></td>
            <td><a href="detalleDepartamento?id=<%= d.getDeptNo() %>">Ver detalles</a></td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <% if (totalPaginas > 1) { %>
    <div class="pagination">
        <% if (paginaActual > 1) { %>
        <a class="navegacion" href="departamentos?page=<%= anterior %>">Anterior</a>
        <% } %>
        <% if (paginaActual < totalPaginas) { %>
        <a class="navegacion" href="departamentos?page=<%= siguiente %>">Siguiente</a>
        <% } %>
    </div>
    <% } %>

    <a href="index.jsp" class="volver">← Volver al inicio</a>
</div>

</body>
</html>
