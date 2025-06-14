<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Budgets.aspx.cs" Inherits="KudiTrack.Budgets" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mes Budgets | KudiTrack</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            font-weight: 600;
        }
        .sidebar {
            height: 100vh;
            width: 220px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #0d6efd;
            padding-top: 60px;
        }
        .sidebar .nav-link {
            color: white;
             font-size: 1.1rem;
             padding: 15px 20px;
             margin-bottom: 10px;
             display: block;
             transition: background-color 0.3s;

             color: #f8f9fa;
             border-radius: 5px;
             transition: background-color 0.3s ease;
             cursor: pointer;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
        }
        .main-content {
            margin-left: 230px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Barre latérale -->
        <div class="sidebar">
        <a class="nav-link active" href="Dashboard.aspx">🏠 Tableau de bord</a>
        <a class="nav-link" href="AddTransaction.aspx">➕ Ajouter Transaction</a>

        <a class="nav-link" href="ViewDepenses.aspx">💸 Mes Dépenses</a>
        <a class="nav-link" href="MesRevenus.aspx">💰 Mes Revenus</a>
        <a class="nav-link" href="Budgets.aspx">💰 Mes Budgets</a>

        <a class="nav-link" href="Profil.aspx">👤 Mon Profil</a>
        </div>

        <!-- Contenu principal -->
        <div class="main-content">
            <div class="container my-4">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h2 class="text-center m-0">📊 Définir un Budget</h2>
                    </div>
                    <div class="card-body">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-success fw-bold"></asp:Label>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Catégorie</label>
                                <asp:DropDownList ID="ddlCategorie" runat="server" CssClass="form-select" />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Montant Max (FCFA)</label>
                                <asp:TextBox ID="txtMontantMax" runat="server" CssClass="form-control" TextMode="Number" />
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Mois</label>
                                <asp:TextBox ID="txtMois" runat="server" CssClass="form-control" Text="6" />
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Année</label>
                                <asp:TextBox ID="txtAnnee" runat="server" CssClass="form-control" Text="2025" />
                            </div>
                            <div class="col-md-1 d-flex align-items-end">
                                <asp:Button ID="btnEnregistrer" runat="server" Text="💾" CssClass="btn btn-success" OnClick="btnEnregistrer_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tableau des budgets -->
                <div class="card">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="m-0">Liste des Budgets</h5>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvBudgets" runat="server" CssClass="table table-hover"
                            AutoGenerateColumns="False" EmptyDataText="Aucun budget défini." DataKeyNames="BudgetId">
                            <Columns>
                                <asp:BoundField DataField="NomCategorie" HeaderText="Catégorie" />
                                <asp:BoundField DataField="MontantMax" HeaderText="Montant Max (FCFA)" DataFormatString="{0:N2}" />
                                <asp:BoundField DataField="Mois" HeaderText="Mois" />
                                <asp:BoundField DataField="Annee" HeaderText="Année" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>
