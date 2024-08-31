--Generating Product Table
DECLARE @i INT = 1;
DECLARE @ProductNames TABLE (ProductName VARCHAR(100));

-- Insert random product names into a table variable
INSERT INTO @ProductNames (ProductName)
VALUES 
('Smartphone Model A'),
('Laptop Model X'),
('4K LED TV'),
('Blender Pro'),
('Gaming Console Z'),
('Headphones X100'),
('Espresso Machine Deluxe'),
('Smartwatch Series 5'),
('Fitness Tracker'),
('Electric Kettle'),
('Wireless Speaker'),
('Microwave Oven'),
('Refrigerator Model R'),
('Digital Camera X200'),
('Air Purifier'),
('Gaming Laptop G1'),
('Tablet Model T'),
('Dishwasher Model D'),
('Smart Home Hub'),
('Vacuum Cleaner V7');

-- Loop to insert 10,000 rows
WHILE @i <= 10000
BEGIN
    -- Randomly select a product name
    DECLARE @RandomProductName VARCHAR(100);
    SELECT @RandomProductName = ProductName 
    FROM @ProductNames
    ORDER BY NEWID(); -- Randomly select a row

    INSERT INTO Products (ProductName, Category, Price, StockQuantity, SupplierName, CreatedDate)
    VALUES 
    (
        @RandomProductName,                                      -- Random ProductName
        CASE                                                     -- Category
            WHEN @i % 5 = 0 THEN 'Electronics'
            WHEN @i % 5 = 1 THEN 'Home Appliances'
            WHEN @i % 5 = 2 THEN 'Kitchen Appliances'
            WHEN @i % 5 = 3 THEN 'Gaming'
            ELSE 'Wearable Tech'
        END,
        CAST(50.00 + (RAND() * (1000.00 - 50.00)) AS DECIMAL(10, 2)),  -- Price (random between 50 and 1000)
        ABS(CHECKSUM(NEWID()) % 500 + 1),                          -- StockQuantity (random between 1 and 500)
        CASE                                                     -- SupplierName
            WHEN @i % 4 = 0 THEN 'TechCorp Inc.'
            WHEN @i % 4 = 1 THEN 'HomeGoods Co.'
            WHEN @i % 4 = 2 THEN 'KitchenMaster Ltd.'
            ELSE 'GameStation Inc.'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE())    -- CreatedDate (random date within the last year)
    );

    SET @i = @i + 1;
END;

--Generating Employee Table
DECLARE @i INT = 1;
DECLARE @FirstNames TABLE (FirstName VARCHAR(50));
DECLARE @LastNames TABLE (LastName VARCHAR(50));
DECLARE @Positions TABLE (Position VARCHAR(50));

-- Insert random first names into a table variable
INSERT INTO @FirstNames (FirstName)
VALUES 
('John'), ('Jane'), ('Michael'), ('Sarah'), ('David'), ('Laura'),
('James'), ('Emily'), ('Robert'), ('Linda'), ('William'), ('Jessica'),
('Joseph'), ('Barbara'), ('Thomas'), ('Susan'), ('Charles'), ('Patricia'),
('Christopher'), ('Elizabeth');

-- Insert random last names into a table variable
INSERT INTO @LastNames (LastName)
VALUES 
('Smith'), ('Johnson'), ('Williams'), ('Jones'), ('Brown'), ('Davis'),
('Miller'), ('Wilson'), ('Moore'), ('Taylor'), ('Anderson'), ('Thomas'),
('Jackson'), ('White'), ('Harris'), ('Martin'), ('Thompson'), ('Garcia'),
('Martinez'), ('Robinson');

-- Insert random positions into a table variable
INSERT INTO @Positions (Position)
VALUES 
('Sales Associate'), ('Store Manager'), ('Cashier'), ('Inventory Specialist'),
('Customer Service Representative'), ('Assistant Manager'), ('Marketing Coordinator'),
('HR Specialist'), ('Technician'), ('Security Officer');

-- Loop to insert 10,000 rows
WHILE @i <= 10000
BEGIN
    -- Randomly select a first name
    DECLARE @RandomFirstName VARCHAR(50);
    SELECT @RandomFirstName = FirstName 
    FROM @FirstNames
    ORDER BY NEWID(); -- Randomly select a row

    -- Randomly select a last name
    DECLARE @RandomLastName VARCHAR(50);
    SELECT @RandomLastName = LastName 
    FROM @LastNames
    ORDER BY NEWID(); -- Randomly select a row

    -- Randomly select a position
    DECLARE @RandomPosition VARCHAR(50);
    SELECT @RandomPosition = Position 
    FROM @Positions
    ORDER BY NEWID(); -- Randomly select a row

    INSERT INTO Employees (FirstName, LastName, Position, Salary, HireDate, StoreID)
    VALUES 
    (
        @RandomFirstName,                                      -- Random FirstName
        @RandomLastName,                                       -- Random LastName
        @RandomPosition,                                       -- Random Position
        CAST(30000.00 + (RAND() * (80000.00 - 30000.00)) AS DECIMAL(10, 2)),  -- Salary (random between 30,000 and 80,000)
        DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 3650), GETDATE()), -- HireDate (random date within the last 10 years)
        ABS(CHECKSUM(NEWID()) % 100 + 1)                       -- StoreID (random between 1 and 100)
    );

    SET @i = @i + 1;
