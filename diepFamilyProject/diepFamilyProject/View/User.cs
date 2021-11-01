using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using modelUser;


namespace diepFamilyProject
{
    public partial class QLUser : Form
    {
        private DBBusiness db = new DBBusiness();
        private DataSet ds = new DataSet();
       
        public QLUser()
        {
            InitializeComponent();
        }

        private void User_Load(object sender, EventArgs e)
        {
            load_data();
        }
        private void load_data()
        {
            dataGridView1.DataSource = db.getUesr();
        }

        private void btn_capnhat_Click(object sender, EventArgs e)
        {
            
            string err = "";
            if (!db.updateUser(ref err, txb_username.Text, txb_firstname.Text, txb_lastname.Text, txb_address.Text, dt_birth.Value, txb_gender.Text, txb_phone.Text, txb_email.Text, txb_role.Text))
                MessageBox.Show(err);
            else
            {
                load_data();
                clear_frm();
            }
        }

        private void btn_Them_Click(object sender, EventArgs e)
        {
            string err = "";
            if(!db.insertUser(ref err, txb_username.Text, txb_pass.Text, txb_firstname.Text, txb_lastname.Text, txb_address.Text, dt_birth.Value, txb_gender.Text, txb_phone.Text, txb_email.Text, txb_role.Text))
                MessageBox.Show(err);
            else
            {
                load_data();
                clear_frm();
            }
        }
        private void btn_xoa_Click(object sender, EventArgs e)
        {

            string err = "";
            if (!db.delelteUser(ref err, txb_username.Text))
                MessageBox.Show(err);
            else load_data();
        }
        private void btn_thoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void load_Uesrform(string username)
        {
           DataTable dt = db.Search_infoUser(username);
            foreach(DataRow row in dt.Rows)
            {
                txb_username.Text = row["us_username"].ToString();
                txb_firstname.Text = row["us_firstname"].ToString();
                txb_lastname.Text = row["us_lastname"].ToString();
                txb_address.Text = row["us_address"].ToString();
                dt_birth.Text = row["us_birthday"].ToString();
                txb_gender.Text = row["us_gender"].ToString();
                txb_phone.Text = row["us_phone"].ToString();
                txb_email.Text = row["us_email"].ToString();
                txb_pass.Text = row["us_password"].ToString();
                txb_role.Text = row["us_role"].ToString();
            }
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int index = e.RowIndex;
            DataGridViewRow selectesrow = dataGridView1.Rows[index];
            load_Uesrform(selectesrow.Cells[0].Value.ToString());
            txb_pass.Enabled = false;
            txb_role.Enabled = false;
        }
        private void clear_frm()
        {
            txb_pass.Enabled = true;
            txb_role.Enabled = true;

            txb_username.Text = "";
            txb_firstname.Text = "";
            txb_lastname.Text = "";
            txb_address.Text = "";
            dt_birth.Text = "";
            txb_gender.Text = "";
            txb_phone.Text = "";
            txb_email.Text = "";
            txb_pass.Text = "";
            txb_role.Text = "";
        }

        private void btn_clearfrm_Click(object sender, EventArgs e)
        {
            clear_frm();
        }
    }
}
