<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Mahasiswa" %>

<%
    int total = (int) request.getAttribute("total");
    int totalProdi = (int) request.getAttribute("totalProdi");
    double avgSemester = (double) request.getAttribute("avgSemester");

    List<Mahasiswa> terbaru = (List<Mahasiswa>) request.getAttribute("terbaru");
    Map<String, Long> chartData = (Map<String, Long>) request.getAttribute("chartData");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard SIAKAD</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="bg-gray-100 p-10">

<div class="bg-white shadow mb-10 rounded-lg">
    <div class="p-4 flex justify-between items-center">

        <div class="flex items-center gap-6">
            
            <a href="dashboard" 
               class="text-indigo-600 font-semibold hover:text-indigo-800">
                Dashboard
            </a>

            <a href="mhs-list" 
               class="text-gray-600 font-semibold hover:text-indigo-600">
                Tabel Mahasiswa
            </a>
        </div>

        <div class="flex items-center gap-4">

            <form action="mhs-list" method="get">
                <input type="text" name="search"
                       placeholder="Cari nama / NIM..."
                       class="px-4 py-2 border rounded-lg shadow-sm focus:ring-indigo-500">
            </form>

            <form action="dashboard" method="get">
                <select name="prodi"
                        class="px-4 py-2 border rounded-lg shadow-sm bg-gray-50">
                    <option value="">Semua Prodi</option>
                    <option>Informatika</option>
                    <option>Sistem Informasi</option>
                    <option>Teknik Komputer</option>
                    <option>Data Science</option>
                    <option>Teknik Elektro</option>
                </select>
            </form>

            <form action="dashboard" method="get">
                <select name="semester"
                        class="px-4 py-2 border rounded-lg shadow-sm bg-gray-50">
                    <option value="">Semester</option>
                    <option>1</option><option>2</option><option>3</option>
                    <option>4</option><option>5</option><option>6</option>
                    <option>7</option><option>8</option>
                </select>
            </form>

            <form action="dashboard" method="get">
                <select name="jurusan"
                        class="px-4 py-2 border rounded-lg shadow-sm bg-gray-50">
                    <option value="">Semua Jurusan</option>
                    <option>FTIK</option>
                    <option>FTEIC</option>
                    <option>FMIPA</option>
                </select>
            </form>

        </div>

    </div>
</div>

<h1 class="text-3xl font-bold mb-8">Dashboard SIAKAD</h1>

<div class="grid grid-cols-3 gap-6 mb-10">

    <div class="bg-white p-6 shadow rounded-lg">
        <h2 class="text-gray-600 font-semibold">Total Mahasiswa</h2>
        <p class="text-4xl font-bold text-indigo-600"><%= total %></p>
    </div>

    <div class="bg-white p-6 shadow rounded-lg">
        <h2 class="text-gray-600 font-semibold">Total Prodi</h2>
        <p class="text-4xl font-bold text-blue-600"><%= totalProdi %></p>
    </div>

    <div class="bg-white p-6 shadow rounded-lg">
        <h2 class="text-gray-600 font-semibold">Rata-rata Semester</h2>
        <p class="text-4xl font-bold text-green-600"><%= String.format("%.2f", avgSemester) %></p>
    </div>

</div>

<div class="grid grid-cols-2 gap-10 mb-10">

    <div class="bg-white p-6 shadow rounded-lg">
        <h3 class="text-xl font-semibold mb-4">Mahasiswa per Prodi</h3>
        <canvas id="barChart"></canvas>
    </div>

    <div class="bg-white p-6 shadow rounded-lg">
        <h3 class="text-xl font-semibold mb-4">Persentase Prodi</h3>
        <canvas id="pieChart"></canvas>
    </div>

</div>

<div class="bg-white p-6 shadow rounded-lg">
    <h3 class="text-xl font-semibold mb-4">5 Mahasiswa Terbaru</h3>

    <table class="w-full">
        <tr class="bg-gray-200 text-left">
            <th class="p-3">NIM</th>
            <th class="p-3">Nama</th>
            <th class="p-3">Prodi</th>
            <th class="p-3">Semester</th>
        </tr>

        <%
            for (Mahasiswa m : terbaru) {
        %>
        <tr class="border">
            <td class="p-3"><%= m.getNim() %></td>
            <td class="p-3"><%= m.getNama() %></td>
            <td class="p-3"><%= m.getProdi() %></td>
            <td class="p-3"><%= m.getSemester() %></td>
        </tr>
        <% } %>

    </table>
</div>


<script>
    const labels = [
        <% for (String prodi : chartData.keySet()) { %>
            "<%= prodi %>",
        <% } %>
    ];

    const values = [
        <% for (Long count : chartData.values()) { %>
            <%= count %>,
        <% } %>
    ];

    new Chart(document.getElementById('barChart'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: "Jumlah Mahasiswa",
                data: values,
                backgroundColor: "rgba(99, 102, 241, 0.7)"
            }]
        }
    });

    new Chart(document.getElementById('pieChart'), {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: values,
                backgroundColor: [
                    "#6366F1", "#EC4899", "#10B981", "#F59E0B", "#3B82F6"
                ]
            }]
        }
    });
</script>

</body>
</html>
