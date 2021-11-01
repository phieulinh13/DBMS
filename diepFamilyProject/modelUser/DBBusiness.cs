using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using DBProvider;

namespace modelUser
{
    public class DBBusiness : DBLayer
    { 

        public DataTable getUesr()
        {
            SqlDataAdapter ds = new SqlDataAdapter(
                "SELECT us_username ,us_firstname,us_lastname,us_address,us_birthday,us_gender,us_phone ,us_email FROM [dbo].[User]", this.cnn );
            DataTable dtuser = new DataTable();
            ds.Fill(dtuser);
            return dtuser;
        }
        public DataTable Search_infoUser(string username)
        {
            SqlDataAdapter ds = new SqlDataAdapter("EXEC sp_SearchInfoUser '"+ username+"';", this.cnn);
            DataTable search_user = new DataTable();
            ds.Fill(search_user);
            return search_user;          
        }
        
        public bool insertUser(ref string err, string username, string password, string firstname, string lastname, string address, DateTime birthday, string gender, string phone, string email, string role)
        {
            return this.MyExecuteNonQuery(
                "sp_InsertUser", CommandType.StoredProcedure, ref err,
                new SqlParameter("@username", username),
                new SqlParameter("@password", password),
                new SqlParameter("@firstname", firstname),
                new SqlParameter("@lastname", lastname),
                new SqlParameter("@address", address),
                new SqlParameter("@birthday", birthday),
                new SqlParameter("@gender", gender),
                new SqlParameter("@phone", phone),
                new SqlParameter("@email", email),
                new SqlParameter("@role", role)
                );
        }
        public bool delelteUser(ref string err, string username)
        {
            return this.MyExecuteNonQuery(
                "sp_AdDeleteUser",
                CommandType.StoredProcedure, ref err,
                new SqlParameter("@username", username));
        }

        public bool updateUser(ref string err,
           string username, string firstname, string lastname,
           string address, DateTime birthday, string gender, string phone,
           string email, string role)
        {
            return this.MyExecuteNonQuery(
                "sp_AdUpdateUser", CommandType.StoredProcedure, ref err,
                new SqlParameter("@username", username),
                new SqlParameter("@firstname", firstname),
                new SqlParameter("@lastname", lastname),
                new SqlParameter("@address", address),
                new SqlParameter("@birthday", birthday),
                new SqlParameter("@gender", gender),
                new SqlParameter("@phone", phone),
                new SqlParameter("@email", email),
                new SqlParameter("@role", role)
                );
        }

    }
}
