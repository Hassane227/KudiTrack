using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace KudiTrack
{
    public partial class AddTransaction : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["KudiTrackConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT CategoryId, Name FROM Categories";
                SqlCommand cmd = new SqlCommand(query, con);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlCategory.DataSource = reader;
                ddlCategory.DataTextField = "Name";
                ddlCategory.DataValueField = "CategoryId";
                ddlCategory.DataBind();

                ddlCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Sélectionnez--", "0"));
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Valider la saisie
            if (ddlCategory.SelectedValue == "0")
            {
                lblMessage.Text = "Veuillez sélectionner une catégorie.";
                return;
            }

            if (!decimal.TryParse(txtAmount.Text.Trim(), out decimal amount) || amount <= 0)
            {
                lblMessage.Text = "Veuillez entrer un montant valide supérieur à zéro.";
                return;
            }

            int userId = 0;
            if (Session["UserId"] != null)
            {
                int.TryParse(Session["UserId"].ToString(), out userId);
            }
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Transactions (UserId, CategoryId, Type, Amount, Description, TransactionDate) " +
                               "VALUES (@UserId, @CategoryId, @Type, @Amount, @Description, @TransactionDate)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@CategoryId", int.Parse(ddlCategory.SelectedValue));
                cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
                cmd.Parameters.AddWithValue("@Amount", amount);
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@TransactionDate", DateTime.Now);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "Transaction ajoutée avec succès !";

            // Réinitialiser le formulaire
            ddlType.SelectedIndex = 0;
            ddlCategory.SelectedIndex = 0;
            txtAmount.Text = "";
            txtDescription.Text = "";
        }
    }
}
