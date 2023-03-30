Use master;
go
drop database if exists Company;
go
create database Company;
go
use Company;	
go

CREATE VIEW V
AS SELECT RAND() AS R
GO

CREATE VIEW V2
AS SELECT RAND(checksum(newid())) AS R2
GO

--�������

CREATE FUNCTION get_random_telephone_number()
RETURNS BIGINT
BEGIN
	DECLARE @TELEPHONE AS BIGINT=0
	SELECT @TELEPHONE=(SELECT CAST(FLOOR((SELECT R FROM V)*888888889) AS bigint))
	RETURN @TELEPHONE
END
GO

CREATE FUNCTION return_phone_number_by_clientId(@clientId as nvarchar(50))
RETURNS BIGINT
BEGIN
	DECLARE @RESULT AS BIGINT=0
	SELECT @RESULT=(SELECT c.phone from Clients as c where @clientId=c.clientId)
	RETURN @RESULT
END
GO

CREATE FUNCTION get_random_clientName()
RETURNS NVARCHAR(50)
BEGIN
	DECLARE @NAME AS NVARCHAR(50)
	SELECT @NAME = (SELECT TOP 1 clientName FROM RandomData ORDER BY (SELECT R2 FROM V2))
	RETURN @NAME
END
GO

CREATE FUNCTION get_address()
RETURNS NVARCHAR(50)
BEGIN
	DECLARE @ADDRESS AS NVARCHAR(50)
	SELECT @ADDRESS = (SELECT TOP 1 address FROM RandomData ORDER BY (SELECT R2 FROM V2))
	RETURN @ADDRESS
END
GO

CREATE FUNCTION is_delivery()
RETURNS NVARCHAR(50)
BEGIN
	DECLARE @DELIVERY AS NVARCHAR(50)
	SELECT @DELIVERY = (SELECT TOP 1 delivery FROM RandomData ORDER BY (SELECT R2 FROM V2))
	RETURN @DELIVERY
END
GO
CREATE FUNCTION get_method_delivery()
RETURNS NVARCHAR(50)
BEGIN
	DECLARE @METHOD AS NVARCHAR(50)
	SELECT @METHOD = (SELECT TOP 1 method FROM RandomData ORDER BY (SELECT R2 FROM V2))
	RETURN @METHOD
END
GO

CREATE FUNCTION get_description()
RETURNS NVARCHAR(50)
BEGIN
	DECLARE @DESCRIPTION AS NVARCHAR(50)
	SELECT @DESCRIPTION = (SELECT TOP 1 description FROM RandomData ORDER BY (SELECT R2 FROM V2))
	RETURN @DESCRIPTION
END
GO

CREATE FUNCTION get_date()
RETURNS DATE
BEGIN
	DECLARE @DATE AS DATE
	SELECT @DATE = (SELECT TOP 1 date FROM RandomData ORDER BY (SELECT R2 FROM V2))
	RETURN @DATE
END
GO








--�������

CREATE TABLE [Clients] (
	clientId nvarchar(50) NOT NULL,
	name nvarchar(50) NOT NULL,
	address nvarchar(50) NOT NULL,
	phone BIGINT CONSTRAINT CHECK_TELEPHONE_CLIENT CHECK (phone > 0),
  CONSTRAINT [PK_CLIENTS] PRIMARY KEY CLUSTERED
  (
  [clientId] ASC
  ) WITH (IGNORE_DUP_KEY = OFF),
  StartDate DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	EndDate DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate)
)
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ClientsHistory))
GO

CREATE TABLE [Items] (
	itemId nvarchar(50) NOT NULL,
	price money CONSTRAINT CHECK_ITEM_PRICE CHECK (price>0),
	delivery nvarchar(50) NOT NULL,
	[description] nvarchar(50) NOT NULL,
  CONSTRAINT [PK_ITEMS] PRIMARY KEY CLUSTERED
  (
  [itemId] ASC
  ) WITH (IGNORE_DUP_KEY = OFF),
  StartDate DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	EndDate DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate)

)
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ItemsHistory))
GO

