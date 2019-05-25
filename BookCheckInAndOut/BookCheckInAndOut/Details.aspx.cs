using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using System.Data;

namespace BookCheckInAndOut
{
    public partial class Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int selectedBookID = 0;
            if (!String.IsNullOrWhiteSpace(Request.QueryString["bookID"]))
                selectedBookID = int.Parse(Request.QueryString["bookID"]);
            else { }
            // to do error message


            DisplayBookInfo(selectedBookID);
        }

        private void DisplayBookInfo(int BookID)
        {
            try
            {
                BusinessLogicDBOperations dbOperations = new BusinessLogicDBOperations();
                Book book = dbOperations.RetrieveBooksList(BookID).Where(x => x.BookID == BookID).FirstOrDefault();

                if (book != null)
                {
                    lblBookTitle.Text = book.Title;
                    lblCheckInStatus.Text = book.CheckOutStatusDescription;
                    lblCoverPrice.Text = book.CoverPrice.ToString("N0");
                    lblISBN.Text = book.ISBN;
                    lblName.Text = "";
                    lblPublishYear.Text = book.PublishYear;

                    //Get book borrower history
                    BusinessLogicDBOperations dbBorrowers = new BusinessLogicDBOperations();
                    List<Borrower> borrowers = dbOperations.RetrieveBookCheckOutHistory(BookID);

                    if (book.CheckOutStatusID == 1)
                    {
                        Borrower borrower = borrowers.LastOrDefault();
                        if (borrower != null) lblName.Text = borrower.Name;
                    }
                    else
                        lblName.Text = "Book is checked in.";

                    HistoryList.DataSource = borrowers;
                    HistoryList.DataBind();

                }
                else
                {
                    Utilities.Utilities.setPageMessage("Book is either already checked in or was not found.",
                        Utilities.Utilities.severity.error, Page.Master);
                    return;

                }
            }
            catch (Exception ex)
            {
                BusinessLogicDBOperations dbOperations = new BusinessLogicDBOperations();
                dbOperations.ErrorLog(ex.Message, Request.Url.AbsoluteUri);
            }

        }


        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/HomePage.aspx");
        }
    }
}