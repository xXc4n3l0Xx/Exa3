package com.proyectito.dao;

import com.proyectito.model.Employee;
import com.proyectito.util.Conexion;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    private static final int PAGE_SIZE = 50;

    public List<Employee> obtenerEmpleadosPaginados(int pagina) {
        List<Employee> empleados = new ArrayList<>();

        String sql = "SELECT emp_no, birth_date, first_name, last_name, gender, hire_date " +
                "FROM employees ORDER BY emp_no LIMIT ? OFFSET ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, PAGE_SIZE);
            stmt.setInt(2, (pagina - 1) * PAGE_SIZE);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Employee emp = new Employee();

                    int empNo = rs.getInt("emp_no");
                    emp.setEmpNo(empNo);
                    emp.setBirthDate(rs.getDate("birth_date").toLocalDate());
                    emp.setFirstName(rs.getString("first_name"));
                    emp.setLastName(rs.getString("last_name"));
                    emp.setGender(rs.getString("gender"));
                    emp.setHireDate(rs.getDate("hire_date").toLocalDate());
                    empleados.add(emp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return empleados;
    }

    public Employee obtenerEmpleadoPorId(int empNo) {
        Employee emp = null;
        String sql = "SELECT emp_no, birth_date, first_name, last_name, gender, hire_date " +
                "FROM employees WHERE emp_no = ?";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, empNo);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    emp = new Employee();
                    emp.setEmpNo(rs.getInt("emp_no"));
                    emp.setBirthDate(rs.getDate("birth_date").toLocalDate());
                    emp.setFirstName(rs.getString("first_name"));
                    emp.setLastName(rs.getString("last_name"));
                    emp.setGender(rs.getString("gender"));
                    emp.setHireDate(rs.getDate("hire_date").toLocalDate());
                    emp.setTitulos(obtenerTitulosPorEmpleado(conn, empNo));
                    emp.setDepartamentos(obtenerDepartamentosPorEmpleado(conn, empNo));
                    emp.setSalarios(obtenerSalariosPorEmpleado(conn, empNo));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return emp;
    }

    private List<String> obtenerTitulosPorEmpleado(Connection conn, int empNo) throws SQLException {
        List<String> titulos = new ArrayList<>();
        String sql = "SELECT title FROM titles WHERE emp_no = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empNo);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    titulos.add(rs.getString("title"));
                }
            }
        }
        return titulos;
    }

    private List<String> obtenerDepartamentosPorEmpleado(Connection conn, int empNo) throws SQLException {
        List<String> departamentos = new ArrayList<>();
        String sql = "SELECT d.dept_name FROM departments d " +
                "JOIN dept_emp de ON d.dept_no = de.dept_no " +
                "WHERE de.emp_no = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empNo);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    departamentos.add(rs.getString("dept_name"));
                }
            }
        }
        return departamentos;
    }

    private List<String> obtenerSalariosPorEmpleado(Connection conn, int empNo) throws SQLException {
        List<String> salarios = new ArrayList<>();
        String sql = "SELECT salary, from_date, to_date FROM salaries WHERE emp_no = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empNo);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int s = rs.getInt("salary");
                    Date f = rs.getDate("from_date");
                    Date t = rs.getDate("to_date");
                    salarios.add("$" + s + " (" + f + " - " + t + ")");
                }
            }
        }
        return salarios;
    }

    public int contarTotalEmpleados() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM employees";
        try (Connection conn = Conexion.getConexion();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

}
