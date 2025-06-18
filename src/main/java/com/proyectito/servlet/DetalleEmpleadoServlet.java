package com.proyectito.servlet;

import com.proyectito.dao.EmployeeDAO;
import com.proyectito.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/detalleEmpleado")
public class DetalleEmpleadoServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("empleados");
            return;
        }

        int empNo;
        try {
            empNo = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("empleados");
            return;
        }

        EmployeeDAO dao = new EmployeeDAO();
        Employee empleado = dao.obtenerEmpleadoPorId(empNo);

        if (empleado == null) {
            request.setAttribute("error", "Empleado no encontrado");
        } else {
            List<Employee> lista = java.util.Arrays.asList(empleado).stream()
                    .filter(e -> e.getEmpNo() == empNo)
                    .collect(Collectors.toList());

            request.setAttribute("empleado", lista.get(0));
        }

        request.getRequestDispatcher("detalleEmpleado.jsp").forward(request, response);
    }
}
