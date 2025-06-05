using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;

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
                lblUsername.Text = "Bonjour, " + Session["Username"]?.ToString();
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

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

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetMonthlyFinanceData()
        {
            var data = new
            {
                revenus = new decimal[12],
                depenses = new decimal[12]
            };

            int userId = 0;
            if (System.Web.HttpContext.Current.Session["UserId"] != null)
                userId = (int)System.Web.HttpContext.Current.Session["UserId"];

            if (userId == 0)
                return new JavaScriptSerializer().Serialize(data);

            string connectionString = ConfigurationManager.ConnectionStrings["KudiTrackConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string sqlIncome = @"
                    SELECT MONTH(Date) AS Month, ISNULL(SUM(Amount),0) AS Total
                    FROM Transactions 
                    WHERE UserId = @UserId AND Type = 'Revenu' AND YEAR(Date) = YEAR(GETDATE())
                    GROUP BY MONTH(Date)";

                using (SqlCommand cmd = new SqlCommand(sqlIncome, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int month = Convert.ToInt32(reader["Month"]);
                            decimal total = Convert.ToDecimal(reader["Total"]);
                            data.revenus[month - 1] = total;
                        }
                    }
                }

                string sqlExpense = @"
                    SELECT MONTH(Date) AS Month, ISNULL(SUM(Amount),0) AS Total
                    FROM Transactions 
                    WHERE UserId = @UserId AND Type = 'Dépense' AND YEAR(Date) = YEAR(GETDATE())
                    GROUP BY MONTH(Date)";

                using (SqlCommand cmd = new SqlCommand(sqlExpense, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int month = Convert.ToInt32(reader["Month"]);
                            decimal total = Convert.ToDecimal(reader["Total"]);
                            data.depenses[month - 1] = total;
                        }
                    }
                }
            }

            return new JavaScriptSerializer().Serialize(data);
        }
    }
}
