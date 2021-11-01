using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace modelUser
{
    class UserModel
    {
        private string username;
        private string password;
        private string firstname;
        private string lastname;
        private string address;
        private DateTime birthday;
        private string gender;
        private string phone;
        private string email;
        private string role;

        public string Username { get => username; set => username = value; }
        public string Password { get => password; set => password = value; }
        public string Firstname { get => firstname; set => firstname = value; }
        public string Lastname { get => lastname; set => lastname = value; }
        public string Address { get => address; set => address = value; }
        public DateTime Birthday { get => birthday; set => birthday = value; }
        public string Gender { get => gender; set => gender = value; }
        public string Phone { get => phone; set => phone = value; }
        public string Email { get => email; set => email = value; }
        public string Role { get => role; set => role = value; }

        public UserModel() { 
        
        }
        public UserModel(string username, string password, string firstname, string lastname, string address, DateTime birthday, string gender, string phone, string email, string role)
        {
            this.username = username;
            this.password = password;
            this.firstname = firstname;
            this.lastname = lastname;
            this.address = address;
            this.birthday = birthday;
            this.gender = gender;
            this.phone = phone;
            this.email = email;
            this.role = role;
        }
    }
}
