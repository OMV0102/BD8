using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Odbc;

namespace BD8
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {



        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Перейти на другую Web-форму, сохранив состояние отображения.
            Server.Transfer("WebForm1.aspx", true);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            // Перейти на другую Web-форму, сохранив состояние отображения.
            Server.Transfer("WebForm2.aspx", true);
        }
    }
}