USE Company
GO

---------------------------------------------
--������� ��������� ���� ������ ���� ������ �� ��������� �� ��������� ���� ������� �������� 2022 ���� � 23:59:59.9999999.
---------------------------------------------
--Clients
SELECT *
FROM Clients FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999';

SELECT *
FROM Clients FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999';

SELECT *
FROM Clients FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999';

SELECT *
FROM Clients FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999';


--Orders
SELECT *
FROM Orders FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999';

SELECT *
FROM Orders FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999';

SELECT *
FROM Orders FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999';

SELECT *
FROM Orders FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999';

--DeliveryCompany
SELECT *
FROM DeliveryCompany FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999';

SELECT *
FROM DeliveryCompany FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999';

SELECT *
FROM DeliveryCompany FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999';

SELECT *
FROM DeliveryCompany FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999';

--Items
SELECT *
FROM Items FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999';

SELECT *
FROM Items FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999';

SELECT *
FROM Items FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999';

SELECT *
FROM Items FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999';

--Method_of_Delivery
SELECT *
FROM Method_of_Delivery FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999';

SELECT *
FROM Method_of_Delivery FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999';

SELECT *
FROM Method_of_Delivery FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999';

SELECT *
FROM Method_of_Delivery FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999';










---------------------------------------------
--������� ��������� ���� ������ ���� ������ �� ���� 2022 ����.
---------------------------------------------
SELECT *
FROM Method_of_Delivery FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'
ORDER BY deliveryQuerry

SELECT *
FROM Clients FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'
ORDER BY clientId

SELECT *
FROM Orders FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'
ORDER BY orderId

SELECT *
FROM DeliveryCompany FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'
ORDER BY companyId

SELECT *
FROM Items FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'
ORDER BY itemId







---------------------------------------------
--������� ������, ������� ���� ��������� � ������� �� ������ ������� 2022 ����.
---------------------------------------------

SELECT StartDate,EndDate
FROM DeliveryCompany FOR SYSTEM_TIME CONTAINED IN ('2022-07-01','2022-09-30 23:59:59.9999999')
ORDER BY companyId

SELECT  *
FROM Clients FOR SYSTEM_TIME CONTAINED IN ('2022-07-01','2022-09-30 23:59:59.9999999')
ORDER BY clientId

SELECT *
FROM Items FOR SYSTEM_TIME CONTAINED IN ('2022-07-01','2022-09-30 23:59:59.9999999')
ORDER BY itemId

SELECT *
FROM Orders FOR SYSTEM_TIME CONTAINED IN ('2022-07-01','2022-09-30 23:59:59.9999999')
ORDER BY orderId

SELECT *
FROM Method_of_Delivery FOR SYSTEM_TIME CONTAINED IN ('2022-07-01','2022-09-30 23:59:59.9999999')
ORDER BY deliveryQuerry

---------------------------------------------
--������� ����� ������ � ����������� ������������� ���������, ��������� JOIN.
---------------------------------------------

SELECT B.clientId, I.name
FROM Orders B 
	INNER JOIN Clients I ON B.clientId=I.clientId 
GROUP BY B.clientId, I.name
