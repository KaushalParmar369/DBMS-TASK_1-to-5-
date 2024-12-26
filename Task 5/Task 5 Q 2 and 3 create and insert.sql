--TASK 5 Q 2,3

USE [task 5 ];

--create OrderStatus Table
    create table OrderStatus(
	OrderStatusID int primary key,
	[Description] Varchar(30),
	DateModified Date);

	--Create ShipmentMethod Table
    create table ShipmentMethod(
	ShipmentMethodID int primary key,
	ShipmentMode Varchar(15),
	ShipmentClass Varchar(15),
	ShipmentTime Time,
	FreightCost Numeric(5,2),
	DateModified Date);


--Create ShippingAddress Table
    create table ShippingAddress(
	ShippingAddressID int primary Key,
	CustomerID int,
	StreetNumber int,
	StreetName Varchar(30),
	StreetType Varchar(20),
	PostalCode Varchar(6),
	City Varchar(20),
	CountryID int,
	Notes Varchar(50));

	--Creat Customer_Order_Dimensional Table 
   CREATE TABLE Customer_Order_Dimensional(
	OrderID int primary Key,
	CustomerID int,
	OrderStatusID int,
	ShipmentMethodID int,
	ShippingAddressID int,
	EstDateShipped Date,
	DateModified Date,
	ActualDateShipped Date);

--Create  ShippingEfficiency
	create table ShippingEfficiency
(
	OrderStatusID int,
	ShipmentMethodID int,
	ShippingAddressID int,
	OrderID int,
	[Datediff] int, 
	CONSTRAINT [pk] Primary Key(OrderStatusID, ShipmentMethodID, ShippingAddressID, OrderID),
	CONSTRAINT [OrdStatuSID_FK] Foreign key (OrderStatusID) 
		References OrderStatus(OrderStatusID)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT [fk1] Foreign Key (ShipmentMethodID) 
		References ShipmentMethod(ShipmentMethodID)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT [ShipAddrID_FK] Foreign Key (ShippingAddressID) 
		References ShippingAddress(ShippingAddressID)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT [OrdID_FK] Foreign key (OrderID) 
		References Customer_Order_Dimensional (OrderID)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
);

----Insert  into  OrderStatus
Insert into OrderStatus (OrderStatusID,[Description],DateModified) 
values
(20304015,'Delayed','2022-05-01'),
(20304016,'Delivered','2022-08-09'),
(20304017,'In transit','2022-01-09'),
(20304018,'Preparing to ship','2022-03-10'),
(20304019,'Processing order','2022-07-05');

--Insert  into ShipmentMethod
INSERT INTO ShipmentMethod (ShipmentMethodID,ShipmentMode,ShipmentClass,ShipmentTime,FreightCost,DateModified)
 values
 (45600000,'Pickup','Overnight','01:11:23',200.00,'2018-06-23'),
 (45600001,'Air','Priority','08:11:23',100.00,'2018-06-23'),
 (45600002,'Air','Standard','01:11:23',400.00,'2018-06-23'),
 (45600003,'Ground','Overnight','07:11:23',700.00,'2018-06-23'),
 (45600004,'Ground','Standard','04:11:23',400.00,'2018-06-23');

 --Insert  into ShippingAddress
INSERT INTO ShippingAddress (ShippingAddressID,CustomerID,StreetNumber,StreetName,StreetType,PostalCode,City,CountryID, Notes)
values
(4000001,5000004,2,'Creasent','West','N2C0B9','cambridge',111,'Shipping description'),
(4000002,5000005,4,'blockline road','east','V3R5E4','kitchener',111,'Sfhipping description'),
(4000003,5000006,5,'warren road','south','H5H6J1','london',111,'Shipping description'),
(4000004,5000007,6,'silver','east','L0V9J6','Waterloo',111,'Shipping description'),
(4000005,5000008,7,'fadrick','north','M3M2N0','cambridge',111,'Shipping description');


--Insert  into Customer_Order_Dimensional
INSERT INTO Customer_Order_Dimensional (OrderID,CustomerID,OrderStatusID,ShipmentMethodID,ShippingAddressID,EstDateShipped,DateModified,ActualDateShipped)
values
(1200120,5000004,20304015,45600000,4000001,'2011-08-03','2012-04-03','2023-07-07'),
(1200130,5000005,20304016,45600001,4000002,'2017-04-10','2022-07-10','2021-05-16'),
(1200140,5000006,20304017,45600002,4000003,'2020-11-22','2015-11-22','2017-10-22'),
(1200150,5000007,20304018,45600003,4000004,'2022-04-10','2014-04-10','2021-05-12'),
(1200160,5000008,20304019,45600004,4000005,'2023-08-03','2014-07-03','2022-07-04');

--Insert into ShippingEfficiency
Insert into ShippingEfficiency (OrderStatusID, ShipmentMethodID, ShippingAddressID, OrderID, [Datediff] )
values
(20304015, 45600000, 4000001,  1200120, 2),
(20304016, 45600001, 4000002,  1200130, 1),
(20304017, 45600002, 4000003,  1200140, 7),
(20304018, 45600003, 4000004,  1200150, 4),
(20304019, 45600004, 4000005,  1200160, 8);




