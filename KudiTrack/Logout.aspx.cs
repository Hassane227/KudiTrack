using System;
using System.Web;
using System.Web.UI;

namespace KudiTrack
{
    public partial class Logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Supprimer toutes les données de session
            Session.Clear();
            Session.Abandon();

            // Rediriger vers la page de connexion
            Response.Redirect("Login.aspx");
        }
    }
}
