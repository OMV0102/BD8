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
        OdbcConnection conn; //объект подключения
        //txtlog.Text += "\n";

        protected void Page_Load(object sender, EventArgs e)
        {
            txtlog.Text = "";
            // Создаем объект подключения
            txtlog.Text += "Создаем объект подключения\n";
            conn = new OdbcConnection();
            // Задаем параметр подключения – имя ODBC-источника
            txtlog.Text += "Задаем имя ODBC-источника\n";
            conn.ConnectionString = "Dsn=PostgreSQL16";
            // Подключаемся к БД
            txtlog.Text += "Подключаемся к БД\n";
            conn.Open();

            

            //закрываем соединение
            //conn.Close();

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            txtlog.Text += "Проверка: введенны ли параметры\n";
            if (TextBox1.Text.Length != 0)
            {
                if (TextBox2.Text.Length != 0) 
                {
                    
                }
                else
                {

                }
            }
            else 
            {
                
            }




            // Определяем строку с текстом запроса
            string strSQL = "UPDATE pmib6602.spj1 SET kol = kol + ? WHERE n_spj IN( SELECT n_spj FROM pmib6602.spj1 LEFT JOIN( SELECT n_det, MAX(date_post) date_last FROM pmib6602.spj1 WHERE LOWER(n_izd) = LOWER(?) GROUP BY n_det) AS tab ON tab.n_det = spj1.n_det WHERE date_post = date_last)";
            // Создаем объект запроса
            OdbcCommand cmd = new OdbcCommand(strSQL, conn);
            // Создаем первый параметр
            OdbcParameter par_name = new OdbcParameter();
            par_name.ParameterName = "@vkolnew";
            par_name.OdbcType = OdbcType.Int;
            par_name.Value = "Кулер";
            // Добавляем первый параметр в коллекцию
            cmd.Parameters.Add(par_name);
            // Создаем второй параметр
            OdbcParameter par_town = new OdbcParameter();
            par_town.ParameterName = "@vn_det";
            par_town.OdbcType = OdbcType.Text;
            par_town.Value = "P3";
            // Добавляем второй параметр в коллекцию.
            cmd.Parameters.Add(par_town);
            // Объявляем объект транзакции
            OdbcTransaction tx = null;
            try
            {
                // Начинаем транзакцию и извлекаем объект транзакции из объекта подключения.
                tx = conn.BeginTransaction();
                // Включаем объект SQL-команды в транзакцию
                cmd.Transaction = tx;
                // Выполняем SQL-команду и получаем количество обработанных записей
                int i = cmd.ExecuteNonQuery();
                // Подтверждаем транзакцию  
                tx.Commit();
            }
            catch (Exception ex)
            {
                // При возникновении любой ошибки 
                // Формируем сообщение об ошибке 
                txtlog.Text += ex.Message;
                // выполняем откат транзакции 
                tx.Rollback();
            }
        }
    }
}