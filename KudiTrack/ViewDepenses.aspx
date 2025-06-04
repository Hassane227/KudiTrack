<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewDepenses.aspx.cs" Inherits="KudiTrack.ViewDepenses" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mes Dépenses | KudiTrack</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f0f2f5;
        }
        .card {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            font-weight: 600;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container my-5">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h2 class="text-center m-0">📊 Mes Dépenses</h2>
                        </div>
                        <div class="card-body">
                            <asp:GridView ID="gvDepenses" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="TransactionId"
                                CssClass="table table-hover"
                                GridLines="None"
                                OnRowEditing="gvDepenses_RowEditing"
                                OnRowCancelingEdit="gvDepenses_RowCancelingEdit"
                                OnRowUpdating="gvDepenses_RowUpdating"
                                OnRowDeleting="gvDepenses_RowDeleting">

                                <Columns>
                                    <asp:BoundField DataField="TransactionId" HeaderText="ID" ReadOnly="True" />
                                    <asp:BoundField DataField="CategoryName" HeaderText="Catégorie" />
                                    <asp:BoundField DataField="Amount" HeaderText="Montant (FCFA)" DataFormatString="{0:N2}" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" />
                                    <asp:BoundField DataField="TransactionDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" />

                                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" 
                                        EditText='<i class="btn btn-sm btn-warning">✏️ Modifier</i>' 
                                        DeleteText='<i class="btn btn-sm btn-danger">🗑️ Supprimer</i>' 
                                        CancelText='<i class="btn btn-sm btn-secondary">❌ Annuler</i>' 
                                        UpdateText='<i class="btn btn-sm btn-success">💾 Enregistrer</i>' />
                                </Columns>
                            </asp:GridView>

                            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold"></asp:Label>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
