-- ============================================================================
-- SYCLOPS Lab Setup - Table Creation and Sample Data
-- Use this script in SQL Assistant (already connected)
-- Users have access to only one database: ${DB_USERNAME}_DEMO
-- ============================================================================

-- ============================================================================
-- Table: DEPARTMENT
-- Stores department information
-- ============================================================================
CREATE TABLE DEPARTMENT (
    DEPT_ID INTEGER NOT NULL,
    DEPT_NAME VARCHAR(50) NOT NULL,
    LOCATION VARCHAR(50),
    MANAGER_ID INTEGER,
    BUDGET DECIMAL(12,2),
    PRIMARY KEY (DEPT_ID)
);

-- ============================================================================
-- Table: EMPLOYEE
-- Stores employee records
-- ============================================================================
CREATE TABLE EMPLOYEE (
    EMP_ID INTEGER NOT NULL,
    FIRST_NAME VARCHAR(50) NOT NULL,
    LAST_NAME VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(100),
    HIRE_DATE DATE,
    DEPT_ID INTEGER,
    SALARY DECIMAL(10,2),
    JOB_TITLE VARCHAR(50),
    PRIMARY KEY (EMP_ID)
);

-- ============================================================================
-- Table: PRODUCT
-- Product catalog
-- ============================================================================
CREATE TABLE PRODUCT (
    PRODUCT_ID INTEGER NOT NULL,
    PRODUCT_NAME VARCHAR(100) NOT NULL,
    CATEGORY VARCHAR(50),
    UNIT_PRICE DECIMAL(8,2),
    IN_STOCK INTEGER,
    PRIMARY KEY (PRODUCT_ID)
);

-- ============================================================================
-- Table: SALES
-- Daily sales transactions
-- ============================================================================
CREATE TABLE SALES (
    SALE_ID INTEGER NOT NULL,
    SALE_DATE DATE,
    PRODUCT_ID INTEGER,
    QUANTITY INTEGER,
    SALE_AMOUNT DECIMAL(10,2),
    CUSTOMER_ID INTEGER,
    REGION VARCHAR(20),
    PRIMARY KEY (SALE_ID)
);

-- ============================================================================
-- Insert Sample Data - DEPARTMENT
-- ============================================================================
INSERT INTO DEPARTMENT VALUES (1, 'Sales', 'New York', 1001, 500000.00);
INSERT INTO DEPARTMENT VALUES (2, 'Engineering', 'San Francisco', 1002, 1200000.00);
INSERT INTO DEPARTMENT VALUES (3, 'Marketing', 'Chicago', 1003, 300000.00);
INSERT INTO DEPARTMENT VALUES (4, 'Finance', 'New York', 1004, 400000.00);
INSERT INTO DEPARTMENT VALUES (5, 'Operations', 'Austin', 1005, 350000.00);

-- ============================================================================
-- Insert Sample Data - EMPLOYEE
-- ============================================================================
INSERT INTO EMPLOYEE VALUES (1001, 'Sarah', 'Johnson', 'sarah.j@company.com', DATE '2020-01-15', 1, 85000.00, 'Sales Director');
INSERT INTO EMPLOYEE VALUES (1002, 'Michael', 'Chen', 'michael.c@company.com', DATE '2019-03-20', 2, 125000.00, 'Engineering Director');
INSERT INTO EMPLOYEE VALUES (1003, 'Emily', 'Rodriguez', 'emily.r@company.com', DATE '2021-06-10', 3, 75000.00, 'Marketing Director');
INSERT INTO EMPLOYEE VALUES (1004, 'David', 'Kumar', 'david.k@company.com', DATE '2018-11-05', 4, 95000.00, 'Finance Director');
INSERT INTO EMPLOYEE VALUES (1005, 'Lisa', 'Williams', 'lisa.w@company.com', DATE '2022-02-28', 5, 70000.00, 'Operations Director');

