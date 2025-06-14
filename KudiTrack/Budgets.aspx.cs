using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace KudiTrack
{
    public partial class Budgets : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KudiTrackConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerCategories();
                ChargerBudgets();
            }
        }

        private void ChargerCategories()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT CategoryId, Name FROM Categories";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlCategorie.DataSource = reader;
                ddlCategorie.DataTextField = "Name";
                ddlCategorie.DataValueField = "CategoryId";
                ddlCategorie.DataBind();
                con.Close();
            }
        }

        private void ChargerBudgets()
        {
            if (Session["UserId"] == null) return;

            int userId = (int)Session["UserId"];

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT B.BudgetId, C.Name AS NomCategorie, B.MontantMax, B.Mois, B.Annee
            FROM Budgets B
            INNER JOIN Categories C ON B.CategoryId = C.CategoryId
            WHERE B.UserId = @UserId
            ORDER BY B.Annee DESC, B.Mois DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvBudgets.DataSource = dt;
                gvBudgets.DataBind();
            }
        }


        protected void btnEnregistrer_Click(object sender, EventArgs e)
        {
            try
            {
                // Récupérer UserId depuis la session
                if (Session["UserId"] == null)
                {
                    lblMessage.Text = "❌ Veuillez vous connecter.";
                    lblMessage.CssClass = "text-danger fw-bold";
                    return;
                }

                int userId = (int)Session["UserId"];
                int categorieId = int.Parse(ddlCategorie.SelectedValue);
                decimal montant = decimal.Parse(txtMontantMax.Text);
                int mois = int.Parse(txtMois.Text);
                int annee = int.Parse(txtAnnee.Text);

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"
                INSERT INTO Budgets (UserId, CategoryId, MontantMax, Mois, Annee)
                VALUES (@UserId, @CategorieId, @MontantMax, @Mois, @Annee)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@CategorieId", categorieId);
                    cmd.Parameters.AddWithValue("@MontantMax", montant);
                    cmd.Parameters.AddWithValue("@Mois", mois);
                    cmd.Parameters.AddWithValue("@Annee", annee);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                lblMessage.Text = "✅ Budget enregistré avec succès.";
                lblMessage.CssClass = "text-success fw-bold";

                txtMontantMax.Text = "";
                txtMois.Text = "";
                txtAnnee.Text = "";

                ChargerBudgets(); // Charge uniquement les budgets de l'utilisateur (à adapter)
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Erreur : " + ex.Message;
                lblMessage.CssClass = "text-danger fw-bold";
            }
        }


    }
}
