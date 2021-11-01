---------------------------CREATE DATABASE--------------------
create database DIEPFAMILY
go

use DIEPFAMILY
go

---------------------------CREATE TABLE-------------------------
create table Admins (
	id int primary key identity(1,1),
	ad_username char(20) unique,
	ad_password char(20) not null,
	ad_name nvarchar(50) not null,
)
go

create table Users (
	id int primary key identity(1,1),
	us_username char(20) unique,
	us_password char(20) not null,
	us_firstname nvarchar(50) not null,
	us_lastname nvarchar(50) not null,
	us_address nvarchar(100) not null,
	us_birthday date not null,
	us_gender char(3) not null,
	us_phone char(11) not null,
	us_email char(50),
)
go

create table Products (
	id int primary key identity(1,1),
	adminID int,
	categoriesID int,
	supplierID int,
	pro_name nvarchar(50) not null,
	pro_quantity int not null check(pro_quantity >= 0),
	pro_firstPrice float,
	pro_price float not null,
	pro_description nvarchar(100),
	pro_nsx date,
	pro_hsd date
)
go

create table Transactions (
	id int primary key identity(1,1),
	userID int,
	totalPrice float default 0,
	addressTo nvarchar(100) not null,
	phoneTo char(11) not null,
	note nvarchar(100)
)
go

create table Orders (
	id int primary key identity(1,1),
	userID int,
	transactionID int,
	productID int not null,
	or_quantity int not null Check( or_quantity > 0),
	or_price float default 0,
	unique(userID, transactionID, productID)
)
go


create table Suppliers (
	id int primary key identity(1,1),
	sup_name nvarchar(50) not null,
	sup_phone char(11),
	sup_adddress nvarchar(100)
)
go

create table Categories (
	id int primary key identity(1,1),
	adminID int,
	cate_totalProduct int default 0,
	cate_name char(50) not null
)
go

---------------------------ADD FOREIGN KEY CONSTRAINT-------------------------
ALTER TABLE Categories ADD CONSTRAINT FK_CATEGORIES_ADMINS
FOREIGN KEY (adminID) REFERENCES Admins(id)
GO

ALTER TABLE Products ADD CONSTRAINT FK_PRODUCTS_ADMINS
FOREIGN KEY (adminID) REFERENCES Admins(id)
GO

ALTER TABLE Products ADD CONSTRAINT FK_PRODUCTS_CATEGORIES
FOREIGN KEY (categoriesID) REFERENCES Categories(id)
GO

ALTER TABLE Products ADD CONSTRAINT FK_PRODUCTS_SUPPLIERS
FOREIGN KEY (supplierID) REFERENCES Suppliers(id)
GO

ALTER TABLE Transactions ADD CONSTRAINT FK_TRANSACTIONS_USERS
FOREIGN KEY (userID) REFERENCES Users(id)
GO

ALTER TABLE Orders ADD CONSTRAINT FK_ODERS_USERS
FOREIGN KEY (userId) REFERENCES Users(id)
GO

ALTER TABLE Orders ADD CONSTRAINT FK_ODERS_TRANSACTIONS
FOREIGN KEY (transactionID) REFERENCES Transactions(id)
GO


ALTER TABLE Orders ADD CONSTRAINT FK_ODERS_PRODUCTS
FOREIGN KEY (productID) REFERENCES Products(id)
ON DELETE CASCADE
GO

--------------------------CREATE TRIGGER------------------------------

CREATE TRIGGER Dat_Hang ON Orders AFTER 
INSERT AS
declare @new int, @ssn int, @orid int, @transid int
select @new = ne.or_quantity, @ssn = ne.productID, @orid = ne.id, @transid = ne.transactionID
from inserted ne
BEGIN
	UPDATE Products
	SET pro_quantity = pro_quantity - @new
	WHERE id = @ssn

	UPDATE Orders
	SET or_price = or_quantity * (SELECT pro_price FROM Orders join Products on Orders.productID = Products.id Where Orders.id = @orid)
	WHERE id = @orid

	UPDATE Transactions
	set totalPrice = (select sum(or_price) from Orders where transactionID = @transid group by transactionID )
	where Transactions.id = @transid

END
GO


CREATE TRIGGER Cap_Nhat_Dat_Hang ON Orders AFTER
UPDATE AS
declare @new int, @old int, @ssn int, @orid int, @transid int
select @new = ne.or_quantity, @old = ol.or_quantity, @ssn = ol.productID, @orid = ol.id, @transid = ol.transactionID
from inserted ne, deleted ol
BEGIN
if (@new > @old)
BEGIN
	UPDATE Products
	SET pro_quantity = pro_quantity - (@new - @old)
	WHERE id = @ssn