INSERT INTO EMPLOYEE VALUES (2001, 'James', 'Smith', 'james.s@company.com', DATE '2021-04-12', 1, 65000.00, 'Sales Manager');
INSERT INTO EMPLOYEE VALUES (2002, 'Anna', 'Lee', 'anna.l@company.com', DATE '2020-08-15', 2, 105000.00, 'Senior Engineer');
INSERT INTO EMPLOYEE VALUES (2003, 'Robert', 'Taylor', 'robert.t@company.com', DATE '2022-01-20', 2, 95000.00, 'Software Engineer');
INSERT INTO EMPLOYEE VALUES (2004, 'Maria', 'Garcia', 'maria.g@company.com', DATE '2021-09-08', 3, 55000.00, 'Marketing Analyst');
INSERT INTO EMPLOYEE VALUES (2005, 'John', 'Brown', 'john.b@company.com', DATE '2023-03-15', 1, 60000.00, 'Sales Representative');

-- ============================================================================
-- Insert Sample Data - PRODUCT
-- ============================================================================
INSERT INTO PRODUCT VALUES (101, 'Laptop Pro 15', 'Electronics', 1299.99, 50);
INSERT INTO PRODUCT VALUES (102, 'Wireless Mouse', 'Electronics', 29.99, 200);
INSERT INTO PRODUCT VALUES (103, 'USB-C Hub', 'Electronics', 49.99, 150);
INSERT INTO PRODUCT VALUES (104, 'Office Chair Deluxe', 'Furniture', 399.99, 30);
INSERT INTO PRODUCT VALUES (105, 'Standing Desk', 'Furniture', 599.99, 25);
INSERT INTO PRODUCT VALUES (106, 'Monitor 27"', 'Electronics', 349.99, 75);
INSERT INTO PRODUCT VALUES (107, 'Keyboard Mechanical', 'Electronics', 129.99, 100);
INSERT INTO PRODUCT VALUES (108, 'Webcam HD', 'Electronics', 79.99, 60);
INSERT INTO PRODUCT VALUES (109, 'Desk Lamp LED', 'Furniture', 39.99, 120);
INSERT INTO PRODUCT VALUES (110, 'Notebook Set', 'Supplies', 12.99, 500);

-- ============================================================================
-- Insert Sample Data - SALES
-- ============================================================================
INSERT INTO SALES VALUES (1, DATE '2024-01-05', 101, 2, 2599.98, 5001, 'East');
INSERT INTO SALES VALUES (2, DATE '2024-01-05', 102, 5, 149.95, 5002, 'West');
INSERT INTO SALES VALUES (3, DATE '2024-01-06', 104, 1, 399.99, 5003, 'East');
INSERT INTO SALES VALUES (4, DATE '2024-01-06', 106, 3, 1049.97, 5001, 'Central');
INSERT INTO SALES VALUES (5, DATE '2024-01-07', 101, 1, 1299.99, 5004, 'West');
INSERT INTO SALES VALUES (6, DATE '2024-01-07', 107, 2, 259.98, 5005, 'East');
INSERT INTO SALES VALUES (7, DATE '2024-01-08', 105, 1, 599.99, 5002, 'West');
INSERT INTO SALES VALUES (8, DATE '2024-01-08', 110, 20, 259.80, 5006, 'Central');
INSERT INTO SALES VALUES (9, DATE '2024-01-09', 103, 10, 499.90, 5003, 'East');
INSERT INTO SALES VALUES (10, DATE '2024-01-09', 108, 4, 319.96, 5007, 'West');
INSERT INTO SALES VALUES (11, DATE '2024-01-10', 106, 2, 699.98, 5001, 'East');
INSERT INTO SALES VALUES (12, DATE '2024-01-10', 109, 8, 319.92, 5008, 'Central');
INSERT INTO SALES VALUES (13, DATE '2024-01-11', 101, 3, 3899.97, 5004, 'West');
INSERT INTO SALES VALUES (14, DATE '2024-01-11', 102, 15, 449.85, 5009, 'East');
INSERT INTO SALES VALUES (15, DATE '2024-01-12', 104, 2, 799.98, 5005, 'Central');

-- ============================================================================
-- Verification Queries
-- ============================================================================
SELECT 'DEPARTMENT' AS TABLE_NAME, COUNT(*) AS ROW_COUNT FROM DEPARTMENT
UNION ALL
SELECT 'EMPLOYEE', COUNT(*) FROM EMPLOYEE
UNION ALL
SELECT 'PRODUCT', COUNT(*) FROM PRODUCT
UNION ALL
SELECT 'SALES', COUNT(*) FROM SALES
;

SELECT 'Setup Complete!' AS STATUS;
