﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="BD8.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            &nbsp;<asp:Button ID="Button2" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Large" OnClick="Button2_Click" Text="На главную" Width="219px" />
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
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="n_izd" DataValueField="n_izd" Font-Bold="True" Font-Size="X-Large" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" ToolTip="Выберите изделие">
                <asp:ListItem Selected="True"></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:studentsConnectionString2 %>" ProviderName="<%$ ConnectionStrings:studentsConnectionString2.ProviderName %>" SelectCommand="SELECT DISTINCT n_izd
FROM pmib6602.j
ORDER BY n_izd"></asp:SqlDataSource>
        </p>
        <p>
            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Количество изделия:"></asp:Label>
&nbsp;
            <asp:TextBox ID="TextBox2" runat="server" BorderWidth="1px" Font-Size="X-Large" Height="25px" MaxLength="20" ToolTip="Введите название изделие" Width="110px" TextMode="Number" style="font-weight: 700" Wrap="False"></asp:TextBox>
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
            <asp:GridView ID="GridView1" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" AutoGenerateColumns="False" DataKeyNames="n_det" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Font-Size="X-Large" EnableSortingAndPagingCallbacks="True" AllowSorting="True" Caption="Детали, которых не хватает:" EnableViewState="False" HorizontalAlign="Center" Width="790px">
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
WHERE n_det IN
(
	SELECT q1.n_det
	FROM pmib6602.q q1
	WHERE n_izd = TRIM(?) AND 
                  NOT
	(
		(? * kol) &lt;=
		((
			SELECT SUM(kol) kol_post /*кол-во поставленных деталей*/
			FROM pmib6602.spj1
			WHERE spj1.n_izd = TRIM(?) AND spj1.n_det = q1.n_det
			GROUP BY spj1.n_det 
		)
		- /*минус уже потраченные детали*/
		(
			SELECT (kol * 
				(SELECT SUM(kol) /*кол-во произведенных изделий*/
				FROM pmib6602.w
				WHERE n_izd = TRIM(?)))
			FROM pmib6602.q
			WHERE n_izd = TRIM(?) AND q.n_det = q1.n_det
		))
	) 
)
ORDER BY n_det">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" DefaultValue="" Name="izd1" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="TextBox2" DefaultValue="0" Name="kol1" PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownList1" DefaultValue="" Name="izd2" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="izd3" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="izd4" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
    </form>
</body>
</html>
