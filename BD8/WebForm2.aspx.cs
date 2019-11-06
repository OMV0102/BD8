using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Odbc;

namespace BD8
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            OdbcConnection conn = new OdbcConnection(); // Создаем объект подключения
            conn.ConnectionString = "Dsn=PostgreSQL16"; // Задаем параметр подключения – имя ODBC-источника
            conn.Open(); // Подключаемся к БД
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}