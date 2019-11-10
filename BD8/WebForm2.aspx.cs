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

        protected void Page_Load(object sender, EventArgs e)
        {
            Label5.Visible = false;
            txtlog.Visible = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Label5.Visible = true;
            txtlog.Visible = true;

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

            int chislo = 0;
            bool check;

            //Проверка введенного числа
            txtlog.Text += "Проверка введеных данных...\n";
            check = true;
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

            if (check == true)
            {
                // Определяем строку с текстом запроса
                txtlog.Text += "Определяем строку с текстом запроса\n";
                string strSQL =
                " UPDATE pmib6602.spj1 " +
                " SET kol = kol + ? " +
                " WHERE CAST(TRIM(LEADING 'N' FROM n_spj) AS INT) IN ( " +
                    " SELECT MAX(CAST(TRIM(LEADING 'N' FROM spj1.n_spj) AS int)) n_spj " +
                    " FROM pmib6602.spj1 " +
                    " JOIN ( " +
                        " SELECT n_det, MAX(date_post) date_last " +
                        " FROM pmib6602.spj1 " +
                        " WHERE n_izd = TRIM(?) " +
                        " GROUP BY n_det) AS tab ON tab.n_det = spj1.n_det " +
                    " WHERE date_post = date_last " +
                    " GROUP BY spj1.n_det) ";

                // Создаем объект запроса
                txtlog.Text += "Создаем объект запроса\n";
                OdbcCommand cmd = new OdbcCommand(strSQL, conn);

                // Создаем первый параметр
                txtlog.Text += "Создаем первый параметр и добавляем его\n";
                OdbcParameter par_kol = new OdbcParameter();
                par_kol.ParameterName = "@vkolnew";
                par_kol.OdbcType = OdbcType.Int;
                par_kol.Value = chislo;
                // Добавляем первый параметр в коллекцию
                cmd.Parameters.Add(par_kol);

                // Создаем второй параметр
                txtlog.Text += "Создаем второй параметр и добавляем его\n";
                OdbcParameter par_izd = new OdbcParameter();
                par_izd.ParameterName = "@vn_izd";
                par_izd.OdbcType = OdbcType.Text;
                par_izd.Value = DropDownList1.SelectedValue.ToString();
                // Добавляем второй параметр в коллекцию.
                cmd.Parameters.Add(par_izd);

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
                    txtlog.Text += "Обработано " + i + " запис(ь/и/ей)\n";
                }
                catch (Exception ex)
                {
                    // При возникновении любой ошибки 
                    // Формируем сообщение об ошибке 
                    txtlog.Text += "Транзакция не завершена, произошла ошибка...\n";
                    txtlog.Text += ex.Message;
                    txtlog.Text += "\n";
                    // выполняем откат транзакции 
                    tx.Rollback();
                }
            }
                //закрываем соединение
                txtlog.Text += "Закрываем соединение с БД\n";
                conn.Close();

            GridView2.EditIndex = -1;
            GridView2.DataBind();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            // Перейти на другую Web-форму, сохранив состояние отображения.
            Server.Transfer("WebForm3.aspx", true);
        }

        //кнопка обновлялка формы
        protected void Button3_Click(object sender, EventArgs e)
        {
            GridView2.EditIndex = -1;
            GridView2.DataBind();
        }

        protected void GridView2_DataBinding(object sender, EventArgs e)
        {
            
        }
    }
}