CREATE TABLE [Orders] (
	clientId nvarchar(50) NOT NULL,
	orderId nvarchar(50) NOT NULL,
	itemId nvarchar(50) NOT NULL,
	amount int CONSTRAINT CHECK_ITEMS_AMOUNT CHECK(amount>0),
	[date] date NOT NULL,
  CONSTRAINT [PK_ORDERS] PRIMARY KEY CLUSTERED
  (
  [orderId] ASC
  ) WITH (IGNORE_DUP_KEY = OFF),
  StartDate DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	EndDate DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate)

)
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.OrdersHistory))
GO

CREATE TABLE [Method_of_Delivery] (
	deliveryQuerry INT IDENTITY NOT NULL PRIMARY KEY CLUSTERED,
	Cost money CONSTRAINT CHECK_DELIVERY_PRICE CHECK (cost>0),
	delivery nvarchar(50) NOT NULL,
	[date] date NOT NULL,
	itemId nvarchar(50) NOT NULL,
	method nvarchar(50) NOT NULL,
	StartDate DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	EndDate DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate)
)
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.MethodOfDeliveryHistory))
GO

CREATE TABLE [DeliveryCompany] (
	companyId INT IDENTITY NOT NULL PRIMARY KEY CLUSTERED,
	clientId nvarchar(50) NOT NULL,
	address nvarchar(50) NOT NULL,
	phone BIGINT CONSTRAINT CHECK_TELEPHONE_COMPANY CHECK (phone > 0),
	StartDate DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	EndDate DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate)
)
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.DeliveryCompanyHistory))
GO

 CREATE TABLE [RandomData] (
	clientName nvarchar(50) NOT NULL,
	address nvarchar(50) NOT NULL,
	delivery nvarchar(50),
	description nvarchar(50) NOT NULL,
	date nvarchar(50) NOT NULL,
	method nvarchar(50) NOT NULL
)
GO

ALTER TABLE [Orders] WITH CHECK ADD CONSTRAINT [Orders_fk0] FOREIGN KEY ([clientId]) REFERENCES [Clients]([clientId])
ON UPDATE CASCADE
GO
ALTER TABLE [Orders] CHECK CONSTRAINT [Orders_fk0]
GO
ALTER TABLE [Orders] WITH CHECK ADD CONSTRAINT [Orders_fk1] FOREIGN KEY ([itemId]) REFERENCES [Items]([itemId])
ON UPDATE CASCADE
GO
ALTER TABLE [Orders] CHECK CONSTRAINT [Orders_fk1]
GO

ALTER TABLE [Method_of_Delivery] WITH CHECK ADD CONSTRAINT [Method_of_Delivery_fk0] FOREIGN KEY ([itemId]) REFERENCES [Items]([itemId])
ON UPDATE CASCADE
GO
ALTER TABLE [Method_of_Delivery] CHECK CONSTRAINT [Method_of_Delivery_fk0]
GO

ALTER TABLE [DeliveryCompany] WITH CHECK ADD CONSTRAINT [Company_fk0] FOREIGN KEY ([clientId]) REFERENCES [Clients]([clientId])
ON UPDATE CASCADE
GO
ALTER TABLE [DeliveryCompany] CHECK CONSTRAINT [Company_fk0]
GO



--------------------------
--05.01.2022
--------------------------

INSERT INTO [RandomData](clientName, address, delivery, description, date, method)
VALUES
	('������','����������','��', '�����','20231011', '���������'),
	('�����', '������','���','�����','20050506','�������'),
	('������','�������','���','�������','20300519','������'),
	('������','������������','��','�������','20050819','�������������'),
	('�������','����','���','�������','20401210','����������'),
	('������','��������','��','������','20180314','�������'),
	('����','��������','��','��� �� ��-�����','20230415','������'),
	('������','��������','��','����','20201211','�������������'),
	('�������','�����','���','������� �����','20190817','�� �����'),
	('���','�����','���','������� �����','20190817','�� �����')
GO


