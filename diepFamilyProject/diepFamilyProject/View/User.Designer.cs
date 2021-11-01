
namespace diepFamilyProject
{
    partial class QLUser
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.username = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.firstname = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.lastname = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.address = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.birthday = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.gender = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.phone = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.email = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.label1 = new System.Windows.Forms.Label();
            this.txb_username = new System.Windows.Forms.TextBox();
            this.txb_pass = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txb_role = new System.Windows.Forms.TextBox();
            this.lbrole = new System.Windows.Forms.Label();
            this.txb_firstname = new System.Windows.Forms.TextBox();
            this.ldfirstname = new System.Windows.Forms.Label();
            this.txb_lastname = new System.Windows.Forms.TextBox();
            this.lblastname = new System.Windows.Forms.Label();
            this.txb_address = new System.Windows.Forms.TextBox();
            this.lb_address = new System.Windows.Forms.Label();
            this.txb_phone = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.txb_gender = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.btn_Them = new System.Windows.Forms.Button();
            this.btn_capnhat = new System.Windows.Forms.Button();
            this.btn_xoa = new System.Windows.Forms.Button();
            this.btn_thoat = new System.Windows.Forms.Button();
            this.dt_birth = new System.Windows.Forms.DateTimePicker();
            this.txb_email = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.btn_clearfrm = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dataGridView1);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(1007, 265);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Danh sách người dùng";
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.username,
            this.firstname,
            this.lastname,
            this.address,
            this.birthday,
            this.gender,
            this.phone,
            this.email});
            this.dataGridView1.Location = new System.Drawing.Point(0, 28);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 51;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.Size = new System.Drawing.Size(1007, 237);
            this.dataGridView1.TabIndex = 0;
            this.dataGridView1.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellClick);
            // 
            // username
            // 
            this.username.DataPropertyName = "us_username";
            this.username.HeaderText = "Username";
            this.username.MinimumWidth = 6;
            this.username.Name = "username";
            this.username.Width = 125;
            // 
            // firstname
            // 
            this.firstname.DataPropertyName = "us_firstname";
            this.firstname.HeaderText = "Firstname";
            this.firstname.MinimumWidth = 6;
            this.firstname.Name = "firstname";
            this.firstname.Width = 125;
            // 
            // lastname
            // 
            this.lastname.DataPropertyName = "us_lastname";
            this.lastname.HeaderText = "Lastname";
            this.lastname.MinimumWidth = 6;
            this.lastname.Name = "lastname";
            this.lastname.Width = 125;
            // 
            // address
            // 
            this.address.DataPropertyName = "us_address";
            this.address.HeaderText = "Address";
            this.address.MinimumWidth = 6;
            this.address.Name = "address";
            this.address.Width = 125;
            // 
            // birthday
            // 
            this.birthday.DataPropertyName = "us_birthday";
            this.birthday.HeaderText = "Birthday";
            this.birthday.MinimumWidth = 6;
            this.birthday.Name = "birthday";
            this.birthday.Width = 125;
            // 
            // gender
            // 
            this.gender.DataPropertyName = "us_gender";
            this.gender.HeaderText = "Gender";
            this.gender.MinimumWidth = 6;
            this.gender.Name = "gender";
            this.gender.Width = 125;
            // 
            // phone
            // 
            this.phone.DataPropertyName = "us_phone";
            this.phone.HeaderText = "Phone";
            this.phone.MinimumWidth = 6;
            this.phone.Name = "phone";
            this.phone.Width = 125;
            // 
            // email
            // 
            this.email.DataPropertyName = "us_email";
            this.email.HeaderText = "Email";
            this.email.MinimumWidth = 6;
            this.email.Name = "email";
            this.email.Width = 125;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(28, 312);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(104, 22);
            this.label1.TabIndex = 1;
            this.label1.Text = "User name: ";
            // 
            // txb_username
            // 
            this.txb_username.Location = new System.Drawing.Point(138, 312);
            this.txb_username.Name = "txb_username";
            this.txb_username.Size = new System.Drawing.Size(190, 22);
            this.txb_username.TabIndex = 2;
            // 
            // txb_pass
            // 
            this.txb_pass.Location = new System.Drawing.Point(138, 358);
            this.txb_pass.Name = "txb_pass";
            this.txb_pass.Size = new System.Drawing.Size(190, 22);
            this.txb_pass.TabIndex = 4;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(28, 358);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(104, 22);
            this.label2.TabIndex = 3;
            this.label2.Text = "Password:  ";
            // 
            // txb_role
            // 
            this.txb_role.Location = new System.Drawing.Point(138, 405);
            this.txb_role.Name = "txb_role";
            this.txb_role.Size = new System.Drawing.Size(190, 22);
            this.txb_role.TabIndex = 6;
            // 
            // lbrole
            // 
            this.lbrole.AutoSize = true;
            this.lbrole.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbrole.Location = new System.Drawing.Point(28, 405);
            this.lbrole.Name = "lbrole";
            this.lbrole.Size = new System.Drawing.Size(59, 22);
            this.lbrole.TabIndex = 5;
            this.lbrole.Text = "Role: ";
            // 
            // txb_firstname
            // 
            this.txb_firstname.Location = new System.Drawing.Point(479, 313);
            this.txb_firstname.Name = "txb_firstname";
            this.txb_firstname.Size = new System.Drawing.Size(190, 22);
            this.txb_firstname.TabIndex = 8;
            // 
            // ldfirstname
            // 
            this.ldfirstname.AutoSize = true;
            this.ldfirstname.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ldfirstname.Location = new System.Drawing.Point(369, 312);
            this.ldfirstname.Name = "ldfirstname";
            this.ldfirstname.Size = new System.Drawing.Size(104, 22);
            this.ldfirstname.TabIndex = 7;
            this.ldfirstname.Text = "First name: ";
            // 
            // txb_lastname
            // 
            this.txb_lastname.Location = new System.Drawing.Point(479, 359);
            this.txb_lastname.Name = "txb_lastname";
            this.txb_lastname.Size = new System.Drawing.Size(190, 22);
            this.txb_lastname.TabIndex = 10;
            // 
            // lblastname
            // 
            this.lblastname.AutoSize = true;
            this.lblastname.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblastname.Location = new System.Drawing.Point(369, 359);
            this.lblastname.Name = "lblastname";
            this.lblastname.Size = new System.Drawing.Size(100, 22);
            this.lblastname.TabIndex = 9;
            this.lblastname.Text = "Last name: ";
            // 
            // txb_address
            // 
            this.txb_address.Location = new System.Drawing.Point(479, 407);
            this.txb_address.Name = "txb_address";
            this.txb_address.Size = new System.Drawing.Size(190, 22);
            this.txb_address.TabIndex = 12;
            // 
            // lb_address
            // 
            this.lb_address.AutoSize = true;
            this.lb_address.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_address.Location = new System.Drawing.Point(369, 407);
            this.lb_address.Name = "lb_address";
            this.lb_address.Size = new System.Drawing.Size(87, 22);
            this.lb_address.TabIndex = 11;
            this.lb_address.Text = "Address: ";
            // 
            // txb_phone
            // 
            this.txb_phone.Location = new System.Drawing.Point(806, 406);
            this.txb_phone.Name = "txb_phone";
            this.txb_phone.Size = new System.Drawing.Size(190, 22);
            this.txb_phone.TabIndex = 18;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(696, 406);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(69, 22);
            this.label7.TabIndex = 17;
            this.label7.Text = "Phone: ";
            // 
            // txb_gender
            // 
            this.txb_gender.Location = new System.Drawing.Point(806, 358);
            this.txb_gender.Name = "txb_gender";
            this.txb_gender.Size = new System.Drawing.Size(190, 22);
            this.txb_gender.TabIndex = 16;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(696, 358);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(79, 22);
            this.label8.TabIndex = 15;
            this.label8.Text = "Gender: ";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(696, 311);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(89, 22);
            this.label9.TabIndex = 13;
            this.label9.Text = "Birthday: ";
            // 
            // btn_Them
            // 
            this.btn_Them.Font = new System.Drawing.Font("Times New Roman", 13.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Them.Location = new System.Drawing.Point(41, 502);
            this.btn_Them.Name = "btn_Them";
            this.btn_Them.Size = new System.Drawing.Size(157, 48);
            this.btn_Them.TabIndex = 19;
            this.btn_Them.Text = "Thêm";
            this.btn_Them.UseVisualStyleBackColor = true;
            this.btn_Them.Click += new System.EventHandler(this.btn_Them_Click);
            // 
            // btn_capnhat
            // 
            this.btn_capnhat.Font = new System.Drawing.Font("Times New Roman", 13.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_capnhat.Location = new System.Drawing.Point(237, 502);
            this.btn_capnhat.Name = "btn_capnhat";
            this.btn_capnhat.Size = new System.Drawing.Size(157, 48);
            this.btn_capnhat.TabIndex = 20;
            this.btn_capnhat.Text = "Cập nhật";
            this.btn_capnhat.UseVisualStyleBackColor = true;
            this.btn_capnhat.Click += new System.EventHandler(this.btn_capnhat_Click);
            // 
            // btn_xoa
            // 
            this.btn_xoa.Font = new System.Drawing.Font("Times New Roman", 13.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_xoa.Location = new System.Drawing.Point(444, 502);
            this.btn_xoa.Name = "btn_xoa";
            this.btn_xoa.Size = new System.Drawing.Size(157, 48);
            this.btn_xoa.TabIndex = 22;
            this.btn_xoa.Text = "Xóa";
            this.btn_xoa.UseVisualStyleBackColor = true;
            this.btn_xoa.Click += new System.EventHandler(this.btn_xoa_Click);
            // 
            // btn_thoat
            // 
            this.btn_thoat.Font = new System.Drawing.Font("Times New Roman", 13.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_thoat.Location = new System.Drawing.Point(839, 502);
            this.btn_thoat.Name = "btn_thoat";
            this.btn_thoat.Size = new System.Drawing.Size(157, 48);
            this.btn_thoat.TabIndex = 23;
            this.btn_thoat.Text = "Thoát";
            this.btn_thoat.UseVisualStyleBackColor = true;
            this.btn_thoat.Click += new System.EventHandler(this.btn_thoat_Click);
            // 
            // dt_birth
            // 
            this.dt_birth.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dt_birth.Location = new System.Drawing.Point(806, 311);
            this.dt_birth.Name = "dt_birth";
            this.dt_birth.Size = new System.Drawing.Size(200, 22);
            this.dt_birth.TabIndex = 24;
            // 
            // txb_email
            // 
            this.txb_email.Location = new System.Drawing.Point(806, 454);
            this.txb_email.Name = "txb_email";
            this.txb_email.Size = new System.Drawing.Size(190, 22);
            this.txb_email.TabIndex = 26;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(696, 454);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(68, 22);
            this.label3.TabIndex = 25;
            this.label3.Text = "Email: ";
            // 
            // btn_clearfrm
            // 
            this.btn_clearfrm.Font = new System.Drawing.Font("Times New Roman", 13.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_clearfrm.Location = new System.Drawing.Point(643, 502);
            this.btn_clearfrm.Name = "btn_clearfrm";
            this.btn_clearfrm.Size = new System.Drawing.Size(157, 48);
            this.btn_clearfrm.TabIndex = 27;
            this.btn_clearfrm.Text = "Clear";
            this.btn_clearfrm.UseVisualStyleBackColor = true;
            this.btn_clearfrm.Click += new System.EventHandler(this.btn_clearfrm_Click);
            // 
            // User
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1033, 578);
            this.Controls.Add(this.btn_clearfrm);
            this.Controls.Add(this.txb_email);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.dt_birth);
            this.Controls.Add(this.btn_thoat);
            this.Controls.Add(this.btn_xoa);
            this.Controls.Add(this.btn_capnhat);
            this.Controls.Add(this.btn_Them);
            this.Controls.Add(this.txb_phone);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.txb_gender);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.txb_address);
            this.Controls.Add(this.lb_address);
            this.Controls.Add(this.txb_lastname);
            this.Controls.Add(this.lblastname);
            this.Controls.Add(this.txb_firstname);
            this.Controls.Add(this.ldfirstname);
            this.Controls.Add(this.txb_role);
            this.Controls.Add(this.lbrole);
            this.Controls.Add(this.txb_pass);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txb_username);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.groupBox1);
            this.Name = "User";
            this.Text = "User";
            this.Load += new System.EventHandler(this.User_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.DataGridViewTextBoxColumn username;
        private System.Windows.Forms.DataGridViewTextBoxColumn firstname;
        private System.Windows.Forms.DataGridViewTextBoxColumn lastname;
        private System.Windows.Forms.DataGridViewTextBoxColumn address;
        private System.Windows.Forms.DataGridViewTextBoxColumn birthday;
        private System.Windows.Forms.DataGridViewTextBoxColumn gender;
        private System.Windows.Forms.DataGridViewTextBoxColumn phone;
        private System.Windows.Forms.DataGridViewTextBoxColumn email;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txb_username;
        private System.Windows.Forms.TextBox txb_pass;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txb_role;
        private System.Windows.Forms.Label lbrole;
        private System.Windows.Forms.TextBox txb_firstname;
        private System.Windows.Forms.Label ldfirstname;
        private System.Windows.Forms.TextBox txb_lastname;
        private System.Windows.Forms.Label lblastname;
        private System.Windows.Forms.TextBox txb_address;
        private System.Windows.Forms.Label lb_address;
        private System.Windows.Forms.TextBox txb_phone;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txb_gender;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Button btn_Them;
        private System.Windows.Forms.Button btn_capnhat;
        private System.Windows.Forms.Button btn_xoa;
        private System.Windows.Forms.Button btn_thoat;
        private System.Windows.Forms.DateTimePicker dt_birth;
        private System.Windows.Forms.TextBox txb_email;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button btn_clearfrm;
    }
}