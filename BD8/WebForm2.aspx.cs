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
                }
            }
            else
            {
                check = false;
            }

            if (check == true)
            {
                // Определяем строку с текстом запроса
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

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            // Перейти на другую Web-форму, сохранив состояние отображения.
            Server.Transfer("WebForm3.aspx", true);
        }

        //кнопка обновления таблицы
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