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
            txtlog.Text = "";
        }

        //кнопка Выполнить запрос
        protected void Button1_Click(object sender, EventArgs e)
        {

            // Создаем объект подключения
            conn = new OdbcConnection();
            // Задаем параметр подключения – имя ODBC-источника
            conn.ConnectionString = "Dsn=PostgreSQL16";
            // Подключаемся к БД
            conn.Open();

            int chislo = 0;
            bool check;

            //Проверка введенного числа
            check = true;
            if (TextBox2.Text.Length != 0)
            { 
                if(Int32.TryParse(TextBox2.Text.ToString(), out chislo) == false)
                {
                    check = false;
                    txtlog.Text = "Введено некорректное число!\n";
                }
            }
            else
            {
                txtlog.Text = "Не введено число!\n";
                check = false;
            }

            if (check == true)
            {
                // Определяем строку с текстом запроса
                string strSQL =
                " UPDATE pmib6602.spj1 " +
                " SET kol = kol + ? " +
                " WHERE n_spj IN " +
                " ( " +
                    " SELECT " +
                    " ( " +
                        " SELECT n_spj " +
                        " FROM pmib6602.spj1 " +
                        " WHERE spj1.n_det = q.n_det AND spj1.n_izd = q.n_izd " +
                        " ORDER BY spj1.date_post DESC, CAST(TRIM(LEADING 'N' FROM spj1.n_spj) AS INT) DESC " +
                        " LIMIT 1 " +
                    " ) " +
                    " FROM pmib6602.q " +
                    " WHERE q.n_izd = TRIM(?) " +
                " ) ";

                // Создаем объект запроса
                using (OdbcCommand cmd = new OdbcCommand(strSQL, conn))
                {

                    // Создаем первый параметр
                    OdbcParameter par_kol = new OdbcParameter();
                    par_kol.ParameterName = "@vkolnew";
                    par_kol.OdbcType = OdbcType.Int;
                    par_kol.Value = chislo;
                    // Добавляем первый параметр в коллекцию
                    cmd.Parameters.Add(par_kol);

                    // Создаем второй параметр
                    OdbcParameter par_izd = new OdbcParameter();
                    par_izd.ParameterName = "@vn_izd";
                    par_izd.OdbcType = OdbcType.Text;
                    par_izd.Value = DropDownList1.SelectedValue.ToString();
                    // Добавляем второй параметр в коллекцию.
                    cmd.Parameters.Add(par_izd);

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
                        txtlog.Text += "Транзакция завершена\n";
                        tx.Commit();
                        txtlog.Text += "Обработано " + i + " запис(ь/и/ей)\n";
                        GridView3.Visible = true;
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
            }

            // Закрываем соединение
            conn.Close();

            //правую таблицу после запроса всегда обновляем
            GridView3.EditIndex = -1;
            GridView3.DataBind();

        }

        //выпадающий список
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView3.Visible = false;
        }

        //кнопка выполнить запрос
        protected void Button2_Click(object sender, EventArgs e)
        {
            // Перейти на другую Web-форму, сохранив состояние отображения.
            Server.Transfer("WebForm3.aspx", true);
        }

        //кнопка обновления таблицы
        protected void Button3_Click(object sender, EventArgs e)
        {
            GridView3.Visible = false;
            GridView2.EditIndex = -1;
            GridView2.DataBind();
            GridView3.EditIndex = -1;
            GridView3.DataBind();
        }


        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void GridView3_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}