END
ELSE
	BEGIN
		UPDATE Products
		SET pro_quantity = pro_quantity + (@old - @new)
		WHERE id = @ssn
	END
BEGIN
	UPDATE Transactions
	set totalPrice = 1 * (select sum(or_price) from Orders where transactionID = @transid group by transactionID)
	where id = @transid
	
	UPDATE Orders
	SET or_price = or_quantity * (SELECT pro_price FROM Orders join Products on Orders.productID = Products.id Where Orders.id = @orid)
	WHERE id = @orid
END
END
GO

CREATE TRIGGER Huy_Dat_Hang ON Orders AFTER 
DELETE AS
declare @old int, @ssn int, @transid int
select @old = ol.or_quantity, @ssn = ol.productID, @transid = ol.transactionID
from deleted ol
Begin
	Update Products
	set pro_quantity = pro_quantity + @old
	where id = @ssn

	UPDATE Transactions
	set totalPrice = (select sum(or_price) from Orders where transactionID = @transid group by transactionID )
	where Transactions.id = @transid
End
GO

CREATE TRIGGER Them_San_Pham ON Products AFTER
INSERT AS
declare @ssn int
select @ssn = ne.categoriesID
from inserted ne
BEGIN
	Update Categories
	set cate_totalProduct = (select Count(*) from Products where categoriesID = @ssn group by categoriesID)
	where id = @ssn
END
GO

CREATE TRIGGER Xoa_San_Pham ON Products AFTER
DELETE AS
declare @ssn int
select @ssn = ol.categoriesID
from deleted ol
BEGIN
	Update Categories
	set cate_totalProduct = (select Count(*) from Products where categoriesID = @ssn group by categoriesID)
	where id = @ssn
END
GO


-------------------------------Create Views-------------------------------------
CREATE VIEW USER_CONTACT_VIEW AS
SELECT us_firstname, us_lastname, us_address,us_phone
FROM  Users;
GO

CREATE VIEW HANG_DA_DAT_VIEW AS
SELECT us_firstname, us_lastname, pro_name, or_quantity, us_address,us_phone
FROM  Users, Products, Orders
Where Users.id = Orders.userID and Orders.productID = Products.id;
GO

CREATE VIEW GIAO_HANG_VIEW AS
SELECT us_firstname, us_lastname, pro_name, or_quantity, totalPrice, addressTo,phoneTo
FROM  Users, Products, Orders, Transactions
Where Users.id = Orders.userID and Orders.productID = Products.id and Orders.transactionID = Transactions.id;
GO

CREATE VIEW HANG_TON_KHO_VIEW AS
SELECT id, pro_name, pro_quantity, pro_nsx, pro_hsd
FROM  Products;
GO

CREATE VIEW LOAI_HANG_VIEW AS 
SELECT categoriesID, cate_name, pro_name
FROM Categories, Products
WHERE Categories.id = Products.categoriesID
GROUP BY categoriesID, cate_name,pro_name;
GO

CREATE VIEW NHAP_HANG_VIEW AS
SELECT pro_name, sup_name, sup_phone, sup_adddress
FROM Products, Suppliers
WHERE Products.supplierID = Suppliers.id
GO


----------------------------INSERT DATA---------------------------------

-----ADMIN

INSERT INTO Admins (ad_name, ad_username, ad_password)
VALUES ('Bao Nguyen', 'baonguyen', 'admin')

INSERT INTO Admins(ad_username,ad_password,ad_name)
VALUES ('khadieu', 'admin', 'dieu')

INSERT INTO Admins(ad_username,ad_password,ad_name)
VALUES ('thanhtruc', 'admin', 'truc')

INSERT INTO Admins(ad_username,ad_password,ad_name)
VALUES ('baotung', 'admin', 'tung')

------CATEGORIES

INSERT INTO Categories (adminID, cate_name, cate_totalProduct)
VALUES (1, 'Trà sữa', 0)

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (1, 7, 'bánh kem')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (1, 12, 'bánh su kem')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (1, 50, 'bánh bông lan')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (1, 25, 'bánh gato')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (2, 20, 'bánh mochi')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (2, 27, 'bánh tiramisu')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (2, 17, 'bánh Macaron')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (2, 8, 'bánh donut')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (2, 15, 'bánh táo Mỹ')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (3, 15, 'bánh phô mai')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (3, 6, ' Redvelvet ')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (3, 14, 'bánh bông lan trứng muối')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (3, 33, 'Bánh trifle')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (3, 12, 'cupcake Moise')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (4, 26, 'marshmallow')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (4, 4, 'yogurt')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (4, 7, 'cookie')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (4, 11, 'panna cotta')

