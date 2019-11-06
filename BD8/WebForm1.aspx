<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="BD8.WebForm1" %>

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
            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="X-Large" Font-Underline="False" Text="Получить информацию о деталях, которых в настоящий момент не хватает для изготовления заданного количества указанного изделия."></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Название изделия:"></asp:Label>
&nbsp;
            <asp:TextBox ID="TextBox1" runat="server" BorderWidth="2px" Font-Size="X-Large" Height="25px" MaxLength="20" ToolTip="Введите название изделие" Width="110px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Количество изделия:"></asp:Label>
&nbsp;
            <asp:TextBox ID="TextBox2" runat="server" BorderWidth="2px" Font-Size="X-Large" Height="25px" MaxLength="20" ToolTip="Введите название изделие" Width="110px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Large" OnClick="Button1_Click" Text="Выполнить запрос" Width="270px" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="X-Large" Font-Underline="False" Text="Информация о деталях:"></asp:Label>
        </p>
        <p>
            <asp:GridView ID="GridView1" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <Columns>
                    <asp:BoundField />
                </Columns>
                <FooterStyle BackColor="Tan" />
                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
            </asp:GridView>
        </p>
    </form>
</body>
</html>
