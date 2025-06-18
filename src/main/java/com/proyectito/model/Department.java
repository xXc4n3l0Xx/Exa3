package com.proyectito.model;

import java.util.List;

public class Department {
    private String deptNo;
    private String deptName;
    private List<Employee> empleados;

    public Department() {}

    public String getDeptNo() { return deptNo; }
    public void setDeptNo(String deptNo) { this.deptNo = deptNo; }

    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }

    public List<Employee> getEmpleados() {return empleados; }
    public void setEmpleados(List<Employee> empleados) { this.empleados = empleados; }
}
