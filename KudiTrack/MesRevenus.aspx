<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MesRevenus.aspx.cs" Inherits="KudiTrack.MesRevenus" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mes Revenus | KudiTrack</title>
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
            padding: 20px;
        }
        .table th, .table td {
            vertical-align: middle !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="sidebar">
            <a class="nav-link" href="Dashboard.aspx">🏠 Dashboard</a>
            <a class="nav-link" href="AddTransaction.aspx">➕ Ajouter Transaction</a>
            <a class="nav-link" href="MesDepenses.aspx">💸 Mes Dépenses</a>
            <a class="nav-link active" href="MesRevenus.aspx">💰 Mes Revenus</a>
            <a class="nav-link" href="Logout.aspx">🚪 Déconnexion</a>
        </div>

        <!-- Contenu principal -->
        <div class="main-content">
            <div class="container my-4">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h2 class="text-center m-0">💰 Mes Revenus</h2>
                    </div>
                    <div class="card-body">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-success fw-bold"></asp:Label>

                        <asp:GridView ID="gvRevenus" runat="server" CssClass="table table-hover mt-3"
                            AutoGenerateColumns="False" EmptyDataText="Aucun revenu trouvé." DataKeyNames="TransactionId"
                            OnRowEditing="gvRevenus_RowEditing"
                            OnRowCancelingEdit="gvRevenus_RowCancelingEdit"
                            OnRowUpdating="gvRevenus_RowUpdating"
                            OnRowDeleting="gvRevenus_RowDeleting">

                            <Columns>
                                <asp:BoundField DataField="TransactionId" HeaderText="ID" ReadOnly="True" />
                                <asp:BoundField DataField="TransactionDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField DataField="Description" HeaderText="Description" />
                                <asp:BoundField DataField="Amount" HeaderText="Montant (FCFA)" DataFormatString="{0:N2}" />

                                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"
                                    EditText='<i class="btn btn-sm btn-warning">✏️ Modifier</i>'
                                    DeleteText='<i class="btn btn-sm btn-danger">🗑️ Supprimer</i>'
                                    CancelText='<i class="btn btn-sm btn-secondary">❌ Annuler</i>'
                                    UpdateText='<i class="btn btn-sm btn-success">💾 Enregistrer</i>' />
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
