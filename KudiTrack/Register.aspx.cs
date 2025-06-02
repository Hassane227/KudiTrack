using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace KudiTrack
{
    public partial class Register : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["KudiTrackConnectionString"].ConnectionString;

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            // Validation simple
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Veuillez remplir tous les champs.";
                return;
            }

            if (password != confirmPassword)
            {
                lblMessage.Text = "Les mots de passe ne correspondent pas.";
                return;
            }

            if (IsEmailExists(email))
            {
                lblMessage.Text = "Cet email est déjà utilisé.";
                return;
            }

            // Hasher le mot de passe
            string hashedPassword = ComputeSha256Hash(password);

            // Insérer en base
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Users (Username, Email, PasswordHash, CreatedAt) VALUES (@Username, @Email, @PasswordHash, @CreatedAt)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                cmd.Parameters.AddWithValue("@CreatedAt", DateTime.Now);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "Inscription réussie ! Vous pouvez maintenant vous connecter.";
            ClearForm();
        }

        private bool IsEmailExists(string email)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }

        private string ComputeSha256Hash(string rawData)
        {
            // Create a SHA256   
            using (SHA256 sha256Hash = SHA256.Create())
            {
                // ComputeHash - returns byte array  
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));

                // Convert byte array to a string   
                StringBuilder builder = new StringBuilder();
                foreach (var b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private void ClearForm()
        {
            txtUsername.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
        }
    }
}
