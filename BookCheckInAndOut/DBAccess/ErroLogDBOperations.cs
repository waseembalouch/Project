using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace DBAccess
{
    public class ErroLogDBOperations : Database
    {
        private static ErroLogDBOperations _instance;

        private new void initialize()
        {
            try
            {
                base.initialize();
            }
            catch (Exception ex)
            {
                ErrorLog(ex.Message, "In CheckIn Book insertion");

            }
        }




        public int ErrorLog(string exceptionMessage, string url)
        {
            SqlCommand command = new SqlCommand();
            int result = 0;

            try
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = Constants.SP_ErrorLog;

                command.Parameters.AddWithValue("@ExceptionMessage", exceptionMessage);
                command.Parameters.AddWithValue("@PageURL", url);

                result = base.ExecuteNonQuery(command);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception("Oops! Something went wrong.");
            }
            catch
            {
                //Do logging..


            }
            finally
            {
                command.Dispose();
            }

            return result;

        }


        //singleton implementation.
        private ErroLogDBOperations()
        { }

        /// <summary>
        /// Return instance for a singleton DB operations class
        /// </summary>
        /// <returns></returns>
        public static ErroLogDBOperations getInstance()
        {
            if (_instance == null)
            {
                _instance = new ErroLogDBOperations();

                _instance.initialize();

            }

            return _instance;

        }


    }


}

