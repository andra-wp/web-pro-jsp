package com.example.servlet;

import com.example.dao.MahasiswaDAO;
import com.example.model.Mahasiswa;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private MahasiswaDAO dao;

    @Override
    public void init() {
        dao = new MahasiswaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Mahasiswa> data = dao.getAll();

        int total = data.size();

        int totalProdi = (int) data.stream()
                .map(Mahasiswa::getProdi)
                .distinct()
                .count();

        double avgSemester = data.stream()
                .mapToInt(Mahasiswa::getSemester)
                .average()
                .orElse(0);

        List<Mahasiswa> terbaru = data.stream()
                .limit(5)
                .collect(Collectors.toList());

        Map<String, Long> chartData = data.stream()
                .collect(Collectors.groupingBy(
                        Mahasiswa::getProdi,
                        Collectors.counting()
                ));

        req.setAttribute("total", total);
        req.setAttribute("totalProdi", totalProdi);
        req.setAttribute("avgSemester", avgSemester);
        req.setAttribute("terbaru", terbaru);
        req.setAttribute("chartData", chartData);

        req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
    }
}
