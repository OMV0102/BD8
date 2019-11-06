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
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="n_izd" DataValueField="n_izd" Font-Bold="True" Font-Size="X-Large" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                <asp:ListItem Selected="True"></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:studentsConnectionString2 %>" ProviderName="<%$ ConnectionStrings:studentsConnectionString2.ProviderName %>" SelectCommand="SELECT DISTINCT n_izd
FROM pmib6602.j
ORDER BY n_izd"></asp:SqlDataSource>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Количество изделия:"></asp:Label>
&nbsp;
            <asp:TextBox ID="TextBox2" runat="server" BorderWidth="2px" Font-Size="X-Large" Height="25px" MaxLength="20" ToolTip="Введите название изделие" Width="110px" TextMode="Number" style="font-weight: 700"></asp:TextBox>
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
            <asp:GridView ID="GridView1" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" AutoGenerateColumns="False" DataKeyNames="n_det" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <Columns>
                    <asp:BoundField DataField="n_det" HeaderText="№ детали" ReadOnly="True" SortExpression="n_det" />
                    <asp:BoundField DataField="name" HeaderText="Название" ReadOnly="True" SortExpression="name" />
                    <asp:BoundField DataField="cvet" HeaderText="Цвет" ReadOnly="True" SortExpression="cvet" />
                    <asp:BoundField DataField="ves" HeaderText="Вес" ReadOnly="True" SortExpression="ves" />
                    <asp:BoundField DataField="town" HeaderText="Город" ReadOnly="True" SortExpression="town" />
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:studentsConnectionString %>" ProviderName="<%$ ConnectionStrings:studentsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM pmib6602.p
WHERE n_det IN (
	SELECT post.n_det
	FROM(
		SELECT spj1.n_izd, spj1.n_det, SUM(kol) kol_post
		FROM pmib6602.spj1
		GROUP BY spj1.n_izd, spj1.n_det
		HAVING LOWER(spj1.n_izd) = LOWER(?))AS post 
	RIGHT JOIN (
		SELECT n_q, n_izd, n_det, (kol*?) kol_need
		FROM pmib6602.q
		WHERE LOWER(n_izd) = LOWER(?)) AS norma ON norma.n_det = post.n_det
	WHERE kol_post &lt; kol_need)
ORDER BY p.n_det">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" DefaultValue="" Name="izd1" PropertyName="SelectedValue" Type="String" Size="3" />
                    <asp:ControlParameter ControlID="TextBox2" DefaultValue="" Name="kol1" PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownList1" DefaultValue="" Name="izd2" PropertyName="SelectedValue" Type="String" Size="3" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
    </form>
</body>
</html>
