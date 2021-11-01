-------------------------------CREATE DATABASE--------------------
--create database DIEPFAMILY
--go

use DIEPFAMILY
go

-------------------------------CREATE TABLE-------------------------
--create table Admins (
--	id int primary key identity(1,1),
--	ad_username char(20) unique,
--	ad_password char(20) not null,
--	ad_name nvarchar(50) not null,
--)
--go

--create table Users (
--	id int primary key identity(1,1),
--	us_username char(20) unique,
--	us_password char(20) not null,
--	us_firstname nvarchar(50) not null,
--	us_lastname nvarchar(50) not null,
--	us_address nvarchar(100) not null,
--	us_birthday date not null,
--	us_gender char(3) not null,
--	us_phone char(11) not null,
--	us_email char(50),
--)
--go

--create table Products (
--	id int primary key identity(1,1),
--	adminID int,
--	categoriesID int,
--	supplierID int,
--	pro_name nvarchar(50) not null,
--	pro_quantity int not null check(pro_quantity >= 0),
--	pro_firstPrice float,
--	pro_price float not null,
--	pro_description nvarchar(100),
--	pro_nsx date,
--	pro_hsd date
--)
--go

--create table Transactions (
--	id int primary key identity(1,1),
--	userID int,
--	totalPrice float default 0,
--	addressTo nvarchar(100) not null,
--	phoneTo char(11) not null,
--	note nvarchar(100)
--)
--go

--create table Orders (
--	id int primary key identity(1,1),
--	userID int,
--	transactionID int,
--	productID int not null,
--	or_quantity int not null Check( or_quantity > 0),
--	or_price float default 0,
--	unique(userID, transactionID, productID)
--)
--go


--create table Suppliers (
--	id int primary key identity(1,1),
--	sup_name nvarchar(50) not null,
--	sup_phone char(11),
--	sup_adddress nvarchar(100)
--)
--go

--create table Categories (
--	id int primary key identity(1,1),
--	adminID int,
--	cate_totalProduct int default 0,
--	cate_name char(50) not null
--)


-------------------------------ADD FOREIGN KEY CONSTRAINT-------------------------
--ALTER TABLE Categories ADD CONSTRAINT FK_CATEGORIES_ADMINS
--FOREIGN KEY (adminID) REFERENCES Admins(id)
--GO

--ALTER TABLE Products ADD CONSTRAINT FK_PRODUCTS_ADMINS
--FOREIGN KEY (adminID) REFERENCES Admins(id)
--GO

--ALTER TABLE Products ADD CONSTRAINT FK_PRODUCTS_CATEGORIES
--FOREIGN KEY (categoriesID) REFERENCES Categories(id)
--GO

--ALTER TABLE Products ADD CONSTRAINT FK_PRODUCTS_SUPPLIERS
--FOREIGN KEY (supplierID) REFERENCES Suppliers(id)
--GO

--ALTER TABLE Transactions ADD CONSTRAINT FK_TRANSACTIONS_USERS
--FOREIGN KEY (userID) REFERENCES Users(id)
--GO

--ALTER TABLE Orders ADD CONSTRAINT FK_ODERS_USERS
--FOREIGN KEY (userId) REFERENCES Users(id)
--GO

--ALTER TABLE Orders ADD CONSTRAINT FK_ODERS_TRANSACTIONS
--FOREIGN KEY (transactionID) REFERENCES Transactions(id)
--GO

--ALTER TABLE Orders ADD CONSTRAINT FK_ODERS_PRODUCTS
--FOREIGN KEY (productID) REFERENCES Products(id)
--GO

---------------------------------INNSERT DATA---------------------------
--INSERT INTO Admins (ad_name, ad_username, ad_password)
--VALUES ('Bao Nguyen', 'baonguyen', 'admin')

--INSERT INTO Users (us_firstname, us_lastname, us_username, us_password, us_address, us_birthday, us_gender, us_phone, us_email)
--VALUES ('kha', 'dieu', 'khadieu', 'user', 'Phú Yên', '2001-11-13', 'Nu', '0123456789', 'khadieu@gmail.com')

--INSERT INTO Categories (adminID, cate_name, cate_totalProduct)
--VALUES (1, 'Trà sữa', 0)

--INSERT INTO Suppliers (sup_name, sup_adddress, sup_phone)
--VALUES ('TocoToco', 'Thủ Đức', '012312321')

--INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
--VALUES (1, 1, 1, 'Trà sữa ToCo', 100, 10000, 20000, 'ngon lắm', '2021-09-20', '2021-09-21')

--INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
--VALUES (1, 1, 1, 'Trà sữa Thái', 100, 10000, 1000, 'ngon lắm', '2021-09-20', '2021-09-21')

--INSERT INTO Transactions (userID, totalPrice, addressTo, phoneTo, note)
--VALUES (1, 20000, 'spkt', '0123123', 'note')

--INSERT INTO Orders (userID, transactionID, productID, or_quantity, or_price)
--VALUES (1, 1, 1, 1, 20000)


------------------------------CREATE TRIGGER------------------------------


--CREATE TRIGGER Dat_Hang ON Orders AFTER 
--INSERT AS
--declare @new int, @ssn int, @orid int, @transid int
--select @new = ne.or_quantity, @ssn = ne.productID, @orid = ne.id, @transid = ne.transactionID
--from inserted ne
--BEGIN
--	UPDATE Products
--	SET pro_quantity = pro_quantity - @new
--	WHERE id = @ssn

--	UPDATE Orders
--	SET or_price = or_quantity * (SELECT pro_price FROM Orders join Products on Orders.productID = Products.id Where Orders.id = @orid)
--	WHERE id = @orid

--	UPDATE Transactions
--	set totalPrice = (select sum(or_price) from Orders where transactionID = @transid group by transactionID )
--	where Transactions.id = @transid

--END
--GO


--CREATE TRIGGER Cap_Nhat_Dat_Hang ON Orders AFTER
--UPDATE AS
--declare @new int, @old int, @ssn int, @orid int, @transid int
--select @new = ne.or_quantity, @old = ol.or_quantity, @ssn = ol.productID, @orid = ol.id, @transid = ne.transactionID
--from inserted ne, deleted ol
--BEGIN
--if (@new > @old)
--BEGIN
--	UPDATE Products
--	SET pro_quantity = pro_quantity - (@new - @old)
--	WHERE id = @ssn
--END
--ELSE
--	BEGIN
--		UPDATE Products
--		SET pro_quantity = pro_quantity + (@old - @new)
--		WHERE id = @ssn
--	END
--BEGIN
--	UPDATE Transactions
--	set totalPrice = (select sum(or_price) from Orders where transactionID = @transid group by transactionID )
--	where Transactions.id = @transid
	
--	UPDATE Orders
--	SET or_price = or_quantity * (SELECT pro_price FROM Orders join Products on Orders.productID = Products.id Where Orders.id = @orid)
--	WHERE id = @orid
--END

--END
--GO


--CREATE TRIGGER Huy_Dat_Hang ON Orders AFTER 
--DELETE AS
--declare @old int, @ssn int, @transid int
--select @old = ol.or_quantity, @ssn = ol.productID, @transid = ol.transactionID
--from deleted ol
--Begin
--	Update Products
--	set pro_quantity = pro_quantity + @old
--	where id = @ssn

--	UPDATE Transactions
--	set totalPrice = (select sum(or_price) from Orders where transactionID = @transid group by transactionID )
--	where Transactions.id = @transid
--End
--GO


------------------------------CROP TABLE-----------------------------
--------drop table Admins
--------drop table Categories
--------drop table Users
--------drop table Products
--drop table Orders
--------drop table Suppliers
--------drop table Transactions

------------------------------------CROP FOREGIN KEY CONSTRAINT---------------------

--------ALTER TABLE Categories DROP CONSTRAINT FK_CATEGORIES_ADMINS
--------GO

--------ALTER TABLE Products DROP CONSTRAINT FK_PRODUCTS_ADMINS
--------GO

--------ALTER TABLE Products DROP CONSTRAINT FK_PRODUCTS_CATEGORIES
--------GO

--------ALTER TABLE Products DROP CONSTRAINT FK_PRODUCTS_SUPPLIERS
--------GO

--------ALTER TABLE Transactions DROP CONSTRAINT FK_TRANSACTIONS_USERS
--------GO

--ALTER TABLE Orders DROP CONSTRAINT FK_ODERS_USERS
--GO

--ALTER TABLE Orders DROP CONSTRAINT FK_ODERS_TRANSACTIONS
--GO

--ALTER TABLE Orders DROP CONSTRAINT FK_ODERS_PRODUCTS
--GO


