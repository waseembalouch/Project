<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="BookCheckInAndOut.HomePage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style type="text/css">
        .auto-style1 {
            height: 80px;
        }
        .auto-style2 {
            height: 30px;
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
    <table id="ListTable" class="table" border="0" >
        <tr>

            <td style="width:0px"> </td>
              <td class="RadioButtonColumn"> Select </td>
              <td class="GridHeading"> Title </td>
              <td class="GridHeading"> ISBN  </td> 
              <td class="GridHeading"> PublishYear </td> 
              <td class="GridHeading"> CoverPrice </td> 
              <td class="GridHeading"> Status </td> 
            </tr>  
         
    <asp:ListView ID="BooksList" runat="server" ClientIDMode="Static">
        
        <ItemTemplate>
            <tr>
                <td> <asp:HiddenField runat="server" ID="hd" ClientIDMode="AutoID" Value='<%# Eval("BookID") %>' /> </td>
              <td>    <asp:RadioButton runat="server" ID="rd" ClientIDMode="AutoID" onclick='<%# "OnCheckChange(this," + Eval("BookID") + ")" %>' /> </td>
              <td class="text"> <%# Eval("Title") %></td>
              <td class="text"> <%# Eval("ISBN") %> </td> 
              <td class="text"> <%# Eval("PublishYear") %> </td> 
              <td class="text"> <%# Eval("CoverPrice") %> </td> 
              <td class="text"> <%# Eval("CheckOutStatusDescription") %> </td> 
            </tr>           
        </ItemTemplate>
    </asp:ListView>

        <tr>
            <td style="height: 50px"></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
           
           
            <td style="text-align: right">
                <asp:Button ID="btnCheckIn" CssClass="button" ClientIDMode="Static" runat="server" Text="Check In" OnClick="btnCheckIn_Click" />
            </td>
             <td style="text-align: right">
                <asp:Button ID="btnCheckOut" CssClass="button" ClientIDMode="Static" runat="server" Text="Check Out" OnClick="btnCheckOut_Click" />
            </td>
             <td style="text-align: right">
                <asp:Button ID="btndetail" CssClass="button" ClientIDMode="Static" runat="server" Text="Detail" OnClick="btnDetail_Click" />
            </td>
        </tr>
   </table>

    
    
    <asp:HiddenField ID="hdnField" runat="server" ClientIDMode="Static" />

    <script type="text/javascript">


        function OnCheckChange(rb, BookID) {
          
            //logic for exclusive setting the radio button that was last clicked.
            var table = document.getElementById('ListTable');
                                 
            var radiobtn = table.getElementsByTagName('input');
           
            for (k = 0; k < radiobtn.length; k++)
            {
                if ((radiobtn[k].type == 'radio') && (rb.id == radiobtn[k].id)) {
                    radiobtn[k].checked = true;
                    document.getElementById("hdnField").value = BookID;
                }
                else
                    radiobtn[k].checked = false;

            }

            //Book id against the selected radio button.
          var hdfield = rb.parentNode.parentNode.cells[0].getElementsByTagName('input');
          console.log(document.getElementById("hdnField").value);
          if (hdfield[0].type == 'hidden')
              document.getElementById("hdnField").value = document.getElementById("hdnField").value;

            //enabling /disabling buttons on the basis of checkin /checkout
         
         
          //debugger;
          if (rb.parentNode.parentNode.cells[6].innerText == 'Checked In') {
              document.getElementById('btnCheckIn').disabled = true;
              document.getElementById('btnCheckOut').disabled = false;
          }
          else if (rb.parentNode.parentNode.cells[6].innerText == 'Checked Out') {
              document.getElementById('btnCheckOut').disabled = true;
              document.getElementById('btnCheckIn').disabled = false;
          }

        }


        </script>
   
</asp:Content>
