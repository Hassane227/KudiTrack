using System;
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
                var reader = cmd.ExecuteReader();
                ddlCategory.DataSource = reader;
                ddlCategory.DataTextField = "Name";
                ddlCategory.DataValueField = "CategoryId";
                ddlCategory.DataBind();

                ddlCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Sélectionnez--", "0"));
            }
        }

        // Méthode pour formater les montants en FCFA
        private string FormatFcfa(decimal montant)
        {
            // Formate avec séparateur de milliers et ajoute " FCFA"
            return string.Format("{0:N0} FCFA", montant);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            if (ddlCategory.SelectedValue == "0")
            {
                lblMessage.Text = "Veuillez sélectionner une catégorie.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (!decimal.TryParse(txtAmount.Text.Trim(), out decimal amount) || amount <= 0)
            {
                lblMessage.Text = "Veuillez entrer un montant valide supérieur à zéro.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (Session["UserId"] == null || Session["Email"] == null)
            {
                lblMessage.Text = "Session utilisateur expirée. Veuillez vous reconnecter.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int userId = (int)Session["UserId"];
            int categoryId = int.Parse(ddlCategory.SelectedValue);
            string type = ddlType.SelectedValue; // "Revenu" ou "Dépense"

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Ajouter la transaction
                string insertQuery = "INSERT INTO Transactions (UserId, CategoryId, Type, Amount, Description, TransactionDate) " +
                                     "VALUES (@UserId, @CategoryId, @Type, @Amount, @Description, @TransactionDate)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                insertCmd.Parameters.AddWithValue("@UserId", userId);
                insertCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                insertCmd.Parameters.AddWithValue("@Type", type);
                insertCmd.Parameters.AddWithValue("@Amount", amount);
                insertCmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                insertCmd.Parameters.AddWithValue("@TransactionDate", DateTime.Now);
                insertCmd.ExecuteNonQuery();

                // Vérifier le budget si dépense
                if (type == "Dépense")
                {
                    int mois = DateTime.Now.Month;
                    int annee = DateTime.Now.Year;

                    string budgetQuery = @"SELECT MontantMax FROM Budgets 
                                           WHERE CategoryId = @CategoryId AND Mois = @Mois AND Annee = @Annee";
                    SqlCommand budgetCmd = new SqlCommand(budgetQuery, con);
                    budgetCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                    budgetCmd.Parameters.AddWithValue("@Mois", mois);
                    budgetCmd.Parameters.AddWithValue("@Annee", annee);

                    object result = budgetCmd.ExecuteScalar();
                    if (result != null)
                    {
                        decimal budgetMax = Convert.ToDecimal(result);

                        string sumQuery = @"SELECT ISNULL(SUM(Amount), 0) FROM Transactions 
                                            WHERE UserId = @UserId AND CategoryId = @CategoryId AND Type = 'Dépense' 
                                            AND MONTH(TransactionDate) = @Mois AND YEAR(TransactionDate) = @Annee";
                        SqlCommand sumCmd = new SqlCommand(sumQuery, con);
                        sumCmd.Parameters.AddWithValue("@UserId", userId);
                        sumCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                        sumCmd.Parameters.AddWithValue("@Mois", mois);
                        sumCmd.Parameters.AddWithValue("@Annee", annee);

                        decimal totalDepense = (decimal)sumCmd.ExecuteScalar();

                        if (totalDepense > budgetMax)
                        {
                            // Format FCFA pour le message
                            string budgetFcfa = FormatFcfa(budgetMax);
                            string depenseFcfa = FormatFcfa(totalDepense);
                            string categorie = ddlCategory.SelectedItem.Text;

                            string messageToast = $"Attention, vous avez dépassé votre budget pour la catégorie {categorie} ! Budget : {budgetFcfa}, Dépenses : {depenseFcfa}";

                            // Injection du script JS pour afficher le toast Bootstrap
                            string script = $@"
                                <script>
                                document.addEventListener('DOMContentLoaded', function () {{
                                    var toastEl = document.getElementById('budgetToast');
                                    var toast = new bootstrap.Toast(toastEl);
                                    document.getElementById('toastBody').innerText = '{messageToast}';
                                    toast.show();
                                }});
                                </script>";

                            ClientScript.RegisterStartupScript(this.GetType(), "ShowBudgetToast", script);
                        }
                    }
                }

                con.Close();
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
