using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using modelUser;

namespace diepFamilyProject
{
    public partial class Form1 : Form
    {
        private DBBusiness db = new DBBusiness();
        private DataSet ds = new DataSet();
        public Form1()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {

        }
    }
}
