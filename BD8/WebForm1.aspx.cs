using System;
using System.Collections.Generic;
using System.Data.Odbc;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace BD8
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            OdbcConnection conn = new OdbcConnection(); // Создаем объект подключения
            conn.ConnectionString = "Dsn=PostgreSQL16"; // Задаем параметр подключения – имя ODBC-источника
            conn.Open(); // Подключаемся к БД


            //======================================================================================================================
            // Определяем строку с текстом запроса
            string strSQL = "SELECT COUNT(n_det) FROM pmib6602.p";
            // Создаем объект запроса
            OdbcCommand cmd = new OdbcCommand(strSQL, conn);
            // Создаем первый параметр
            /*OdbcParameter par_name = new OdbcParameter();
            par_name.ParameterName = "@vname";
            par_name.OdbcType = OdbcType.Text;
            par_name.Value = "Кулер";
            // Добавляем первый параметр в коллекцию
            cmd.Parameters.Add(par_name);
            // Создаем второй параметр
            OdbcParameter par_town = new OdbcParameter();
            par_town.ParameterName = "@vn_det";
            par_town.OdbcType = OdbcType.Text;
            par_town.Value = "P3";
            // Добавляем второй параметр в коллекцию.
            cmd.Parameters.Add(par_town);*/
            // Объявляем объект транзакции
            OdbcTransaction tx = null;
            try
            {
                // Начинаем транзакцию и извлекаем объект транзакции из объекта подключения.
                tx = conn.BeginTransaction();
                // Включаем объект SQL-команды в транзакцию
                cmd.Transaction = tx;
                // Выполняем SQL-команду и получаем количество обработанных записей
                //int i = cmd.ExecuteNonQuery();
                string str = cmd.ExecuteScalar().ToString();
                TextBox2.Text = str;
                // Подтверждаем транзакцию  
                tx.Commit();
            }
            catch (Exception ex)
            {
                // При возникновении любой ошибки 
                // Формируем сообщение об ошибке 
                Label4.Text = ex.Message;
                // выполняем откат транзакции 
                tx.Rollback();
            }
            
            //закрываем соединение
            conn.Close();

            //======================================================================================================================

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}