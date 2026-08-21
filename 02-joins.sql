-- ============================================================================
-- Exercise 2: JOIN Operations
-- Practice combining data from multiple tables
-- ============================================================================

-- ============================================================================
-- Task 1: INNER JOIN - matching records in both tables
-- ============================================================================

-- Employees with their department names
SELECT
    e.EMP_ID,
    e.FIRST_NAME,
    e.LAST_NAME,
    e.JOB_TITLE,
    d.DEPT_NAME,
    d.LOCATION
FROM EMPLOYEE e
INNER JOIN DEPARTMENT d ON e.DEPT_ID = d.DEPT_ID
ORDER BY d.DEPT_NAME, e.LAST_NAME;

-- Sales with product details
SELECT
    s.SALE_ID,
    s.SALE_DATE,
    p.PRODUCT_NAME,
    p.CATEGORY,
    s.QUANTITY,
    s.SALE_AMOUNT,
    s.REGION
FROM SALES s
INNER JOIN PRODUCT p ON s.PRODUCT_ID = p.PRODUCT_ID
ORDER BY s.SALE_DATE;

-- ============================================================================
-- Task 2: Multiple column selection from joined tables
-- ============================================================================

-- Employee directory with full department info
SELECT
    e.FIRST_NAME || ' ' || e.LAST_NAME AS EMPLOYEE_NAME,
    e.EMAIL,
    e.JOB_TITLE,
    d.DEPT_NAME,
    d.LOCATION,
    e.HIRE_DATE,
    e.SALARY
FROM EMPLOYEE e
INNER JOIN DEPARTMENT d ON e.DEPT_ID = d.DEPT_ID
ORDER BY d.DEPT_NAME, EMPLOYEE_NAME;

-- ============================================================================
-- Task 3: JOIN with WHERE clause
-- ============================================================================

-- Engineering department employees only
SELECT
    e.FIRST_NAME,
    e.LAST_NAME,
    e.JOB_TITLE,
    e.SALARY,
    d.DEPT_NAME
FROM EMPLOYEE e
INNER JOIN DEPARTMENT d ON e.DEPT_ID = d.DEPT_ID
WHERE d.DEPT_NAME = 'Engineering'
ORDER BY e.SALARY DESC;

-- Electronics sales with product names
SELECT
    s.SALE_DATE,
    p.PRODUCT_NAME,
    p.UNIT_PRICE,
    s.QUANTITY,
    s.SALE_AMOUNT,
    s.REGION
FROM SALES s
INNER JOIN PRODUCT p ON s.PRODUCT_ID = p.PRODUCT_ID
WHERE p.CATEGORY = 'Electronics'
ORDER BY s.SALE_DATE;

-- ============================================================================
-- Task 4: Three-way JOIN
-- ============================================================================

-- Sales with product and theoretical employee info
-- (Note: SALES doesn't have EMP_ID in this schema, but shows the pattern)
SELECT
    s.SALE_DATE,
    p.PRODUCT_NAME,
    p.CATEGORY,
    s.QUANTITY,
    s.SALE_AMOUNT,
    s.REGION
FROM SALES s
INNER JOIN PRODUCT p ON s.PRODUCT_ID = p.PRODUCT_ID
ORDER BY s.SALE_DATE, p.PRODUCT_NAME;

-- ============================================================================
-- Task 5: Self JOIN - comparing rows within the same table
-- ============================================================================

-- Find employees in the same department
SELECT
    e1.FIRST_NAME || ' ' || e1.LAST_NAME AS EMPLOYEE_1,
    e2.FIRST_NAME || ' ' || e2.LAST_NAME AS EMPLOYEE_2,
    e1.DEPT_ID AS DEPARTMENT
FROM EMPLOYEE e1
INNER JOIN EMPLOYEE e2
    ON e1.DEPT_ID = e2.DEPT_ID
    AND e1.EMP_ID < e2.EMP_ID
ORDER BY e1.DEPT_ID, EMPLOYEE_1;

-- ============================================================================
-- Task 6: JOIN with aggregation
-- ============================================================================

-- Total sales by product
SELECT
    p.PRODUCT_NAME,
    p.CATEGORY,
    COUNT(s.SALE_ID) AS NUM_SALES,
    SUM(s.QUANTITY) AS TOTAL_QUANTITY,
    SUM(s.SALE_AMOUNT) AS TOTAL_REVENUE
FROM PRODUCT p
INNER JOIN SALES s ON p.PRODUCT_ID = s.PRODUCT_ID
GROUP BY p.PRODUCT_NAME, p.CATEGORY
ORDER BY TOTAL_REVENUE DESC;

-- ============================================================================
-- Task 7: LEFT JOIN - include all from left table
-- ============================================================================

-- All products with their sales count (including products with no sales)
SELECT
    p.PRODUCT_NAME,
    p.CATEGORY,
    COUNT(s.SALE_ID) AS SALES_COUNT,
    COALESCE(SUM(s.SALE_AMOUNT), 0) AS TOTAL_REVENUE
FROM PRODUCT p
LEFT JOIN SALES s ON p.PRODUCT_ID = s.PRODUCT_ID
GROUP BY p.PRODUCT_NAME, p.CATEGORY
ORDER BY SALES_COUNT DESC, p.PRODUCT_NAME;

-- ============================================================================
-- Practice Exercises:
-- 1. List all employees with their manager's name (using DEPARTMENT.MANAGER_ID)
-- 2. Find the top 5 best-selling products by revenue
-- 3. Show departments with their employee count and average salary
-- ============================================================================
