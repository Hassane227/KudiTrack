using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace KudiTrack
{
    public partial class ViewDepenses : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KudiTrackConnectionString"].ConnectionString;

        int currentUserId; // à remplacer dynamiquement avec l’ID utilisateur connecté

        protected void Page_Load(object sender, EventArgs e)

        {

            if (Session["UserId"] != null)
            {
                int.TryParse(Session["UserId"].ToString(), out currentUserId);
            }
            if (!IsPostBack)
            {
                ChargerDepenses();
            }
        }

        private void ChargerDepenses()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT T.TransactionId, C.Name AS CategoryName, T.Amount, T.Description, T.TransactionDate
                    FROM Transactions T
                    INNER JOIN Categories C ON T.CategoryId = C.CategoryId
                    WHERE T.Type = 'Dépense' AND T.UserId = @UserId
                    ORDER BY T.TransactionDate DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", currentUserId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvDepenses.DataSource = dt;
                gvDepenses.DataBind();
            }
        }

        protected void gvDepenses_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvDepenses.EditIndex = e.NewEditIndex;
            ChargerDepenses();
        }

        protected void gvDepenses_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvDepenses.EditIndex = -1;
            ChargerDepenses();
        }

        protected void gvDepenses_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            int transactionId = Convert.ToInt32(gvDepenses.DataKeys[e.RowIndex].Value);
            string categoryName = ((System.Web.UI.WebControls.TextBox)gvDepenses.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            decimal amount = Convert.ToDecimal(((System.Web.UI.WebControls.TextBox)gvDepenses.Rows[e.RowIndex].Cells[2].Controls[0]).Text);
            string description = ((System.Web.UI.WebControls.TextBox)gvDepenses.Rows[e.RowIndex].Cells[3].Controls[0]).Text;

            int categoryId = GetCategoryIdByName(categoryName);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Transactions SET CategoryId = @CategoryId, Amount = @Amount, Description = @Description WHERE TransactionId = @TransactionId AND UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                cmd.Parameters.AddWithValue("@Amount", amount);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@TransactionId", transactionId);
                cmd.Parameters.AddWithValue("@UserId", currentUserId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            gvDepenses.EditIndex = -1;
            ChargerDepenses();
        }

        protected void gvDepenses_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int transactionId = Convert.ToInt32(gvDepenses.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Transactions WHERE TransactionId = @TransactionId AND UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TransactionId", transactionId);
                cmd.Parameters.AddWithValue("@UserId", currentUserId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            ChargerDepenses();
        }

        private int GetCategoryIdByName(string categoryName)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT CategoryId FROM Categories WHERE Name = @Name";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Name", categoryName);

                conn.Open();
                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToInt32(result) : 0;
            }
        }
    }
}
