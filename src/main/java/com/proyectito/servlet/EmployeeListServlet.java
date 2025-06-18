package com.proyectito.servlet;

import com.proyectito.dao.EmployeeDAO;
import com.proyectito.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/empleados")
public class EmployeeListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmployeeDAO dao = new EmployeeDAO();

        String empNoParam = request.getParameter("emp_no");
        String orden = request.getParameter("orden");

        if (empNoParam != null && !empNoParam.isEmpty()) {
            try {
                int empNo = Integer.parseInt(empNoParam);
                Employee empleado = dao.obtenerEmpleadoPorId(empNo);

                List<Employee> empleados = (empleado != null)
                        ? Arrays.asList(empleado).stream()
                        .filter(e -> e.getEmpNo() == empNo)
                        .collect(Collectors.toList())
                        : new ArrayList<>();

                request.setAttribute("empleados", empleados);
                request.setAttribute("pagina", 1);
                request.setAttribute("busqueda", true);
                request.setAttribute("ordenActual", orden);

            } catch (NumberFormatException e) {
                request.setAttribute("error", "Número inválido");
            }

        } else {
            int pagina = 1;
            String paginaParam = request.getParameter("page");

            if (paginaParam != null) {
                try {
                    pagina = Integer.parseInt(paginaParam);
                } catch (NumberFormatException ignored) {}
            }

            List<Employee> empleados = dao.obtenerEmpleadosPaginados(pagina);

            empleados = empleados.stream()
                    .sorted((e1, e2) -> {
                        if ("apellido".equalsIgnoreCase(orden)) {
                            return e1.getLastName().compareToIgnoreCase(e2.getLastName());
                        } else {
                            return Integer.compare(e1.getEmpNo(), e2.getEmpNo());
                        }
                    })
                    .collect(Collectors.toList());

            int totalEmpleados = dao.contarTotalEmpleados();
            int totalPaginas = (int) Math.ceil((double) totalEmpleados / 50);
            request.setAttribute("totalPaginas", totalPaginas);

            request.setAttribute("empleados", empleados);
            request.setAttribute("pagina", pagina);
            request.setAttribute("busqueda", false);
            request.setAttribute("ordenActual", orden);
        }

        request.getRequestDispatcher("empleados.jsp").forward(request, response);
    }
}
