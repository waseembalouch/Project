using BusinessLogic;
using DBAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookCheckInAndOut.Utilities
{
    public static class Utilities
    {
        /// <summary>
        /// This function calculates the date after specified number of work/business days
        /// Friday and Saturday are treated as off days.
        /// </summary>
        /// <param name="days">Business days</param>
        /// <returns>Target Date</returns>
        public static DateTime getDateAfterSpecifiedBusinessDays(int days)
        {
            BusinessLogicDBOperations dbOperations = new BusinessLogicDBOperations();
            List<GazetteHoliday> holidays = dbOperations.RetriveGazetteHoliday();
            DateTime TargetDate = DateTime.Now;
            for (int i = 0; i < 15;)
            {
                if (!(TargetDate.DayOfWeek == DayOfWeek.Saturday || TargetDate.DayOfWeek == DayOfWeek.Sunday || CheckHoliday(TargetDate, holidays)))
                    i++;
                TargetDate = TargetDate.AddDays(1);
            }

            return TargetDate;
        }
        
        public static bool CheckHoliday(DateTime ReturnDate, List<GazetteHoliday> holidays)
        {
            if (holidays.Any(d => d.HolidayDate.Year == ReturnDate.Year && d.HolidayDate.Month == ReturnDate.Month && d.HolidayDate.Day == ReturnDate.Day))
                return true;
            else
                return false;
        }
        public static void setPageMessage(string message, severity level, System.Web.UI.MasterPage master)
        {
            Label messageLabel = (Label)master.FindControl("lblMessage");
            messageLabel.Text = message;

            if (level == severity.error)
                messageLabel.ForeColor = System.Drawing.Color.Red;
            else
                messageLabel.ForeColor = System.Drawing.Color.Green;
        }


        public enum severity
        {
            info,
            error

        }
    }


}