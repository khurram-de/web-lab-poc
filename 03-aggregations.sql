-- ============================================================================
-- Exercise 3: Aggregations and GROUP BY
-- Practice summary statistics and grouping
-- ============================================================================

DATABASE ${DB_USERNAME}_DEMO;

-- ============================================================================
-- Task 1: Basic aggregate functions
-- ============================================================================

-- Department statistics
SELECT
    COUNT(*) AS TOTAL_DEPARTMENTS,
    SUM(BUDGET) AS TOTAL_BUDGET,
    AVG(BUDGET) AS AVG_BUDGET,
    MIN(BUDGET) AS MIN_BUDGET,
    MAX(BUDGET) AS MAX_BUDGET
FROM DEPARTMENT;

-- Employee statistics
SELECT
    COUNT(*) AS TOTAL_EMPLOYEES,
    AVG(SALARY) AS AVG_SALARY,
    MIN(SALARY) AS MIN_SALARY,
    MAX(SALARY) AS MAX_SALARY,
    MIN(HIRE_DATE) AS EARLIEST_HIRE,
    MAX(HIRE_DATE) AS LATEST_HIRE
FROM EMPLOYEE;

-- ============================================================================
-- Task 2: GROUP BY - single column
-- ============================================================================

-- Employee count by department
SELECT
    DEPT_ID,
    COUNT(*) AS EMPLOYEE_COUNT,
    AVG(SALARY) AS AVG_SALARY,
    MIN(SALARY) AS MIN_SALARY,
    MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY DEPT_ID;

-- Sales count and revenue by region
SELECT
    REGION,
    COUNT(*) AS SALE_COUNT,
    SUM(QUANTITY) AS TOTAL_QUANTITY,
    SUM(SALE_AMOUNT) AS TOTAL_REVENUE,
    AVG(SALE_AMOUNT) AS AVG_SALE_AMOUNT
FROM SALES
GROUP BY REGION
ORDER BY TOTAL_REVENUE DESC;

-- ============================================================================
-- Task 3: GROUP BY - multiple columns
-- ============================================================================

-- Product inventory by category
SELECT
    CATEGORY,
    COUNT(*) AS PRODUCT_COUNT,
    SUM(IN_STOCK) AS TOTAL_INVENTORY,
    AVG(UNIT_PRICE) AS AVG_PRICE,
    MIN(UNIT_PRICE) AS MIN_PRICE,
    MAX(UNIT_PRICE) AS MAX_PRICE
FROM PRODUCT
GROUP BY CATEGORY
ORDER BY CATEGORY;

-- Sales by date and region
SELECT
    SALE_DATE,
    REGION,
    COUNT(*) AS NUM_TRANSACTIONS,
    SUM(SALE_AMOUNT) AS DAILY_REVENUE
FROM SALES
GROUP BY SALE_DATE, REGION
ORDER BY SALE_DATE, REGION;

-- ============================================================================
-- Task 4: HAVING clause - filtering groups
-- ============================================================================

-- Departments with average salary over $80,000
SELECT
    DEPT_ID,
    COUNT(*) AS EMPLOYEE_COUNT,
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING AVG(SALARY) > 80000
ORDER BY AVG_SALARY DESC;

-- Products with more than 100 items in stock
SELECT
    CATEGORY,
    COUNT(*) AS PRODUCT_COUNT,
    SUM(IN_STOCK) AS TOTAL_INVENTORY
FROM PRODUCT
GROUP BY CATEGORY
HAVING SUM(IN_STOCK) > 100
ORDER BY TOTAL_INVENTORY DESC;

-- ============================================================================
-- Task 5: GROUP BY with JOIN
-- ============================================================================

-- Department summary with names
SELECT
    d.DEPT_NAME,
    d.LOCATION,
    COUNT(e.EMP_ID) AS EMPLOYEE_COUNT,
    AVG(e.SALARY) AS AVG_SALARY,
    SUM(e.SALARY) AS TOTAL_PAYROLL
FROM DEPARTMENT d
LEFT JOIN EMPLOYEE e ON d.DEPT_ID = e.DEPT_ID
GROUP BY d.DEPT_NAME, d.LOCATION
ORDER BY EMPLOYEE_COUNT DESC;

-- Product sales summary
SELECT
    p.CATEGORY,
    p.PRODUCT_NAME,
    COUNT(s.SALE_ID) AS TIMES_SOLD,
    SUM(s.QUANTITY) AS TOTAL_QUANTITY,
    SUM(s.SALE_AMOUNT) AS TOTAL_REVENUE
FROM PRODUCT p
LEFT JOIN SALES s ON p.PRODUCT_ID = s.PRODUCT_ID
GROUP BY p.CATEGORY, p.PRODUCT_NAME
ORDER BY TOTAL_REVENUE DESC;

-- ============================================================================
-- Task 6: Complex aggregations
-- ============================================================================

-- Sales performance by region with percentages
SELECT
    REGION,
    COUNT(*) AS SALE_COUNT,
    SUM(SALE_AMOUNT) AS TOTAL_REVENUE,
    CAST(SUM(SALE_AMOUNT) * 100.0 / (SELECT SUM(SALE_AMOUNT) FROM SALES)
         AS DECIMAL(5,2)) AS REVENUE_PERCENTAGE
FROM SALES
GROUP BY REGION
ORDER BY TOTAL_REVENUE DESC;

-- Department budget vs actual payroll
SELECT
    d.DEPT_NAME,
    d.BUDGET AS ALLOCATED_BUDGET,
    COALESCE(SUM(e.SALARY), 0) AS TOTAL_PAYROLL,
    d.BUDGET - COALESCE(SUM(e.SALARY), 0) AS REMAINING_BUDGET,
    CAST(COALESCE(SUM(e.SALARY), 0) * 100.0 / d.BUDGET
         AS DECIMAL(5,2)) AS BUDGET_UTILIZATION_PCT
FROM DEPARTMENT d
LEFT JOIN EMPLOYEE e ON d.DEPT_ID = e.DEPT_ID
GROUP BY d.DEPT_NAME, d.BUDGET
ORDER BY BUDGET_UTILIZATION_PCT DESC;

-- ============================================================================
-- Task 7: Statistical analysis
-- ============================================================================

-- Salary distribution by job title
SELECT
    JOB_TITLE,
    COUNT(*) AS EMPLOYEE_COUNT,
    MIN(SALARY) AS MIN_SALARY,
    AVG(SALARY) AS AVG_SALARY,
    MAX(SALARY) AS MAX_SALARY,
    MAX(SALARY) - MIN(SALARY) AS SALARY_RANGE
FROM EMPLOYEE
GROUP BY JOB_TITLE
ORDER BY AVG_SALARY DESC;

-- ============================================================================
-- Practice Exercises:
-- 1. Find the total sales by product category
-- 2. Calculate the average sale amount by region and month
-- 3. Identify departments where payroll exceeds 80% of budget
-- 4. List products that have been sold more than 3 times
-- ============================================================================
