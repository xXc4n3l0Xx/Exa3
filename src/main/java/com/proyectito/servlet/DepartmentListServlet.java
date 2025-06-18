package com.proyectito.servlet;

import com.proyectito.dao.DepartmentDAO;
import com.proyectito.model.Department;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/departamentos")
public class DepartmentListServlet extends HttpServlet {

    private static final int DEPARTAMENTOS_POR_PAGINA = 50;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int pagina = 1;
        String paginaParam = request.getParameter("page");

        if (paginaParam != null) {
            try {
                pagina = Integer.parseInt(paginaParam);
            } catch (NumberFormatException ignored) {}
        }

        DepartmentDAO dao = new DepartmentDAO();

        List<Department> departamentos = dao.obtenerDepartamentosPaginados(pagina);

        departamentos = departamentos.stream()
                .sorted((d1, d2) -> d1.getDeptName().compareToIgnoreCase(d2.getDeptName()))
                .collect(Collectors.toList());

        int totalDepartamentos = dao.contarTotalDepartamentos();
        int totalPaginas = (int) Math.ceil((double) totalDepartamentos / DEPARTAMENTOS_POR_PAGINA);

        request.setAttribute("departamentos", departamentos);
        request.setAttribute("pagina", pagina);
        request.setAttribute("totalPaginas", totalPaginas);

        request.getRequestDispatcher("departamentos.jsp").forward(request, response);
    }
}
