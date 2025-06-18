package com.proyectito.model;

import java.time.LocalDate;
import java.util.List;

public class Employee {
    private int empNo;
    private LocalDate birthDate;
    private String firstName;
    private String lastName;
    private String gender;
    private LocalDate hireDate;
    private List<String> titulos;
    private List<String> departamentos;
    private List<String> salarios;

    public Employee() {}

    public int getEmpNo() { return empNo; }
    public void setEmpNo(int empNo) { this.empNo = empNo; }

    public LocalDate getBirthDate() { return birthDate; }
    public void setBirthDate(LocalDate birthDate) { this.birthDate = birthDate; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public LocalDate getHireDate() { return hireDate; }
    public void setHireDate(LocalDate hireDate) { this.hireDate = hireDate; }

    public List<String> getTitulos() { return titulos; }
    public void setTitulos(List<String> titulos) { this.titulos = titulos; }

    public List<String> getDepartamentos() { return departamentos; }
    public void setDepartamentos(List<String> departamentos) { this.departamentos = departamentos; }

    public List<String> getSalarios() { return salarios; }
    public void setSalarios(List<String> salarios) { this.salarios = salarios; }
}
