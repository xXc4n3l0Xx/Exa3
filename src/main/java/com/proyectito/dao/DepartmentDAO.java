package com.proyectito.dao;

import com.proyectito.model.Department;
import com.proyectito.model.Employee;
import com.proyectito.util.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DepartmentDAO {

    private static final int PAGE_SIZE = 50;

    public List<Department> obtenerDepartamentosPaginados(int pagina) {
        List<Department> departamentos = new ArrayList<>();

        String sql = "SELECT dept_no, dept_name FROM departments ORDER BY dept_no LIMIT ? OFFSET ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, PAGE_SIZE);
            stmt.setInt(2, (pagina - 1) * PAGE_SIZE);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Department dept = new Department();
                    dept.setDeptNo(rs.getString("dept_no"));
                    dept.setDeptName(rs.getString("dept_name"));
                    departamentos.add(dept);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return departamentos;
    }

    public Department obtenerDepartamentoConEmpleados(String deptNo, int pagina) {
        Department dept = null;
        final int PAGE_SIZE = 50;
        String sqlDept = "SELECT dept_no, dept_name FROM departments WHERE dept_no = ?";
        String sqlEmpleados = "SELECT e.emp_no, e.first_name, e.last_name, e.hire_date " +
                "FROM employees e " +
                "JOIN dept_emp de ON e.emp_no = de.emp_no " +
                "WHERE de.dept_no = ? " +
                "ORDER BY e.emp_no " +
                "LIMIT ? OFFSET ?";

        try (Connection conn = Conexion.getConexion()) {
            try (PreparedStatement stmtDept = conn.prepareStatement(sqlDept)) {
                stmtDept.setString(1, deptNo);
                try (ResultSet rs = stmtDept.executeQuery()) {
                    if (rs.next()) {
                        dept = new Department();
                        dept.setDeptNo(rs.getString("dept_no"));
                        dept.setDeptName(rs.getString("dept_name"));
                    }
                }
            }

            if (dept != null) {
                List<Employee> empleados = new ArrayList<>();
                try (PreparedStatement stmtEmp = conn.prepareStatement(sqlEmpleados)) {
                    stmtEmp.setString(1, deptNo);
                    stmtEmp.setInt(2, PAGE_SIZE);
                    stmtEmp.setInt(3, (pagina - 1) * PAGE_SIZE);
                    try (ResultSet rs = stmtEmp.executeQuery()) {
                        while (rs.next()) {
                            Employee emp = new Employee();
                            emp.setEmpNo(rs.getInt("emp_no"));
                            emp.setFirstName(rs.getString("first_name"));
                            emp.setLastName(rs.getString("last_name"));
                            emp.setHireDate(rs.getDate("hire_date").toLocalDate());
                            empleados.add(emp);
                        }
                    }
                }
                dept.setEmpleados(empleados);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dept;
    }

    public int contarEmpleadosPorDepartamento(String deptNo) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM dept_emp WHERE dept_no = ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, deptNo);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    public int contarTotalDepartamentos() {
        String sql = "SELECT COUNT(*) FROM departments";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
