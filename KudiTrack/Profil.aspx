﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profil.aspx.cs" Inherits="KudiTrack.Profil" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profil - KudiTrack</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
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
    <form id="form1" runat="server" class="container-fluid">
        <!-- Sidebar -->
        <div class="sidebar">
            <a class="nav-link" href="Dashboard.aspx">🏠 Dashboard</a>
            <a class="nav-link" href="AddTransaction.aspx">➕ Ajouter Transaction</a>
            <a class="nav-link" href="MesDepenses.aspx">💸 Mes Dépenses</a>
            <a class="nav-link" href="MesRevenus.aspx">💰 Mes Revenus</a>
            <a class="nav-link active" href="Profil.aspx">👤 Mon Profil</a>
            <a class="nav-link" href="Logout.aspx">🚪 Déconnexion</a>
        </div>

        <!-- Contenu principal -->
        <div class="main-content">
            <h2>👤 Mon Profil</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-success mb-3"></asp:Label>

            <asp:Panel ID="pnlProfile" runat="server" CssClass="col-md-6">
                <div class="mb-3">
                    <label for="txtUsername" class="form-label">Nom d'utilisateur</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="txtEmail" class="form-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="txtPassword" class="form-label">Nouveau mot de passe</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Laisser vide pour ne pas changer"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="txtConfirmPassword" class="form-label">Confirmer mot de passe</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirmez le mot de passe"></asp:TextBox>
                </div>

                <asp:Button ID="btnSave" runat="server" Text="Enregistrer" CssClass="btn btn-primary" OnClick="btnSave_Click" />
            </asp:Panel>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>
