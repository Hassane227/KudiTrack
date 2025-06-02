using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace KudiTrack
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["KudiTrackConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblUsername.Text = "Bonjour, " + Session["Username"].ToString();
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Charger les transactions
                SqlCommand cmd = new SqlCommand("SELECT TransactionDate AS Date, Description, Amount, Type FROM Transactions WHERE UserId = @UserId ORDER BY TransactionDate DESC", con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvTransactions.DataSource = dt;
                gvTransactions.DataBind();

                // Calculer total revenus et dépenses
                SqlCommand cmdIncome = new SqlCommand("SELECT ISNULL(SUM(Amount),0) FROM Transactions WHERE UserId = @UserId AND Type = 'Revenu'", con);
                cmdIncome.Parameters.AddWithValue("@UserId", userId);
                decimal totalIncome = (decimal)cmdIncome.ExecuteScalar();

                SqlCommand cmdExpense = new SqlCommand("SELECT ISNULL(SUM(Amount),0) FROM Transactions WHERE UserId = @UserId AND Type = 'Dépense'", con);
                cmdExpense.Parameters.AddWithValue("@UserId", userId);
                decimal totalExpense = (decimal)cmdExpense.ExecuteScalar();

                lblTotalIncome.Text = totalIncome.ToString("N0");
                lblTotalExpense.Text = totalExpense.ToString("N0");

                decimal balance = totalIncome - totalExpense;
                lblBalance.Text = balance.ToString("N0");
            }
        }

        protected void btnAddTransaction_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddTransaction.aspx");
        }
    }
}
