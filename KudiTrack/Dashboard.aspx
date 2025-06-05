<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="KudiTrack.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard - KudiTrack</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: row;
            margin: 0;
            background-color: #f8f9fa;
        }

        .sidebar {
            width: 220px;
            background-color: #007bff;
            color: white;
            flex-shrink: 0;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 60px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }

        .sidebar .nav-link {
            font-weight: bold;
            font-size: 1.1rem;
            padding: 15px 20px;
            margin-bottom: 10px;
            color: #f8f9fa;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            cursor: pointer;
        }

        .sidebar .nav-link.active, 
        .sidebar .nav-link:hover {
            background-color: #495057;
            color: white;
        }

        .main-content {
            margin-left: 220px;
            padding: 60px 30px 30px 30px;
            flex-grow: 1;
            overflow-x: hidden;
        }

        .navbar {
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1050;
        }

        .navbar-brand {
            font-weight: 700;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
        <!-- Navbar -->
        <nav class="navbar navbar-dark bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">KudiTrack</a>
                <div class="d-flex align-items-center">
                    <asp:Label ID="lblUsername" runat="server" CssClass="text-white me-3"></asp:Label>
                    <a class="btn btn-outline-light btn-sm" href="Logout.aspx">Déconnexion</a>
                </div>
            </div>
        </nav>

        <!-- Sidebar -->
        <nav class="sidebar d-flex flex-column">
            <a class="nav-link active" href="Dashboard.aspx">🏠 Tableau de bord</a>
            <asp:Button ID="btnAddTransactionSidebar" runat="server" Text="➕ Ajouter transaction" CssClass="btn btn-link nav-link text-start" OnClick="btnAddTransaction_Click" />
            <a class="nav-link" href="ViewDepenses.aspx">💸 Mes Dépenses</a>
            <a class="nav-link" href="MesRevenus.aspx">💰 Mes Revenus</a>
            <a class="nav-link" href="Profil.aspx">👤 Mon Profil</a>
        </nav>

        <!-- Main Content -->
        <div class="main-content">
            <h1 class="mb-4 text-center fw-bold text-primary">Tableau de bord</h1>

            <div class="row g-4">
                <!-- Solde -->
                <div class="col-md-4">
                    <div class="card text-white bg-success shadow rounded-4" style="min-height: 220px;">
                        <div class="card-body d-flex flex-column justify-content-center text-center">
                            <h5 class="card-title fs-4">Solde actuel</h5>
                            <h2 class="display-6 fw-bold">
                                <asp:Label ID="lblBalance" runat="server" Text="0"></asp:Label> FCFA
                            </h2>
                        </div>
                    </div>
                </div>

                <!-- Total Revenus -->
                <div class="col-md-4">
                    <div class="card text-white bg-info shadow rounded-4" style="min-height: 220px;">
                        <div class="card-body d-flex flex-column justify-content-center text-center">
                            <h5 class="card-title fs-4">Total Revenus</h5>
                            <h2 class="display-6 fw-bold">
                                <asp:Label ID="lblTotalIncome" runat="server" Text="0"></asp:Label> FCFA
                            </h2>
                        </div>
                    </div>
                </div>

                <!-- Total Dépenses -->
                <div class="col-md-4">
                    <div class="card text-white bg-danger shadow rounded-4" style="min-height: 220px;">
                        <div class="card-body d-flex flex-column justify-content-center text-center">
                            <h5 class="card-title fs-4">Total Dépenses</h5>
                            <h2 class="display-6 fw-bold">
                                <asp:Label ID="lblTotalExpense" runat="server" Text="0"></asp:Label> FCFA
                            </h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Graphique dépenses vs revenus -->
            <div class="mt-5">
                <h3 class="text-center text-dark mb-3">📊 Revenus vs Dépenses par Mois</h3>
                <canvas id="financeChart" height="100"></canvas>
            </div>
        </div>

        <!-- JS Bootstrap + Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <script type="text/javascript">
            window.onload = function () {
                const ctx = document.getElementById('financeChart').getContext('2d');

                fetch('Dashboard.aspx/GetMonthlyFinanceData', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8'
                    },
                    body: '{}' // POST with empty body
                })
                    .then(response => response.json())
                    .then(data => {
                        // data.d contient la chaîne JSON retournée par le WebMethod
                        const parsed = JSON.parse(data.d);

                        new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'],
                                datasets: [
                                    {
                                        label: 'Revenus',
                                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
                                        borderColor: 'rgba(75, 192, 192, 1)',
                                        borderWidth: 1,
                                        data: parsed.revenus
                                    },
                                    {
                                        label: 'Dépenses',
                                        backgroundColor: 'rgba(255, 99, 132, 0.6)',
                                        borderColor: 'rgba(255, 99, 132, 1)',
                                        borderWidth: 1,
                                        data: parsed.depenses
                                    }
                                ]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    title: {
                                        display: true,
                                        text: 'Revenus et Dépenses Mensuels'
                                    }
                                },
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            callback: function (value) {
                                                return value + ' FCFA';
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    })
                    .catch(err => {
                        console.error("Erreur lors de la récupération des données : ", err);
                    });
            };
        </script>
    </form>
</body>
</html>
