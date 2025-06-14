<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddTransaction.aspx.cs" Inherits="KudiTrack.AddTransaction" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ajouter Transaction - KudiTrack</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f2f5;
        }
        .sidebar {
            height: 100vh;
            width: 220px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #0d6efd; /* Couleur bleue Bootstrap */
            padding-top: 60px;
        }
        .sidebar .nav-link {
            color: white;
            font-size: 1.1rem;
            padding: 15px 20px;
            margin-bottom: 10px;
            display: block;
            transition: background-color 0.3s;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
        }
        .main-content {
            margin-left: 230px;
            padding: 30px 20px;
            min-height: 100vh;
        }
        .card {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-radius: 12px;
            background: white;
            max-width: 600px;
            margin: 0 auto;
            padding: 30px;
        }
        h2 {
            font-weight: 600;
            color: #0d6efd;
            margin-bottom: 25px;
            text-align: center;
        }
        .form-control, .form-select {
            background-color: #fff;
            color: #000;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .btn-primary {
            background-color: #0d6efd;
            border: none;
            font-weight: 600;
            padding: 10px 0;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0a58ca;
        }
        .text-danger {
            text-align: center;
            margin-bottom: 15px;
            font-weight: 600;
        }
        /* Position fixed for toast container */
        .toast-container {
            position: fixed;
            bottom: 1rem;
            right: 1rem;
            z-index: 1080;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
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
            <div class="card">
                <h2>Ajouter une transaction</h2>

                <asp:Label ID="lblMessage" runat="server" CssClass="text-success"></asp:Label>

                <div class="mb-3">
                    <label for="ddlType" class="form-label">Type</label>
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select">
                        <asp:ListItem Value="Revenu">Revenu</asp:ListItem>
                        <asp:ListItem Value="Dépense">Dépense</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label for="ddlCategory" class="form-label">Catégorie</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Sélectionner une catégorie" Value="" />
                    </asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label for="txtAmount" class="form-label">Montant</label>
                    <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" Placeholder="Ex : 1000"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label for="txtDescription" class="form-label">Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Placeholder="Description de la transaction..."></asp:TextBox>
                </div>

                <div class="d-grid">
                    <asp:Button ID="btnAdd" runat="server" Text="Ajouter" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                </div>
            </div>
        </div>

        <!-- Conteneur Toast Bootstrap -->
        <div class="toast-container" aria-live="polite" aria-atomic="true">
            <div id="budgetToast" class="toast align-items-center text-bg-warning border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body" id="toastBody">
                        <!-- Message dynamique injecté depuis code-behind -->
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Fermer"></button>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>
