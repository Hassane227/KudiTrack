using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace KudiTrack
{
    public partial class Profil : Page
    {
        // Connection string dans le web.config (à adapter selon ta config)
        private string connectionString = ConfigurationManager.ConnectionStrings["KudiTrackConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            // Exemple : récupérer l'utilisateur connecté via la session
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = (int)Session["UserId"];

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Username, Email FROM Users WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtUsername.Text = reader["Username"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    lblMessage.CssClass = "text-danger";
                    lblMessage.Text = "Erreur lors du chargement du profil : " + ex.Message;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = (int)Session["UserId"];
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (password != confirmPassword)
            {
                lblMessage.CssClass = "text-danger";
                lblMessage.Text = "Les mots de passe ne correspondent pas.";
                return;
            }

            // Mettre à jour le profil dans la base
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query;
                if (string.IsNullOrEmpty(password))
                {
                    // Pas de changement de mot de passe
                    query = "UPDATE Users SET Email = @Email WHERE UserId = @UserId";
                }
                else
                {
                    // Mettre à jour email + mot de passe (hashé conseillé, ici simplifié)
                    query = "UPDATE Users SET Email = @Email, PasswordHash = @PasswordHash WHERE UserId = @UserId";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@UserId", userId);

                if (!string.IsNullOrEmpty(password))
                {
                    // Pour un vrai projet, hasher le mot de passe avant de stocker !
                    cmd.Parameters.AddWithValue("@PasswordHash", password);
                }

                try
                {
                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblMessage.CssClass = "text-success";
                        lblMessage.Text = "Profil mis à jour avec succès.";
                        // Effacer les champs mot de passe
                        txtPassword.Text = "";
                        txtConfirmPassword.Text = "";
                    }
                    else
                    {
                        lblMessage.CssClass = "text-warning";
                        lblMessage.Text = "Aucune modification détectée.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.CssClass = "text-danger";
                    lblMessage.Text = "Erreur lors de la mise à jour : " + ex.Message;
                }
            }
        }
    }
}
