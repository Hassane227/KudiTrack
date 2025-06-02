<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="KudiTrack.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Connexion - KudiTrack</title>
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

        .login-glass {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.3);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .login-glass h2 {
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

        .btn-login {
            background-color: #ffffff;
            color: #0072ff;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-login:hover {
            background-color: #e0e0e0;
        }

        .register-link {
            color: #ffffff;
            display: block;
            text-align: center;
            margin-top: 15px;
            text-decoration: none;
        }

        .register-link:hover {
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
        <div class="login-glass">
            <h2>Connexion KudiTrack</h2>

            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

            <div class="mb-3">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Adresse e-mail" />
            </div>

            <div class="mb-3">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Mot de passe" />
            </div>

            <div class="d-grid">
                <asp:Button ID="btnLogin" runat="server" Text="Se connecter" CssClass="btn btn-login" OnClick="btnLogin_Click" />
            </div>

            <asp:HyperLink ID="hlRegister" runat="server" NavigateUrl="Register.aspx" CssClass="register-link">
                Pas encore de compte ? Inscrivez-vous
            </asp:HyperLink>
        </div>
    </form>
</body>
</html>
