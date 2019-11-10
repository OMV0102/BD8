<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="BD8.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="X-Large" Font-Underline="False" Text="Web-приложение (ЛР №8 Вариант 2)"></asp:Label>
        </div>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="X-Large" Font-Underline="False" Text="Запросы:"></asp:Label>
        </p>
        <p>
            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="X-Large" Font-Underline="False" Text="1) Получить информацию о деталях, которых в настоящий момент не хватает для изготовления заданного количества указанного изделия."></asp:Label>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Large" OnClick="Button1_Click" Text="Перейти к форме запроса" Width="298px" />
        </p>
        <p>
            <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Size="X-Large" Font-Underline="False" Text="2) Увеличить на заданное число количество в последней поставке каждой детали для указанного изделия."></asp:Label>
        </p>
        <p>
            <asp:Button ID="Button2" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Large" OnClick="Button2_Click" Text="Перейти к форме запроса" Width="298px" />
        </p>
    </form>
</body>
</html>
