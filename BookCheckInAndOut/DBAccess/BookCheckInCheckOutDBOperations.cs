using System;
using System.Data.SqlClient;
using System.Data;

namespace DBAccess
{
    public class BookCheckInCheckOutDBOperations : Database
    {
        private static BookCheckInCheckOutDBOperations _instance;

        private new void initialize()
        {
            try
            {
                base.initialize();
            }
            catch (Exception ex)
            {
                ErroLogDBOperations db = ErroLogDBOperations.getInstance();
                db.ErrorLog(ex.Message, "In BookCheckInCheckOutDBOperations initialize");

            }
        }


        public IDataReader RetrieveBooksList()
        {
            IDataReader reader = null;
            SqlCommand command = new SqlCommand();

            try
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = Constants.SP_RetrieveBooks;
                reader = base.ExecuteReader(command);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception("Oops! Something went wrong.");
            }
            catch (Exception ex)
            {
                ErroLogDBOperations db = ErroLogDBOperations.getInstance();
                db.ErrorLog(ex.Message, "In RetrieveBooksList ");

                if (!reader.IsClosed)
                    reader.Close();
                reader.Dispose();
            }
            finally
            {
                command.Dispose();
            }

            return reader;

        }

        public IDataReader RetriveGazetteHoliday()
        {
            IDataReader reader = null;
            SqlCommand command = new SqlCommand();

            try
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = Constants.SP_RetriveGazetteHoliday;
                reader = base.ExecuteReader(command);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception("Oops! Something went wrong.");
            }
            catch (Exception ex)
            {
                ErroLogDBOperations db = ErroLogDBOperations.getInstance();
                db.ErrorLog(ex.Message, "In RetriveGazetteHoliday ");
                if (!reader.IsClosed)
                    reader.Close();
                reader.Dispose();
            }
            finally
            {
                command.Dispose();
            }

            return reader;

        }
        public IDataReader RetrieveBookCheckOutHistory(int bookID)
        {
            IDataReader reader = null;
            SqlCommand command = new SqlCommand();

            try
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = Constants.SP_BookBorrowingHistory;

                command.Parameters.AddWithValue("@BookID", bookID);
                reader = base.ExecuteReader(command);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception("Oops! Something went wrong.");
            }
            catch (Exception ex)
            {
                ErroLogDBOperations db = ErroLogDBOperations.getInstance();
                db.ErrorLog(ex.Message, "In RetrieveBookCheckOutHistory ");

                if (!reader.IsClosed)
                    reader.Close();
                reader.Dispose();
            }
            finally
            {
                command.Dispose();
            }

            return reader;

        }


        public IDataReader RetrieveBookBorrowerDetails(int bookID)
        {
            IDataReader reader = null;
            SqlCommand command = new SqlCommand();

            try
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = Constants.SP_BookBorrowerDetails;

                command.Parameters.AddWithValue("@BookID", bookID);
                reader = base.ExecuteReader(command);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception("Oops! Something went wrong.");
            }
            catch (Exception ex)
            {
                ErroLogDBOperations db = ErroLogDBOperations.getInstance();
                db.ErrorLog(ex.Message, "In RetrieveBookBorrowerDetails ");

                if (!reader.IsClosed)
                    reader.Close();
                reader.Dispose();
            }
            finally
            {
                command.Dispose();
            }

            return reader;

        }


        public int CheckIn(int bookID)
        {
            SqlCommand command = new SqlCommand();
            int result = 0;

            try
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = Constants.SP_CheckIn;

                command.Parameters.AddWithValue("@BookID", bookID);
                result = base.ExecuteNonQuery(command);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception("Oops! Something went wrong.");
            }
            catch (Exception ex)
            {
                ErroLogDBOperations db = ErroLogDBOperations.getInstance();
                db.ErrorLog(ex.Message, "In CheckIn Book insertion");


            }
            finally
            {
                command.Dispose();
            }

            return result;

        }


        public int CheckOut(int bookID, string Name, string MobileNo, string NationalID, DateTime checkOutDate, DateTime ReturnDate)
        {
            SqlCommand command = new SqlCommand();
            int result = 0;

            try
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = Constants.SP_CheckOut;

                command.Parameters.AddWithValue("@BookID", bookID);
                command.Parameters.AddWithValue("@Name", Name);
                command.Parameters.AddWithValue("@MobileNo", MobileNo);
                command.Parameters.AddWithValue("@NationalID", NationalID);
                command.Parameters.AddWithValue("@CheckOutDate", checkOutDate);
                command.Parameters.AddWithValue("@ReturnDate", ReturnDate);

                result = base.ExecuteNonQuery(command);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception("Oops something went wrong.");
            }
            catch (Exception ex)
            {
                ErroLogDBOperations db = ErroLogDBOperations.getInstance();
                db.ErrorLog(ex.Message, "In CheckOut Book insertion");

            }
            finally
            {
                command.Dispose();
            }

            return result;

        }


        //singleton implementation.
        private BookCheckInCheckOutDBOperations()
        { }

        /// <summary>
        /// Return instance for a singleton DB operations class
        /// </summary>
        /// <returns></returns>
        public static BookCheckInCheckOutDBOperations getInstance()
        {
            if (_instance == null)
            {
                _instance = new BookCheckInCheckOutDBOperations();

                _instance.initialize();

            }

            return _instance;

        }


    }

    class Constants
    {
        public const string SP_RetrieveBooks = "usp_RetrieveBooksList";
        public const string SP_BookBorrowingHistory = "usp_getBookBorrowingHistory";
        public const string SP_BookBorrowerDetails = "usp_getBorrowerDetails";
        public const string SP_CheckIn = "usp_CheckInBook";
        public const string SP_CheckOut = "usp_CheckOutBook";
        public const string SP_RetriveGazetteHoliday = "usp_RetriveGazetteHoliday";
        public const string SP_ErrorLog = "usp_ErrorLog";
    }
}
