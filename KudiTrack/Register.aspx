<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="KudiTrack.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inscription - KudiTrack</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(-45deg, #00c6ff, #0072ff, #6a11cb, #2575fc);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .register-glass {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.3);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .register-glass h2 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .form-control {
            background-color: rgba(255, 255, 255, 0.15);
            border: none;
            color: white;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .form-control:focus {
            background-color: rgba(255, 255, 255, 0.2);
            box-shadow: none;
            border: none;
            color: white;
        }

        .btn-register {
            background-color: #ffffff;
            color: #0072ff;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-register:hover {
            background-color: #e0e0e0;
        }

        .login-link {
            color: #ffffff;
            display: block;
            text-align: center;
            margin-top: 15px;
            text-decoration: none;
        }

        .login-link:hover {
            text-decoration: underline;
        }

        .text-danger {
            text-align: center;
            display: block;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-glass">
            <h2>Inscription  KudiTrack</h2>

            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

            <div class="mb-3">
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Nom d'utilisateur" />
            </div>

            <div class="mb-3">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Adresse e-mail" />
            </div>

            <div class="mb-3">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Mot de passe" />
            </div>

            <div class="mb-3">
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirmer le mot de passe" />
            </div>

            <div class="d-grid">
                <asp:Button ID="btnRegister" runat="server" Text="S'inscrire" CssClass="btn btn-register" OnClick="btnRegister_Click" />
            </div>

            <asp:HyperLink ID="hlLogin" runat="server" NavigateUrl="Login.aspx" CssClass="login-link">
                Déjà un compte ? Connectez-vous
            </asp:HyperLink>
        </div>
    </form>
</body>
</html>
