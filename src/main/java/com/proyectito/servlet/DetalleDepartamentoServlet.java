package com.proyectito.servlet;

import com.proyectito.dao.DepartmentDAO;
import com.proyectito.model.Department;
import com.proyectito.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/detalleDepartamento")
public class DetalleDepartamentoServlet extends HttpServlet {

    private static final int EMPLEADOS_POR_PAGINA = 50;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String deptNo = request.getParameter("id");
        String orden = request.getParameter("orden");
        String paginaParam = request.getParameter("page");

        int pagina = 1;
        if (paginaParam != null) {
            try {
                pagina = Integer.parseInt(paginaParam);
            } catch (NumberFormatException ignored) {}
        }

        if (deptNo == null || deptNo.isEmpty()) {
            response.sendRedirect("departamentos");
            return;
        }

        DepartmentDAO dao = new DepartmentDAO();
        Department departamento = dao.obtenerDepartamentoConEmpleados(deptNo, pagina);

        if (departamento == null) {
            request.setAttribute("error", "Departamento no encontrado");
        } else {
            List<Employee> empleadosOrdenados = departamento.getEmpleados().stream()
                    .sorted("apellido".equalsIgnoreCase(orden)
                            ? (e1, e2) -> e1.getLastName().compareToIgnoreCase(e2.getLastName())
                            : (e1, e2) -> Integer.compare(e1.getEmpNo(), e2.getEmpNo()))
                    .collect(Collectors.toList());

            departamento.setEmpleados(empleadosOrdenados);

            int totalEmpleados = dao.contarEmpleadosPorDepartamento(deptNo);
            int totalPaginas = (int) Math.ceil((double) totalEmpleados / EMPLEADOS_POR_PAGINA);

            request.setAttribute("departamento", departamento);
            request.setAttribute("pagina", pagina);
            request.setAttribute("ordenActual", orden);
            request.setAttribute("totalPaginas", totalPaginas);
        }

        request.getRequestDispatcher("detalleDepartamento.jsp").forward(request, response);
    }
}