END;

--Generating Stores Table
DECLARE @i INT = 1;
DECLARE @TotalManagers INT;
DECLARE @RandomManagerID INT;
DECLARE @StoreNames TABLE (StoreName VARCHAR(100));

-- Insert random store names into a table variable
INSERT INTO @StoreNames (StoreName)
VALUES 
('SuperMart Central'),
('QuickShop Downtown'),
('Grocery World'),
('TechHub Plaza'),
('Fashion Corner'),
('MegaStore Westside'),
('CityMart East'),
('ValueStore Uptown'),
('ExpressMart'),
('ShopEase Center'),
('EcoStore Green'),
('GigaMarket'),
('Urban Market'),
('FamilyMart'),
('HyperStore'),
('FreshFoods'),
('MetroMart'),
('The Bargain Store'),
('DigitalWorld'),
('HomeStyle Depot');

-- Get the total number of managers (assumes managers are already inserted in Employees table)
SELECT @TotalManagers = COUNT(*) FROM Employees;

-- Loop to insert 100 rows
WHILE @i <= 100
BEGIN
    -- Generate a random ManagerID from the sequence
    SET @RandomManagerID = NEXT VALUE FOR ManagerID_Seq;

    -- Make sure the random ManagerID does not exceed the total number of employees
    IF @RandomManagerID > @TotalManagers
        SET @RandomManagerID = @RandomManagerID % @TotalManagers + 1;

    -- Randomly select a store name
    DECLARE @RandomStoreName VARCHAR(100);
    SELECT @RandomStoreName = StoreName 
    FROM @StoreNames
    ORDER BY NEWID(); -- Randomly select a row

    -- Insert a new store record
    INSERT INTO Stores (StoreName, Location, ManagerID, OpeningDate)
    VALUES 
    (
        @RandomStoreName,                                       -- Random StoreName
        CASE                                                    -- Location
            WHEN @i % 5 = 0 THEN 'New York'
            WHEN @i % 5 = 1 THEN 'Los Angeles'
            WHEN @i % 5 = 2 THEN 'Chicago'
            WHEN @i % 5 = 3 THEN 'Houston'
            ELSE 'Phoenix'
        END,
        @RandomManagerID,                                       -- Random ManagerID
        DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 3650), GETDATE()) -- OpeningDate (random date within the last 10 years)
    );

    SET @i = @i + 1;
END;


--Generating Customer Table
DECLARE @i INT = 1;

-- Table variables for random names, domains, and streets
DECLARE @FirstNames TABLE (FirstName VARCHAR(50));
DECLARE @LastNames TABLE (LastName VARCHAR(50));
DECLARE @Domains TABLE (Domain VARCHAR(50));
DECLARE @Streets TABLE (Street VARCHAR(100));

-- Insert random first names
INSERT INTO @FirstNames (FirstName)
VALUES 
('John'), ('Jane'), ('Michael'), ('Sarah'), ('David'), ('Laura'),
('James'), ('Emily'), ('Robert'), ('Linda'), ('William'), ('Jessica'),
('Joseph'), ('Barbara'), ('Thomas'), ('Susan'), ('Charles'), ('Patricia'),
('Christopher'), ('Elizabeth');

-- Insert random last names
INSERT INTO @LastNames (LastName)
VALUES 
('Smith'), ('Johnson'), ('Williams'), ('Jones'), ('Brown'), ('Davis'),
('Miller'), ('Wilson'), ('Moore'), ('Taylor'), ('Anderson'), ('Thomas'),
('Jackson'), ('White'), ('Harris'), ('Martin'), ('Thompson'), ('Garcia'),
('Martinez'), ('Robinson');

-- Insert random email domains
INSERT INTO @Domains (Domain)
VALUES 
('example.com'), ('email.com'), ('mail.com'), ('test.com'), ('sample.com');

-- Insert random street names
INSERT INTO @Streets (Street)
VALUES 
('Main St'), ('Highland Ave'), ('Oak St'), ('Pine St'), ('Maple Ave'),
('Cedar St'), ('Elm St'), ('Park Ave'), ('Washington St'), ('Lakeview Dr');