INSERT INTO Clients(clientId, name, address, phone)
VALUES
    ('1a','�������', '���������', [dbo].get_random_telephone_number()),
    ('2a','�����', '����������', [dbo].get_random_telephone_number()),
    ('3a','������', '��������', [dbo].get_random_telephone_number()),
    ('4a','�����', '��������', [dbo].get_random_telephone_number()),
    ('5a','�������', '�������� ��������', [dbo].get_random_telephone_number()),
    ('6a','�����', '������� ������', [dbo].get_random_telephone_number()),
    ('7a','������', '�����������', [dbo].get_random_telephone_number()),
    ('8a','������', '������� ������', [dbo].get_random_telephone_number()),
    ('9a','����', '������� ����� ������', [dbo].get_random_telephone_number()),
    ('10a','������', '���� �����������', [dbo].get_random_telephone_number())
GO



INSERT INTO [DeliveryCompany](clientId, address, phone)
VALUES
	('1a', '�����������', [dbo].return_phone_number_by_clientId('1a')),
	('2a', '�������������', [dbo].return_phone_number_by_clientId('2a')),
	('3a', '������������', [dbo].return_phone_number_by_clientId('3a')),
	('4a', '���������� �����', [dbo].return_phone_number_by_clientId('4a')),
	('5a', '������������', [dbo].return_phone_number_by_clientId('5a')),
	('6a', '������������', [dbo].return_phone_number_by_clientId('6a')),
	('7a', '�����������', [dbo].return_phone_number_by_clientId('7a')),
	('8a', '������', [dbo].return_phone_number_by_clientId('8a')),
	('9a', '�����������', [dbo].return_phone_number_by_clientId('9a')),
	('10a', '����������', [dbo].return_phone_number_by_clientId('10a'))
GO


INSERT INTO Items(itemid, price, delivery, [description])
VALUES
    ('1b', 20, '��', '����� ��������'),
	('2b', 10, '��', '����� ��� ���������'),
	('3b', 13, '���', '�����'),
	('4b', 30, '��', '����'),
	('5b', 1000, '��', '������ ��'),
	('6b', 27, '���', '������� �����'),
	('7b', 15, '��', '�������'),
	('8b', 12, '���', '��������'),
	('9b', 2000, '��', '������� Apple'),
	('10b', 32, '��', '����������')
GO

INSERT INTO Orders(clientId, orderId, itemId, amount, [date])
VALUES
    ('1a', '1c', '1b', 1, '20220105'),
	('2a', '2c', '2b', 2, '20220105'),
	('3a', '3c', '3b', 3, '20220105'),
	('4a', '4c', '4b', 4, '20220105'),
	('5a', '5c', '5b', 1, '20220105'),
	('6a', '6c', '6b', 3, '20220105'),
	('7a', '7c', '7b', 10, '20220105'),
	('8a', '8c', '8b', 1, '20220105'),
	('9a', '9c', '9b', 1, '20220105'),
	('10a', '10c', '10b', 1, '20220105')
GO

INSERT INTO Method_of_Delivery(itemId, delivery, [date], Cost, method)
VALUES
	('1b','��', '20220120', 40, [dbo].get_method_delivery()),
	('2b','��', '20220130', 10, [dbo].get_method_delivery()),
	('3b','���', '20220111', 15, [dbo].get_method_delivery()),
	('4b','��', '20220210', 315, [dbo].get_method_delivery()),
	('5b','��', '20220210', 34, [dbo].get_method_delivery()),
	('6b','���', '20220210', 34, [dbo].get_method_delivery()),
	('7b','��', '20220210', 34, [dbo].get_method_delivery()),
	('8b','���', '20220210', 34, [dbo].get_method_delivery()),
	('9b','��', '20220210', 34, [dbo].get_method_delivery()),
	('10b','���', '20220210', 34, [dbo].get_method_delivery())
GO



SELECT * FROM Clients
SELECT * FROM DeliveryCompany
SELECT * FROM ITEMS
SELECT * FROM Method_of_Delivery
SELECT * FROM Orders
SELECT * FROM RandomData