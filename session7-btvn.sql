CREATE DATABASE QLDTVADKM;
USE QLDTVADKM;

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY, 
FirstName VARCHAR(50),
LastName VARCHAR(50),
Email VARCHAR(100)
);
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Price DECIMAL(10, 2)
);
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
TotalAmount DECIMAL(10, 2),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Promotions (
 PromotionID INT PRIMARY KEY,
 PromotionName VARCHAR(100),
 DiscountPercentage DECIMAL(5, 2)
);
CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
OrderID INT,
SaleDate VARCHAR(100),
SaleAmount DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
DELIMITER $$
CREATE PROCEDURE CalculateMonthlyRevenueAndApplyPromotion(IN monthYear VARCHAR(7), IN revenueThreshold DECIMAL(10, 2))
BEGIN
     DECLARE startDate DATE;
     DECLARE endDate DATE;
     SET startDate = CONCAT(monthYear, '-01');
     SET endDate = LAST_DAY(startDate);
     -- 
     CREATE TEMPORARY TABLE MonthlyRevenue AS
     SELECT o.CustomerID, SUM(TotalAmount) AS TotalRevenue
     FROM Orders o JOIN Sales s ON s.OrderID = o.OrderID
     WHERE s.SaleDate BETWEEN startDate AND endDate
	 GROUP BY CustomerID;
	 -- 
      INSERT INTO Promotions (PromotionID, PromotionName, DiscountPercentage)
      SELECT NULL, CONCAT('Promotion for Customer ', CustomerID), 10.00 
      FROM MonthlyRevenue
      WHERE TotalRevenue > revenueThreshold;
      -- 
      DROP TEMPORARY TABLE MonthlyRevenue;
END $$
DELIMITER ;
CALL CalculateMonthlyRevenueAndApplyPromotion('2024-07', 5000);


 