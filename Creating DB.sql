-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT,
    SupplierName VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE()
);

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    StoreID INT 
);

-- Create Stores Table
CREATE TABLE Stores (
    StoreID INT PRIMARY KEY IDENTITY(1,1) ,
    StoreName VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    ManagerID INT,
    OpeningDate DATE,
    CONSTRAINT FK_Manager FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);
CREATE SEQUENCE ManagerID_Seq
AS INT
START WITH 1
INCREMENT BY 1;

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Address VARCHAR(150),
    DateOfBirth DATE,
    RegistrationDate DATE DEFAULT GETDATE()
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    StoreID INT,
    CustomerID INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    SalesPersonID INT,
    CONSTRAINT FK_Product FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT FK_Store FOREIGN KEY (StoreID) REFERENCES Stores(StoreID),
    CONSTRAINT FK_Customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    CONSTRAINT FK_SalesPerson FOREIGN KEY (SalesPersonID) REFERENCES Employees(EmployeeID)
);

CREATE SEQUENCE ProductID_Seq
AS INT
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE StoreID_Seq
AS INT
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE CustomerID_Seq
AS INT
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE SalesPersonID_Seq
AS INT
START WITH 1
INCREMENT BY 1;


CREATE SEQUENCE SaleID_Seq
AS INT
START WITH 1
INCREMENT BY 1;


