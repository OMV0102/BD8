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
            <asp:Button ID="Button2" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Large" OnClick="Button2_Click" Text="На главную" Width="219px" />
        </div>
        <p>
            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="X-Large" Font-Underline="False" Text="Увеличить на заданное число количество в последней поставке каждой детали для указанного изделия."></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Название изделия:"></asp:Label>
&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource3" DataTextField="n_izd" DataValueField="n_izd" Font-Bold="True" Font-Size="X-Large" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" ToolTip="Выберите изделие">
                <asp:ListItem Selected="True"></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:studentsConnectionString3 %>" ProviderName="<%$ ConnectionStrings:studentsConnectionString3.ProviderName %>" SelectCommand="SELECT DISTINCT n_izd
FROM pmib6602.j
ORDER BY n_izd"></asp:SqlDataSource>
        </p>
        <p>
            &nbsp;</p>
        <p style="margin-left: 120px">
&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Число:"></asp:Label>
&nbsp;
            <asp:TextBox ID="TextBox2" runat="server" BorderWidth="2px" Font-Size="X-Large" Height="25px" MaxLength="13" ToolTip="Введите число" Width="110px" TextMode="Number" Wrap="False"></asp:TextBox>
        </p>
        <p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Large" OnClick="Button1_Click" Text="Выполнить запрос" Width="270px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button3" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Large" OnClick="Button3_Click" Text="Обновить таблицу" Width="270px" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="2px" CellPadding="2" DataKeyNames="n_spj" DataSourceID="SqlDataSource1" Font-Size="Large" ForeColor="Black" OnDataBinding="GridView2_DataBinding">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <Columns>
                    <asp:BoundField DataField="n_spj" HeaderText="n_spj" ReadOnly="True" SortExpression="n_spj" />
                    <asp:BoundField DataField="n_post" HeaderText="n_post" SortExpression="n_post" />
                    <asp:BoundField DataField="n_det" HeaderText="n_det" SortExpression="n_det" />
                    <asp:BoundField DataField="n_izd" HeaderText="n_izd" SortExpression="n_izd" />
                    <asp:BoundField DataField="kol" HeaderText="kol" SortExpression="kol" />
                    <asp:BoundField DataField="date_post" HeaderText="date_post" SortExpression="date_post" />
                    <asp:BoundField DataField="cost" HeaderText="cost" SortExpression="cost" />
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:studentsConnectionString3 %>" ProviderName="<%$ ConnectionStrings:studentsConnectionString3.ProviderName %>" SelectCommand="SELECT n_spj, n_post, n_det, n_izd, kol, date_post, cost
FROM pmib6602.spj1
WHERE n_izd = TRIM(?)
ORDER BY n_det, date_post, CAST(TRIM(LEADING 'N' FROM n_spj) AS INT)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="n_izd1" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <p>
            <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Лог программы:"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="txtlog" runat="server" BorderWidth="2px" Font-Size="Large" Height="215px" Width="535px" Font-Bold="True" TextMode="MultiLine"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
