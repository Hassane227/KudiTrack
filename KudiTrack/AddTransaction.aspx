<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddTransaction.aspx.cs" Inherits="KudiTrack.AddTransaction" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ajouter Transaction - KudiTrack</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #0072ff, #00c6ff);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }

        .transaction-form {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 30px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #0072ff;
        }

        .form-control, .form-select {
            background-color: #fff;
            color: #000;
            border: 1px solid #ccc;
        }

        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }

        .btn-primary {
            background-color: #0072ff;
            border: none;
            font-weight: bold;
        }

        .btn-primary:hover {
            background-color: #005dc1;
        }

        .text-danger {
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="transaction-form">
            <h2>Ajouter une transaction</h2>

            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

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
    </form>
</body>
</html>
