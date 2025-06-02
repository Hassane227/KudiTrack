<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="KudiTrack.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard - KudiTrack</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            padding-top: 60px;
        }
        .card {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">KudiTrack</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <asp:Label ID="lblUsername" runat="server" CssClass="navbar-text text-white me-3"></asp:Label>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Logout.aspx">Déconnexion</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <h1 class="mb-4">Tableau de bord</h1>

            <div class="row">
                <!-- Solde -->
                <div class="col-md-4">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <h5 class="card-title">Solde actuel</h5>
                            <h2><asp:Label ID="lblBalance" runat="server" Text="0"></asp:Label> FCFA</h2>
                        </div>
                    </div>
                </div>

                <!-- Total Revenus -->
                <div class="col-md-4">
                    <div class="card text-white bg-info">
                        <div class="card-body">
                            <h5 class="card-title">Total Revenus</h5>
                            <h2><asp:Label ID="lblTotalIncome" runat="server" Text="0"></asp:Label> FCFA</h2>
                        </div>
                    </div>
                </div>

                <!-- Total Dépenses -->
                <div class="col-md-4">
                    <div class="card text-white bg-danger">
                        <div class="card-body">
                            <h5 class="card-title">Total Dépenses</h5>
                            <h2><asp:Label ID="lblTotalExpense" runat="server" Text="0"></asp:Label> FCFA</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bouton Ajouter Transaction -->
            <div class="mb-3 text-end">
                <asp:Button ID="btnAddTransaction" runat="server" Text="Ajouter une transaction" CssClass="btn btn-primary" OnClick="btnAddTransaction_Click" />
            </div>

            <!-- Liste des transactions -->
            <asp:GridView ID="gvTransactions" runat="server" CssClass="table table-striped"
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
