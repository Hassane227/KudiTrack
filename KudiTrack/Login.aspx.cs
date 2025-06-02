using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace KudiTrack
{
    public partial class Login : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["KudiTrackConnectionString"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Veuillez remplir tous les champs.";
                return;
            }

            string hashedPassword = ComputeSha256Hash(password);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT UserId, Username FROM Users WHERE Email = @Email AND PasswordHash = @PasswordHash";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    reader.Read();
                    int userId = reader.GetInt32(0);
                    string username = reader.GetString(1);

                    // Stocker les infos utilisateur dans la session
                    Session["UserId"] = userId;
                    Session["Username"] = username;

                    // Rediriger vers dashboard
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Email ou mot de passe incorrect.";
                }
            }
        }

        private string ComputeSha256Hash(string rawData)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                StringBuilder builder = new StringBuilder();
                foreach (var b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}
