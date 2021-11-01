using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace DBProvider
{
    public class DBLayer
    {
		protected SqlConnection cnn;
		SqlCommand cmd;
		SqlDataAdapter adp;

		string strConnect =
			@"Data Source=DESKTOP-DN9T5FI\SQLEXPRESS;Initial Catalog=DIEPFAMILY;Integrated Security = True";

		public DBLayer()
		{
			cnn = new SqlConnection(strConnect);
			cmd = cnn.CreateCommand();
		}
		// Select query
		public DataSet ExecuteQueryDataSet(string strSQL, CommandType ct,params SqlParameter[] p)
		{
			cmd.CommandText = strSQL;
			cmd.CommandType = ct;
			adp = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
			adp.Fill(ds);
			return ds;
		}

	
		public bool MyExecuteNonQuery(string strSQL, CommandType ct, ref string error, params SqlParameter[] param)
		{
			bool f = false;
			cnn.Open();
			cmd.Parameters.Clear();
			cmd.CommandText = strSQL;
			cmd.CommandType = ct;
			foreach (SqlParameter p in param)
				cmd.Parameters.Add(p);
			try
			{
				cmd.ExecuteNonQuery();
				f = true;
			}
			catch (SqlException ex)
			{
				error = ex.Message;
			}
			finally
			{
				cnn.Close();
			}
			return f;
		}
	}
}
