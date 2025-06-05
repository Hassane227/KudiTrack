using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace KudiTrack
{
    public partial class MesRevenus : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KudiTrackConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerRevenus();
            }
        }

        private void ChargerRevenus()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT TransactionId, Description, Amount, TransactionDate FROM Transactions WHERE UserId = @UserId AND Type = 'Revenu'";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRevenus.DataSource = dt;
                gvRevenus.DataBind();
            }
        }

        protected void gvRevenus_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvRevenus.EditIndex = e.NewEditIndex;
            ChargerRevenus();
        }

        protected void gvRevenus_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvRevenus.EditIndex = -1;
            ChargerRevenus();
        }

        protected void gvRevenus_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvRevenus.DataKeys[e.RowIndex].Value);
            string description = ((TextBox)gvRevenus.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            string amountText = ((TextBox)gvRevenus.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            decimal amount = decimal.Parse(amountText);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Transactions SET Description = @Description, Amount = @Amount WHERE TransactionId = @TransactionId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@Amount", amount);
                cmd.Parameters.AddWithValue("@TransactionId", id);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            gvRevenus.EditIndex = -1;
            ChargerRevenus();
            lblMessage.Text = "Revenu mis à jour avec succès.";
        }

        protected void gvRevenus_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvRevenus.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Transactions WHERE TransactionId = @TransactionId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TransactionId", id);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            ChargerRevenus();
            lblMessage.Text = "Revenu supprimé avec succès.";
        }
    }
}