-- Loop to insert 10,000 rows
WHILE @i <= 10000
BEGIN
    -- Randomly select a first name
    DECLARE @RandomFirstName VARCHAR(50);
    SELECT @RandomFirstName = FirstName 
    FROM @FirstNames
    ORDER BY NEWID(); -- Randomly select a row

    -- Randomly select a last name
    DECLARE @RandomLastName VARCHAR(50);
    SELECT @RandomLastName = LastName 
    FROM @LastNames
    ORDER BY NEWID(); -- Randomly select a row

    -- Generate a random email
    DECLARE @RandomEmail VARCHAR(100);
    SELECT @RandomEmail = LOWER(@RandomFirstName + '.' + @RandomLastName + '@' + Domain)
    FROM @Domains
    ORDER BY NEWID(); -- Randomly select a domain

    -- Generate a random phone number
    DECLARE @RandomPhoneNumber VARCHAR(15);
    SET @RandomPhoneNumber = '555-' + RIGHT('0000' + CAST(ABS(CHECKSUM(NEWID()) % 10000) AS VARCHAR(4)), 4);

    -- Generate a random address
    DECLARE @RandomAddress VARCHAR(150);
    SELECT @RandomAddress = CAST(ABS(CHECKSUM(NEWID()) % 9999 + 1) AS VARCHAR(4)) + ' ' + Street
    FROM @Streets
    ORDER BY NEWID(); -- Randomly select a street

    -- Generate a random date of birth (age between 18 and 78)
    DECLARE @RandomDateOfBirth DATE;
    SET @RandomDateOfBirth = DATEADD(YEAR, -ABS(CHECKSUM(NEWID()) % 60 + 18), GETDATE()); 

    -- Generate a random registration date within the last year
    DECLARE @RandomRegistrationDate DATE;
    SET @RandomRegistrationDate = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE()); -- Random date within the last 365 days

    -- Insert the customer record
    INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, Address, DateOfBirth, RegistrationDate)
    VALUES 
    (
        @RandomFirstName,                                       -- Random FirstName
        @RandomLastName,                                        -- Random LastName
        @RandomEmail,                                           -- Random Email
        @RandomPhoneNumber,                                     -- Random PhoneNumber
        @RandomAddress,                                         -- Random Address
        @RandomDateOfBirth,                                     -- Random DateOfBirth
        @RandomRegistrationDate                                 -- Random RegistrationDate
    );

    SET @i = @i + 1;
END;



--Generating Sales Table
DECLARE @i INT = 1;
DECLARE @TotalProducts INT;
DECLARE @TotalStores INT;
DECLARE @TotalCustomers INT;
DECLARE @TotalSalesPersons INT;

-- Get the total number of rows in each referenced table
SELECT @TotalProducts = COUNT(*) FROM Products;
SELECT @TotalStores = COUNT(*) FROM Stores;
SELECT @TotalCustomers = COUNT(*) FROM Customers;
SELECT @TotalSalesPersons = COUNT(*) FROM Employees;

-- Loop to insert 10,000 rows
WHILE @i <= 10000
BEGIN
    -- Generate random ProductID
    DECLARE @RandomProductID INT;
    SET @RandomProductID = ABS(CHECKSUM(NEWID()) % @TotalProducts) + 1;

    -- Generate random StoreID
    DECLARE @RandomStoreID INT;
    SET @RandomStoreID = ABS(CHECKSUM(NEWID()) % @TotalStores) + 1;

    -- Generate random CustomerID
    DECLARE @RandomCustomerID INT;
    SET @RandomCustomerID = ABS(CHECKSUM(NEWID()) % @TotalCustomers) + 1;

    -- Generate random SalesPersonID
    DECLARE @RandomSalesPersonID INT;
    SET @RandomSalesPersonID = ABS(CHECKSUM(NEWID()) % @TotalSalesPersons) + 1;

    -- Generate a random sale date within the last 365 days
    DECLARE @RandomSaleDate DATE;
    SET @RandomSaleDate = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE()); -- Random date within the last 365 days

    -- Generate random quantity (between 1 and 100)
    DECLARE @RandomQuantity INT;
    SET @RandomQuantity = ABS(CHECKSUM(NEWID()) % 100) + 1;

    -- Calculate total amount (Price * Quantity). Use a fixed price for demonstration
    DECLARE @ProductPrice DECIMAL(10, 2);
    SELECT @ProductPrice = Price FROM Products WHERE ProductID = @RandomProductID;
    DECLARE @TotalAmount DECIMAL(10, 2);
    SET @TotalAmount = @ProductPrice * @RandomQuantity;

    -- Insert the sale record
    INSERT INTO Sales (ProductID, StoreID, CustomerID, SaleDate, Quantity, TotalAmount, SalesPersonID)
    VALUES 
    (
        @RandomProductID,                                       -- Random ProductID
        @RandomStoreID,                                         -- Random StoreID
        @RandomCustomerID,                                     -- Random CustomerID
        @RandomSaleDate,                                        -- Random SaleDate
        @RandomQuantity,                                        -- Random Quantity
        @TotalAmount,                                           -- Total Amount
        @RandomSalesPersonID                                    -- Random SalesPersonID
    );

    SET @i = @i + 1;
END;







