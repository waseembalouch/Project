<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="BookCheckInAndOut.Details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 10px;
            font-style: normal;
            text-align: left;
            width: 182px;
        }
        .auto-style3 {
            width: 182px;
        }
        .auto-style4 {
            width: 208px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table id ="tblContent">
    <tr>
        <td class="text2">Book Title:</td> <td class="auto-style4"><asp:Label class="text" ID ="lblBookTitle" runat="server" /></td>
        </tr>

        <tr>
        <td class="text2">ISBN:</td> <td class="auto-style4"><asp:Label class="text" ID ="lblISBN" runat="server" /></td>
        </tr>

        <tr>
        <td class="text2">Publish Year:</td> <td class="auto-style4"><asp:Label class="text" ID ="lblPublishYear" runat="server" /></td>
        </tr>

        <tr>
        <td class="text2">Cover Price:</td> <td class="auto-style4"><asp:Label class="text" ID ="lblCoverPrice" runat="server" /></td>
        </tr>

        <tr>
        <td class="text2">Check-in / check out status:</td> <td class="auto-style4"><asp:Label class="text" ID ="lblCheckInStatus" runat="server" /></td>
        </tr>
        
        <tr>
        <td class="text2">Borrower Name:</td> <td class="auto-style4"><asp:Label class="text" ID ="lblName" runat="server" /></td>
        </tr>
        <tr>
        <td class="auto-style3"></td> <td class="auto-style4" style="text-align:right"><asp:Button ID="btnHome" CssClass="button" Text="Home" runat="server" OnClick="btnHome_Click" /></td>
        </tr>

     </table>
    
     <table id="HistoryTable">
                    <tr>
                        <td class="GridHeading">Name </td>
                        <td class="GridHeading">Check Out Date  </td>
                        <td class="GridHeading">Returned Date </td>
                    </tr>

                    <asp:ListView ID="HistoryList" runat="server" ClientIDMode="Static">
                        <ItemTemplate>
                            <tr>
                                <td class="text"><%# Eval("Name") %></td>
                                <td class="text"><%# String.Format("{0:M/d/yyyy}", Eval("CheckOutDate")) %> </td>
                                <td class="text"><%# String.Format("{0:M/d/yyyy}", Eval("ReturnDate")) %> </td>
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>

                </table>
</asp:Content>