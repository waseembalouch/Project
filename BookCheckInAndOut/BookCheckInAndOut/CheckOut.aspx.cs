using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BookCheckInAndOut.Utilities;
using BusinessLogic;
using System.Data;

namespace BookCheckInAndOut
{
    public partial class CheckOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int selectedBookID = 0;
            if (!String.IsNullOrWhiteSpace(Request.QueryString["bookID"]))
                selectedBookID = int.Parse(Request.QueryString["bookID"]);
            else { }
            // to do error message

            lblCheckOutDate.Text = DateTime.Now.ToShortDateString();
            DisplayBookInfo(selectedBookID);

            lblReturnDate.Text = Utilities.Utilities.getDateAfterSpecifiedBusinessDays(15).ToShortDateString();

            displayBookCheckOutHistory(selectedBookID);

        }

        /// <summary>
        /// This function is responsible for populating the book history grid.
        /// </summary>
        /// <param name="bookID">Book ID</param>
        private void displayBookCheckOutHistory(int bookID)
        {
            BusinessLogicDBOperations dbOperations = new BusinessLogicDBOperations();
            List<Borrower> borrowers = dbOperations.RetrieveBookCheckOutHistory(bookID);
            HistoryList.DataSource = borrowers;
            HistoryList.DataBind();


        }

        /// <summary>
        /// Check Out button event handler
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnCheckOut_Click(object sender, EventArgs e)
        {

            int selectedBookID = 0;
            if (!String.IsNullOrWhiteSpace(Request.QueryString["bookID"]))
                selectedBookID = int.Parse(Request.QueryString["bookID"]);
            else
            {
                Utilities.Utilities.setPageMessage("Please select a book.", Utilities.Utilities.severity.error, Page.Master);
                return;
            }

            BusinessLogicDBOperations dbOperations = new BusinessLogicDBOperations();


            string bookName = txtName.Text;
            string mobileNo = txtMobile.Text;
            string nationalID = txtNationalID.Text;
            DateTime checkOutDate = DateTime.Parse(lblCheckOutDate.Text);
            DateTime returnDate = DateTime.Parse(lblReturnDate.Text);

            var book = dbOperations.RetrieveBooksList().Where(x => x.BookID == selectedBookID).FirstOrDefault();
            if (book != null && book.CheckOutStatusID == 1) // CheckOutStatusID 1 is check in 
            {
                int result = dbOperations.CheckOut(selectedBookID,
                     bookName,
                     mobileNo,
                     nationalID,
                     checkOutDate,
                     returnDate
                     );

                if (result == 0)
                {
                    Utilities.Utilities.setPageMessage("Encountered an error while checking out.", Utilities.Utilities.severity.error, Page.Master);
                    return;
                }

                Utilities.Utilities.setPageMessage("Book has been checked out in the name of " + txtName.Text, Utilities.Utilities.severity.info, Page.Master);

                displayBookCheckOutHistory(selectedBookID);
            }
            else
                Utilities.Utilities.setPageMessage("Book is already checkout", Utilities.Utilities.severity.error, Page.Master);
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

                    lblCoverPrice.Text = book.CoverPrice.ToString("N0");
                    lblISBN.Text = book.ISBN;

                    lblPublishYear.Text = book.PublishYear;

                    //Get book borrower history
                    BusinessLogicDBOperations dbBorrowers = new BusinessLogicDBOperations();
                    List<Borrower> borrowers = dbOperations.RetrieveBookCheckOutHistory(BookID);



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

    }
}