/*
Tasks to be performed:*/


---1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.
select * from Jomato

create or alter procedure sp_TablebookingStatus
AS
BEGIN
 select RestaurantName, RestaurantType,CuisinesType from Jomato
 where TableBooking != 0
END


EXEC sp_TablebookingStatus

----2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result
       --and rollback it.
begin transaction
update Jomato
set CuisinesType = 'Cafeteria'
where CuisinesType = 'Cafe'

Select *from Jomato
Where CuisinesType = 'Cafeteria'
ROLLBACK TRANSACTION

--3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.
select TOP 5  Area, 
      Rating,
	  ROW_NUMBER()OVER ( ORDER BY Rating DESC) AS TOp5_Areas
from Jomato

-- 4. Use the while loop to display the 1 to 50.

DECLARE @Number INT = 1;

WHILE @Number <= 50
BEGIN
    PRINT @Number
    SET @Number = @Number + 1
END


--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of
 -- restaurants.
CREATE OR ALTER VIEW vw_Top_RAtingRestaurants
AS
select TOP 5 Area, 
      Rating,
	  ROW_NUMBER()OVER ( ORDER BY Rating DESC) AS TOp5_Areas
from Jomato


SELECT * FROM vw_Top_RAtingRestaurants

--6. Write a trigger that sends an email notification to the restaurant owner whenever a new
   --record is inserted

SELECT * from Jomato

CREATE TABLE EmailNotification
(
OrderId smallint ,
InsertedDate DATETIME DEFAULT (GETDATE()),
Operation VARCHAR(100),
Status VARCHAR(100)
)


CREATE OR ALTER TRIGGER NotifyAfterInsert
ON dbo.Jomato
FOR INSERT
AS
SELECT  'A NEW RECORD IS INSERTED'
      INSERT INTO EmailNotification( OrderId, Operation, Status)
	  SELECT OrderId ,'INSERT', 'New Entry Found Inserted'
	  FROM INSERTED
GO;

INSERT INTO Jomato
SELECT 7105,'TableTous' , 'Quick Bites',	5.90000009536743 ,255,	700,	0,	1,	'Arabian'	,'Church Street',	'Frazer Town',	61
SELECT 7106,'Darbar' , 'Quick Bites',	3.90000009536743 ,250,	600,	1,	0,	'Arabian'	,'Church Street',	'JP Nagar',	67
SELECT 7107,'Mayur','Casual Dining', 2.50000009536743 ,24,	700, 0,	1,	'Arabian' ,'Malleshwaram',	'Brookfield',	68, 'Bad'

select * from  Jomato
select * from EmailNotification




