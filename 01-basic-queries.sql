-- ============================================================================
-- Exercise 1: Basic SQL Queries
-- Use this in SQL Assistant to practice fundamental SELECT statements
-- ============================================================================

-- Set working database
DATABASE ${DB_USERNAME}_DEMO;

-- ============================================================================
-- Task 1: Simple SELECT
-- ============================================================================

-- View all departments
SELECT * FROM DEPARTMENT;

-- View all employees
SELECT * FROM EMPLOYEE;

-- ============================================================================
-- Task 2: SELECT with specific columns
-- ============================================================================

-- Get employee names and titles
SELECT
    FIRST_NAME,
    LAST_NAME,
    JOB_TITLE
FROM EMPLOYEE;

-- Get product names and prices
SELECT
    PRODUCT_NAME,
    UNIT_PRICE,
    IN_STOCK
FROM PRODUCT;

-- ============================================================================
-- Task 3: WHERE clause - filtering data
-- ============================================================================

-- Find employees in department 2 (Engineering)
SELECT
    FIRST_NAME,
    LAST_NAME,
    JOB_TITLE,
    SALARY
FROM EMPLOYEE
WHERE DEPT_ID = 2;

-- Find products priced over $100
SELECT
    PRODUCT_NAME,
    CATEGORY,
    UNIT_PRICE
FROM PRODUCT
WHERE UNIT_PRICE > 100;

-- Find employees hired after 2021
SELECT
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    JOB_TITLE
FROM EMPLOYEE
WHERE HIRE_DATE > DATE '2021-01-01';

-- ============================================================================
-- Task 4: Multiple conditions (AND, OR)
-- ============================================================================

-- Electronics products under $100
SELECT
    PRODUCT_NAME,
    CATEGORY,
    UNIT_PRICE
FROM PRODUCT
WHERE CATEGORY = 'Electronics'
  AND UNIT_PRICE < 100;

-- Employees in Sales or Marketing
SELECT
    FIRST_NAME,
    LAST_NAME,
    DEPT_ID,
    JOB_TITLE
FROM EMPLOYEE
WHERE DEPT_ID IN (1, 3);

-- ============================================================================
-- Task 5: ORDER BY - sorting results
-- ============================================================================

-- Employees by salary (highest first)
SELECT
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    JOB_TITLE
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- Products by category and price
SELECT
    CATEGORY,
    PRODUCT_NAME,
    UNIT_PRICE
FROM PRODUCT
ORDER BY CATEGORY, UNIT_PRICE;

-- ============================================================================
-- Task 6: LIKE operator - pattern matching
-- ============================================================================

-- Find employees with 'Director' in title
SELECT
    FIRST_NAME,
    LAST_NAME,
    JOB_TITLE
FROM EMPLOYEE
WHERE JOB_TITLE LIKE '%Director%';

-- Find products with 'Laptop' in name
SELECT
    PRODUCT_NAME,
    UNIT_PRICE
FROM PRODUCT
WHERE PRODUCT_NAME LIKE '%Laptop%';

-- ============================================================================
-- Task 7: DISTINCT - unique values
-- ============================================================================

-- Get unique departments
SELECT DISTINCT DEPT_ID FROM EMPLOYEE ORDER BY DEPT_ID;

-- Get unique product categories
SELECT DISTINCT CATEGORY FROM PRODUCT ORDER BY CATEGORY;

-- Get unique sales regions
SELECT DISTINCT REGION FROM SALES ORDER BY REGION;

-- ============================================================================
-- Practice Exercise
-- Try these on your own:
-- 1. Find all employees earning more than $70,000
-- 2. List all furniture products
-- 3. Find sales in the 'East' region
-- 4. List employees hired in 2021 or later, sorted by hire date
-- ============================================================================