INSERT INTO Categories (adminID,cate_totalProduct,cate_name)
VALUES (4, 13, 'trà đào')

--------USER 

INSERT INTO Users (us_firstname, us_lastname, us_username, us_password, us_address, us_birthday, us_gender, us_phone, us_email)
	VALUES ('kha', 'dieu', 'khadieu', 'user', 'Phú Yên', '2001-11-13', 'F', '0123456789', 'khadieu@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('user1', 'user1', 'Nguyễn', 'Hạo', 'TP.HCM', '1993-5-10', 'M','01234566','user1@gmail.com')  

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('uer2', 'user', 'Tiêu', 'Ly', 'TP.HCM', '1997-7-22', 'F','123456789','user2@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('user3', '1234', 'Ân', 'Linh', 'TP.HCM', '1994-6-10', 'F','987654321','user3@gmail.com')


INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('user4', 'user4', 'Võ', 'Khánh', 'Cà Mau', '1995-2-3', 'M','0123456','user4@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('user5', 'user5', 'Máy', 'Ảo', 'Hà Nội', '2002-8-30', 'F','111111111','user5@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('user6', 'huhu', 'Hà', 'My', 'Đồng Nai', '2014-3-25', 'F','12345','user6@gmail.com')


INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('user7', 'user7', 'Trúc', 'Vy', 'Bình Phước', '1999-1-14', 'F','012345678','user7@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('user8', 'user8', 'Huỳnh', 'Vy', 'Đồng Tháp', '2002-5-20', 'F','123456788','user8@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('user9', 'user9', 'Nguyễn', 'My', 'Đồng Nai', '2002-4-9', 'F','1234566','user9@gmail.com')
          
INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('baobao', 'hihi', 'Bảo', 'Bảo', 'Đồng Tháp', '2001-1-10', 'M','01234567','baobao@gmail.com')                                                 

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('laclac', '123', 'Tiểu', 'Lạc', 'TP.HCM', '1999-12-22', 'F','036894521','laclac@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('phieulinh', '1311', 'Phiêu', 'Linh', 'Khánh Hòa', '2001-3-3', 'M','03698524','phieulinh@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('trucpnt', 'truc', 'Cây', 'Trúc', 'Bến Tre', '2001-8-25', 'F','0123456789','trucpnt@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('luvutoo', 'love', 'Bạch', 'Tú', 'Phú Yên', '2001-6-9', 'F','036894005','luvutoo@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('tungdb', '123', 'Tùng', 'Tùng', 'Sóc Trăng', '2001', 'M','03549876','tungdb@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('iuBao', 'pass', 'Trần', 'Trọng', 'TP.HCM', '1996-5-14', 'M','01234555','iubao@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('iuDieu', 'dieu', 'Hoàng', 'Khả', 'Phú Yên', '2005-7-7', 'F','1234444','iudieu@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('iuTruc', 'truc', 'Phan', 'Thanh', 'Bến Tre', '2002-5-9', 'F','123333','iutruc@gmail.com')

INSERT INTO Users (us_username,us_password,us_firstname,us_lastname,us_address ,us_birthday ,us_gender ,us_phone,us_email)
     VALUES ('iuTung', 'tung', 'Diệp', 'Bảo', 'Sóc Trăng', '2001-7-15', 'M','12222','iutung@gmail.com')

--------SUPPLIERS
INSERT INTO Suppliers (sup_name, sup_adddress, sup_phone)
	VALUES ('TocoToco', 'Thủ Đức', '012312321')

INSERT INTO Suppliers (sup_name,sup_phone,sup_adddress)
     VALUES ('cake','123456','Quận 1')

INSERT INTO Suppliers (sup_name,sup_phone,sup_adddress)
     VALUES ('cake2','1234567','Quận 2')

INSERT INTO Suppliers (sup_name,sup_phone,sup_adddress)
     VALUES ('cake3','12345678','Quận 2')

INSERT INTO Suppliers (sup_name,sup_phone,sup_adddress)
     VALUES ('trà sữa','123456789','Quận Gò Vấp')

INSERT INTO Suppliers (sup_name,sup_phone,sup_adddress)
     VALUES ('food','0123456','Thủ Đức')

INSERT INTO Suppliers (sup_name,sup_phone,sup_adddress)
     VALUES ('food2','01234567','Quận 1')

INSERT INTO Suppliers (sup_name,sup_phone,sup_adddress)
     VALUES ('food3','01234568','Quận 5')

INSERT INTO Suppliers (sup_name,sup_phone,sup_adddress)
     VALUES ('Phúc Long','123456789','Quận 3')

INSERT INTO Suppliers (sup_name,sup_phone,sup_adddress)
     VALUES ('suppliers','0123456789','Thủ Đức')

-----------PRODUCTS
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
	VALUES (1, 1, 1, 'Trà sữa ToCo', 100, 10000, 20000, 'ngon lắm', '2021-09-20', '2021-09-21')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
	VALUES (1, 1, 1, 'Trà sữa Thái', 100, 10000, 1000, 'ngon lắm', '2021-09-20', '2021-09-21')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (1, 1, 1, 'Trà Sữa Truyền thống', 50, 10000, 15000, 'rất tuyệt vời', '2021-09-21', '2021-09-28')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (1, 2, 2, 'Bánh kem matcha', 10, 150000, 170000, 'ngon', '2021-09-21', '2021-09-28')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (1, 2, 2,  'Bánh kem socola', 20, 150000, 190000, 'rất ngon', '2021-09-21', '2021-09-28')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (1, 3, 2, 'Bánh su matcha', 100, 320000, 450000, 'ngon', '2021-09-21', '2021-09-30')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (1, 3, 2,  'Bánh su socola', 100, 300000, 400000, 'ngon', '2021-09-21', '2021-09-30')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (1, 4, 3, 'Bánh kem matcha', 70, 300000, 370000, 'ngon', '2021-09-21', '2021-09-28')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (1, 4, 3,  'Bánh kem socola', 50, 250000, 300000, 'rất ngon', '2021-09-21', '2021-09-28')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (1, 5, 3, 'Bánh gato cuộn', 20, 150000, 200000, 'bánh ngon', '2021-10-3', '2021-10-10')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (1, 5, 3,  'Bánh gato', 20, 150000, 190000, 'bánh rất ngon', '2021-10-3', '2021-10-10')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (1, 1, 5, 'Trà Sữa Trân châu ', 50, 10000, 15000, 'rất tuyệt vời', '2021-09-21', '2021-09-28')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (2, 7, 2, 'Bánh tiramisu ly', 10, 50000, 110000, 'ngon hơn tưởng tượng', '2021-09-21', '2021-09-28')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (2, 8, 3,  'Bánh macaron chanh', 20, 150000, 200000, 'rất ngon', '2021-09-21', '2021-09-28')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (2, 9, 5, 'Bánh donut', 100, 400000, 500000, 'ngon', '2021-09-21', '2021-09-29')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (2, 6, 4,  'Bánh mochi matcha', 30, 300000, 400000, 'ngon', '2021-09-21', '2021-09-30')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (3, 10, 3, 'Bánh táo Mỹ', 7, 350000, 420000, 'hơi ngon', '2021-09-21', '2021-09-28')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (3, 11, 6,  'Bánh kem cheese', 10, 270000, 330000, 'rất ngon', '2021-09-26', '2021-10-3')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (3, 12, 3, 'redvelvet hộp', 20, 150000, 200000, 'bánh ngon, thích lắm', '2021-09-26', '2021-10-10')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (4, 12, 3,  'redvelvet ly', 20, 120000, 180000, 'bánh rất ngon', '2021-10-3', '2021-10-10')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (3, 13, 7, 'Bánh bông lan cuộn', 7, 200000, 250000, 'hơi ngon', '2021-09-21', '2021-09-28')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (3, 13, 7,  'Bánh bông lan trứng muối', 10, 200000, 250000, 'rất ngon', '2021-09-26', '2021-10-1')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (3, 14, 8, 'Bánh trifle', 5, 150000, 200000, 'bánh rất ngon', '2021-09-26', '2021-10-10')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (4, 15, 3,  'cupcake Moise chanh', 10, 150000, 180000, 'bánh rất ngon', '2021-10-3', '2021-10-10')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (3, 15, 10, 'cupcake Mouse chanh', 7, 150000, 180000, 'hơi ngon', '2021-09-21', '2021-09-28')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (4, 16, 7,  'marshmallow', 50, 500000, 600000, 'rất ngon', '2021-09-26', '2021-10-1')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (3, 16, 8, 'marshmallow', 20, 450000, 600000, 'bánh rất ngon', '2021-09-26', '2021-10-10')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (4, 17, 9,  'yogurt việt quất', 10, 70000, 100000, 'ngon', '2021-10-3', '2021-10-10')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (4, 17, 9,  'yogurt dâu', 10, 70000, 100000, 'ngon', '2021-10-3', '2021-10-10')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (4, 17, 9,  'yogurt chanh dây', 10, 70000, 100000, 'ngon', '2021-10-3', '2021-10-10')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (4, 18, 10,  'cookie matcha', 10, 150000, 200000, 'ngon', '2021-10-3', '2021-10-13')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (4, 18, 9,  'cookie', 10, 12000, 180000, 'ngon', '2021-10-3', '2021-10-13')

INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (2, 19, 7,  'panna cotta bơ', 10, 100000, 150000, 'rất ngon', '2021-10-3', '2021-10-10')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (2, 19, 7,  'panna cotta bơ', 10, 100000, 150000, 'bơ chưa chín', '2021-09-21', '2021-09-28')
INSERT INTO Products (adminID, categoriesID, supplierID, pro_name, pro_quantity, pro_firstPrice, pro_price, pro_description, pro_nsx, pro_hsd)
     VALUES (2, 20, 1,  'trà đào', 10, 100000, 150000, 'rất ngon', '2021-10-3', '2021-10-10')

---------------TRANSACTIONS 
INSERT INTO Transactions (userID, totalPrice, addressTo, phoneTo, note)
	VALUES (1, 20000, 'spkt', '0123123', 'note')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (1, 50000, 'ktx', '0123456', 'giao hàng')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (2, 150000, 'quận 1', '01234567', 'thèm tà tưa')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (3, 100000, 'ktx', '0123456', 'không có gì')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (4, 120000, 'quận 3', '012345678', 'giao hàng 2')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (5, 50000, 'spkt', '0123456789', 'giao bánh')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (6, 250000, 'ktx', '0123456', 'bánh kem')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (7, 50000, 'gò vấp', '01234566', 'note')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (8, 70000, 'gò vấp', '012345677', 'giao hàng3')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (9, 300000, 'ktx', '12345678', 'giao hàng 4 ')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (10, 500000, 'ktx', '123456', 'mau ăn chóng lớn')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (11, 60000, 'quận5', '1234567', 'giao hàng5')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (12, 80000, 'quận 3', '2345678', 'auto note')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (13, 30000, 'ktx', '0123455', 'hihi')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (14, 70000, 'spkt', '1234566', 'haizzz')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (15, 150000, 'ktx', '0123456', 'chúc mừng sn')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (16, 50000, 'quận 7', '3456', 'note2')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (17, 90000, 'quận 1', '456', 'giao hàng 6')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (18, 30000, 'spkt', '0123', 'giao hàng 7')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (19, 50000, 'ktx', '23456', 'giao hàng 8')
INSERT INTO Transactions (userID,totalPrice,addressTo,phoneTo,note)
     VALUES (10, 45000, 'quận 2', '0123456788', 'giao hàng 9')

---------ORDER

INSERT INTO Orders (userID, transactionID, productID, or_quantity, or_price)
	VALUES (1, 1, 1, 1, 20000)
INSERT INTO Orders(userID, transactionID, productID, or_quantity)
	VALUES(1, 1, 10, 10)
INSERT INTO Orders(userID, transactionID, productID, or_quantity)
	VALUES(1, 2, 1, 10)
INSERT INTO Orders(userID, transactionID, productID, or_quantity)
	VALUES(1, 2, 2, 10)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (1, 3 , 2, 3, 45000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (2, 3 , 1, 4, 60000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (2, 6 , 7, 5, 100000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (5, 5 , 6, 7, 70000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (3, 5 , 1, 4, 60000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (4, 18 , 8, 9, 225000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (6, 15 , 25, 4, 150000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (7, 17 , 21, 3, 50000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (8, 13 , 9, 3, 200000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (9, 8 , 23, 1, 20000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (10, 9 , 28, 6, 250000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (11, 14 , 10, 3, 150000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (12, 16 , 11, 12, 500000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (13, 4 , 4, 6, 225000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (14, 7 , 5, 2, 100000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (15, 20 , 17, 1, 25000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (16, 6 , 23, 9, 500000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (17, 12 , 19, 2, 70000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (18, 18 , 3, 6, 250000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (19, 13 , 6, 4, 200000)
INSERT INTO Orders (userID ,transactionID ,productID ,or_quantity,or_price)
     VALUES (20, 5 , 3, 2, 70000)




