<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="BD8.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <p>
            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="X-Large" Font-Underline="False" Text="Увеличить на заданное число количество в последней поставке каждой детали для указанного изделия."></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Название изделия:"></asp:Label>
&nbsp;&nbsp;
            <asp:TextBox ID="TextBox1" runat="server" BorderWidth="2px" Font-Size="X-Large" Height="25px" MaxLength="3" ToolTip="Введите название изделие" Width="110px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p style="margin-left: 120px">
&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Число:"></asp:Label>
&nbsp;
            <asp:TextBox ID="TextBox2" runat="server" BorderWidth="2px" Font-Size="X-Large" Height="25px" MaxLength="13" ToolTip="Введите название изделие" Width="110px" TextMode="Number"></asp:TextBox>
        </p>
        <p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Large" OnClick="Button1_Click" Text="Выполнить запрос" Width="270px" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Лог программы:"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="txtlog" runat="server" BorderWidth="2px" Font-Size="Large" Height="155px" ToolTip="Введите название изделие" Width="424px" Font-Bold="True" TextMode="MultiLine"></asp:TextBox>
        </p>
    </form>
</body>
</html>
