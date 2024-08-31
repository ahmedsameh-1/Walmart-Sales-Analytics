-- Create Product Dimension
CREATE TABLE DimProduct (
    ProductKey INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT,
    SupplierName VARCHAR(100),
    CreatedDate DATE
);

-- Create Store Dimension
CREATE TABLE DimStore (
    StoreKey INT PRIMARY KEY IDENTITY(1,1),
    StoreID INT,
    StoreName VARCHAR(100),
    Location VARCHAR(100),
    ManagerID INT,
    OpeningDate DATE
);

-- Create Customer Dimension
CREATE TABLE DimCustomer (
    CustomerKey INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Address VARCHAR(150),
    DateOfBirth DATE,
    RegistrationDate DATE
);

-- Create Employee Dimension
CREATE TABLE DimEmployee (
    EmployeeKey INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    StoreID INT
);


-- Create Sales Fact Table
CREATE TABLE FactSales (
    SalesKey INT PRIMARY KEY IDENTITY(1,1),
    SaleID INT,
    ProductKey INT,
    StoreKey INT,
    CustomerKey INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    SalesPersonKey INT,
    FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey),
    FOREIGN KEY (StoreKey) REFERENCES DimStore(StoreKey),
    FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    FOREIGN KEY (SalesPersonKey) REFERENCES DimEmployee(EmployeeKey)
);
-- Sequence for SaleID
CREATE SEQUENCE SaleID_Seq
AS INT
START WITH 1
INCREMENT BY 1;

-- Sequence for ProductKey
CREATE SEQUENCE ProductKey_Seq
AS INT
START WITH 1
INCREMENT BY 1;

-- Sequence for StoreKey
CREATE SEQUENCE StoreKey_Seq
AS INT
START WITH 1
INCREMENT BY 1;

-- Sequence for CustomerKey
CREATE SEQUENCE CustomerKey_Seq
AS INT
START WITH 1
INCREMENT BY 1;

-- Sequence for SalesPersonKey
CREATE SEQUENCE SalesPersonKey_Seq
AS INT
START WITH 1
INCREMENT BY 1;

