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
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int chislo = 0;
            bool check = true;

            txtlog.Text += "Проверка введеных данных...\n";
            if (TextBox1.Text.Length != 0)
            {
                txtlog.Text += "Название изделия ("+ TextBox1.Text.ToString()+") принято\n";
                if (TextBox2.Text.Length != 0)
                { 
                    if(Int32.TryParse(TextBox2.Text.ToString(), out chislo) == true)
                    {
                        txtlog.Text += "Введенное число (" + chislo + ") принято\n";
                    }
                    else
                    {
                        txtlog.Text += "Ошибка: Введенно неккорректное число!\n";
                        check = false;
                    }
                }
                else
                {
                    txtlog.Text += "Ошибка: Введите число!\n";
                    check = false;
                }
            }
            else 
            {
                txtlog.Text += "Ошибка: Введите название изделия!\n";
                check = false;
            }

            check = false;
            if (check == true)
            {

                // Определяем строку с текстом запроса
                txtlog.Text += "Определяем строку с текстом запроса\n";
                string strSQL = "UPDATE pmib6602.spj1 SET kol = kol + ? WHERE n_spj IN( SELECT n_spj FROM pmib6602.spj1 LEFT JOIN( SELECT n_det, MAX(date_post) date_last FROM pmib6602.spj1 WHERE LOWER(n_izd) = LOWER(?) GROUP BY n_det) AS tab ON tab.n_det = spj1.n_det WHERE date_post = date_last)";
                // Создаем объект запроса
                txtlog.Text += "Создаем объект запроса\n";
                OdbcCommand cmd = new OdbcCommand(strSQL, conn);
                // Создаем первый параметр
                txtlog.Text += "Создаем первый параметр и добавляем его\n";
                OdbcParameter par_name = new OdbcParameter();
                par_name.ParameterName = "@vkolnew";
                par_name.OdbcType = OdbcType.Int;
                par_name.Value = chislo;
                // Добавляем первый параметр в коллекцию
                cmd.Parameters.Add(par_name);

                // Создаем второй параметр

                txtlog.Text += "Создаем второй параметр и добавляем его\n";
                OdbcParameter par_town = new OdbcParameter();
                par_town.ParameterName = "@vn_izd";
                par_town.OdbcType = OdbcType.Text;
                par_town.Value = TextBox1.Text.ToString();
                // Добавляем второй параметр в коллекцию.
                cmd.Parameters.Add(par_town);

                // Объявляем объект транзакции
                txtlog.Text += "Объявляем объект транзакции\n";
                OdbcTransaction tx = null;
                try
                {
                    // Начинаем транзакцию и извлекаем объект транзакции из объекта подключения.
                    txtlog.Text += "Начинаем транзакцию и извлекаем объект транзакции из объекта подключения\n";
                    tx = conn.BeginTransaction();
                    // Включаем объект SQL-команды в транзакцию
                    txtlog.Text += "Включаем объект SQL-команды в транзакцию\n";
                    cmd.Transaction = tx;
                    // Выполняем SQL-команду и получаем количество обработанных записей
                    txtlog.Text += "Выполняем SQL-команду\n";
                    int i = cmd.ExecuteNonQuery();
                    // Подтверждаем транзакцию 
                    txtlog.Text += "Подтверждаем транзакцию \n";
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

                //закрываем соединение
                txtlog.Text += "Закрываем соединение с БД\n";
                conn.Close();
            }
        }
    }
}