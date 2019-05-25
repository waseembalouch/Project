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
    public partial class CheckIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int selectedBookID = 0;
            if (!String.IsNullOrWhiteSpace(Request.QueryString["bookID"]))
                selectedBookID = int.Parse(Request.QueryString["bookID"]);
            else { }
            // to do error message

            displayBorrowerDeails(selectedBookID);
        }

        private void displayBorrowerDeails(int BookID)
        {
            BusinessLogicDBOperations dbOperations = new BusinessLogicDBOperations();
            Borrower borrower = dbOperations.RetrieveBookBorrowerDetails(BookID);

            if (borrower != null)
            {
                lblName.Text = borrower.Name;
                lblMobile.Text = borrower.MobileNo;
                lblReqReturnDate.Text = borrower.ReturnDate.ToShortDateString();
                lblReturnDate.Text = DateTime.Now.ToShortDateString();

                double penaltyAmount = calcultePenaltyAmount(DateTime.Now, borrower.ReturnDate);
                lblPenaltyAmount.Text = String.Format("{0:#,##0.00}", penaltyAmount);

            }
            else
            {
                Utilities.Utilities.setPageMessage("Book is either already checked in or was not found.", Utilities.Utilities.severity.error, Page.Master);
                return;

            }

        }

        private double calcultePenaltyAmount(DateTime ActualReturnDate, DateTime ReturnDate)
        {
            // if ReturnDate is greater and equal today as per i understand no fine 
            BusinessLogicDBOperations dbOperations = new BusinessLogicDBOperations();
            List<GazetteHoliday> holidays = dbOperations.RetriveGazetteHoliday();

            if (ReturnDate.Date >= DateTime.Now.Date)
                return 0;
            else
            {
                // how days exceed total days * planty amount which is 5
                double lateDays = 0;


                lateDays = (DateTime.Now.Date - ReturnDate.Date).TotalDays;
                //while (ReturnDate != DateTime.Now.Date)
                //{
                //    if (!(ReturnDate.DayOfWeek == DayOfWeek.Saturday || ReturnDate.DayOfWeek == DayOfWeek.Sunday || Utilities.Utilities.CheckHoliday(ReturnDate, holidays)))
                //    {
                //        lateDays++;
                //    }
                //    ReturnDate = ReturnDate.AddDays(1);
                //}
                return lateDays * 5;
            }
        }
        protected void btnCheckIn_Click(object sender, EventArgs e)
        {
            BusinessLogicDBOperations dbOperations = new BusinessLogicDBOperations();

            int selectedBookID = 0;
            if (!String.IsNullOrWhiteSpace(Request.QueryString["bookID"]))
                selectedBookID = int.Parse(Request.QueryString["bookID"]);
            else { }

            int result = dbOperations.CheckIn(selectedBookID);

            if (result == 0)
            {
                Utilities.Utilities.setPageMessage("Encountered an error while checking in.", Utilities.Utilities.severity.error, Page.Master);
                return;
            }

            Utilities.Utilities.setPageMessage("Book has been checked in successfully.", Utilities.Utilities.severity.info, Page.Master);

        }
    }
}