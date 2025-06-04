<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="KudiTrack.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard - KudiTrack</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: row;
            margin: 0;
            background-color: #f8f9fa;
        }
        /* Sidebar styling */
        .sidebar {
            width: 220px;
            background-color: #007bff;
            color: white;
            flex-shrink: 0;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 60px; /* for navbar space */
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar .nav-link {
            color:  #fff;
            font-weight: 500;

             font-size: 1.1rem;         /* ✅ Taille du texte (ex: 1.1rem ≈ 17.6px) */
            padding: 15px 20px;        /* ✅ Espacement intérieur : haut/bas = 15px, gauche/droite = 20px */
            margin-bottom: 10px;       /* ✅ Espacement entre les liens */
            color: #f8f9fa;
            border-radius: 5px;
    transition: background-color 0.3s ease;
        }
        .sidebar .nav-link.active, 
        .sidebar .nav-link:hover {
            background-color: #495057;
            color: white;
        }

        /* Main content */
        .main-content {
            margin-left: 220px;
            padding: 60px 30px 30px 30px; /* padding top for navbar */
            flex-grow: 1;
            overflow-x: hidden;
        }
        /* Navbar overrides */
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
            <a class="nav-link" href="AddTransaction.aspx">transaction</a>

            <a class="nav-link" href="ViewDepenses.aspx">💸 Mes Dépenses</a>
            <a class="nav-link" href="ViewRevenus.aspx">💰 Mes Revenus</a>
            <a class="nav-link" href="Profile.aspx">👤 Mon Profil</a>
        </nav>

        <!-- Main Content -->
        <div class="main-content">
            <h1 class="mb-4">Tableau de bord</h1>

            <div class="row mb-4">
                <!-- Solde -->
                <div class="col-md-4 mb-3">
                    <div class="card text-white bg-success h-100">
                        <div class="card-body">
                            <h5 class="card-title">Solde actuel</h5>
                            <h2><asp:Label ID="lblBalance" runat="server" Text="0"></asp:Label> FCFA</h2>
                        </div>
                    </div>
                </div>

                <!-- Total Revenus -->
                <div class="col-md-4 mb-3">
                    <div class="card text-white bg-info h-100">
                        <div class="card-body">
                            <h5 class="card-title">Total Revenus</h5>
                            <h2><asp:Label ID="lblTotalIncome" runat="server" Text="0"></asp:Label> FCFA</h2>
                        </div>
                    </div>
                </div>

                <!-- Total Dépenses -->
                <div class="col-md-4 mb-3">
                    <div class="card text-white bg-danger h-100">
                        <div class="card-body">
                            <h5 class="card-title">Total Dépenses</h5>
                            <h2><asp:Label ID="lblTotalExpense" runat="server" Text="0"></asp:Label> FCFA</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Liste des transactions -->
            <asp:GridView ID="gvTransactions" runat="server" CssClass="table table-striped table-hover"
                AutoGenerateColumns="False" EmptyDataText="Aucune transaction pour le moment.">
                <Columns>
                    <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="Amount" HeaderText="Montant (FCFA)" DataFormatString="{0:N0}" />
                    <asp:BoundField DataField="Type" HeaderText="Type" />
                </Columns>
            </asp:GridView>
        </div>

        <!-- Bootstrap JS Bundle CDN (Popper + Bootstrap JS) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>
