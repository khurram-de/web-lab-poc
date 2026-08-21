-- ============================================================================
-- Exercise 4: Advanced SQL - Window Functions and CTEs
-- Practice analytical queries and complex transformations
-- ============================================================================

-- ============================================================================
-- Task 1: Common Table Expressions (CTEs)
-- ============================================================================

-- Employee ranking by salary within department
WITH DeptSalaryRanking AS (
    SELECT
        e.EMP_ID,
        e.FIRST_NAME,
        e.LAST_NAME,
        e.SALARY,
        d.DEPT_NAME,
        RANK() OVER (PARTITION BY e.DEPT_ID ORDER BY e.SALARY DESC) AS SALARY_RANK
    FROM EMPLOYEE e
    JOIN DEPARTMENT d ON e.DEPT_ID = d.DEPT_ID
)
SELECT
    DEPT_NAME,
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    SALARY_RANK
FROM DeptSalaryRanking
WHERE SALARY_RANK <= 3
ORDER BY DEPT_NAME, SALARY_RANK;

-- Sales analysis with running totals
WITH DailySales AS (
    SELECT
        SALE_DATE,
        REGION,
        SUM(SALE_AMOUNT) AS DAILY_REVENUE
    FROM SALES
    GROUP BY SALE_DATE, REGION
)
SELECT
    SALE_DATE,
    REGION,
    DAILY_REVENUE,
    SUM(DAILY_REVENUE) OVER (
        PARTITION BY REGION
        ORDER BY SALE_DATE
        ROWS UNBOUNDED PRECEDING
    ) AS RUNNING_TOTAL
FROM DailySales
ORDER BY REGION, SALE_DATE;

-- ============================================================================
-- Task 2: ROW_NUMBER() - unique sequential number
-- ============================================================================

-- Number employees within each department
SELECT
    ROW_NUMBER() OVER (PARTITION BY DEPT_ID ORDER BY HIRE_DATE) AS DEPT_HIRE_SEQ,
    FIRST_NAME,
    LAST_NAME,
    DEPT_ID,
    HIRE_DATE,
    JOB_TITLE
FROM EMPLOYEE
ORDER BY DEPT_ID, DEPT_HIRE_SEQ;

-- ============================================================================
-- Task 3: RANK() and DENSE_RANK()
-- ============================================================================

-- Rank products by price (with gaps for ties)
SELECT
    PRODUCT_NAME,
    CATEGORY,
    UNIT_PRICE,
    RANK() OVER (ORDER BY UNIT_PRICE DESC) AS PRICE_RANK,
    DENSE_RANK() OVER (ORDER BY UNIT_PRICE DESC) AS DENSE_PRICE_RANK
FROM PRODUCT
ORDER BY PRICE_RANK;

-- Rank employees by salary within department
SELECT
    d.DEPT_NAME,
    e.FIRST_NAME,
    e.LAST_NAME,
    e.SALARY,
    RANK() OVER (PARTITION BY e.DEPT_ID ORDER BY e.SALARY DESC) AS DEPT_SALARY_RANK
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DEPT_ID = d.DEPT_ID
ORDER BY d.DEPT_NAME, DEPT_SALARY_RANK;

-- ============================================================================
-- Task 4: LAG() and LEAD() - access previous/next rows
-- ============================================================================

-- Compare each sale to the previous sale
SELECT
    SALE_DATE,
    PRODUCT_ID,
    SALE_AMOUNT,
    LAG(SALE_AMOUNT) OVER (ORDER BY SALE_DATE, SALE_ID) AS PREVIOUS_SALE,
    SALE_AMOUNT - LAG(SALE_AMOUNT) OVER (ORDER BY SALE_DATE, SALE_ID) AS DIFFERENCE
FROM SALES
ORDER BY SALE_DATE, SALE_ID;

-- Employee hire progression by department
SELECT
    DEPT_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    LAG(HIRE_DATE) OVER (PARTITION BY DEPT_ID ORDER BY HIRE_DATE) AS PREV_HIRE,
    HIRE_DATE - LAG(HIRE_DATE) OVER (PARTITION BY DEPT_ID ORDER BY HIRE_DATE) AS DAYS_SINCE_PREV_HIRE
FROM EMPLOYEE
ORDER BY DEPT_ID, HIRE_DATE;

-- ============================================================================
-- Task 5: FIRST_VALUE() and LAST_VALUE()
-- ============================================================================

-- Compare each employee to highest/lowest paid in their department
SELECT
    e.DEPT_ID,
    d.DEPT_NAME,
    e.FIRST_NAME,
    e.LAST_NAME,
    e.SALARY,
    FIRST_VALUE(e.SALARY) OVER (
        PARTITION BY e.DEPT_ID
        ORDER BY e.SALARY DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS DEPT_MAX_SALARY,
    LAST_VALUE(e.SALARY) OVER (
        PARTITION BY e.DEPT_ID
        ORDER BY e.SALARY DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS DEPT_MIN_SALARY
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DEPT_ID = d.DEPT_ID
ORDER BY e.DEPT_ID, e.SALARY DESC;

-- ============================================================================
-- Task 6: Cumulative aggregations
-- ============================================================================

-- Running total of sales revenue
SELECT
    SALE_DATE,
    REGION,
    SALE_AMOUNT,
    SUM(SALE_AMOUNT) OVER (
        ORDER BY SALE_DATE, SALE_ID
        ROWS UNBOUNDED PRECEDING
    ) AS CUMULATIVE_REVENUE
FROM SALES
ORDER BY SALE_DATE, SALE_ID;

-- Moving average of sales (3-day window)
SELECT
    SALE_DATE,
    SALE_AMOUNT,
    AVG(SALE_AMOUNT) OVER (
        ORDER BY SALE_DATE
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MOVING_AVG_3DAY
FROM SALES
ORDER BY SALE_DATE;

-- ============================================================================
-- Task 7: Nested CTEs and complex analysis
-- ============================================================================

-- Multi-level sales analysis
WITH ProductSales AS (
    SELECT
        p.PRODUCT_ID,
        p.PRODUCT_NAME,
        p.CATEGORY,
        SUM(s.SALE_AMOUNT) AS TOTAL_REVENUE,
        COUNT(s.SALE_ID) AS NUM_SALES
    FROM PRODUCT p
    LEFT JOIN SALES s ON p.PRODUCT_ID = s.PRODUCT_ID
    GROUP BY p.PRODUCT_ID, p.PRODUCT_NAME, p.CATEGORY
),
CategoryTotals AS (
    SELECT
        CATEGORY,
        SUM(TOTAL_REVENUE) AS CATEGORY_REVENUE
    FROM ProductSales
    GROUP BY CATEGORY
)
SELECT
    ps.PRODUCT_NAME,
    ps.CATEGORY,
    ps.TOTAL_REVENUE,
    ps.NUM_SALES,
    ct.CATEGORY_REVENUE,
    CAST(ps.TOTAL_REVENUE * 100.0 / NULLIFZERO(ct.CATEGORY_REVENUE)
         AS DECIMAL(5,2)) AS PCT_OF_CATEGORY
FROM ProductSales ps
JOIN CategoryTotals ct ON ps.CATEGORY = ct.CATEGORY
ORDER BY ps.CATEGORY, ps.TOTAL_REVENUE DESC;

-- ============================================================================
-- Task 8: CASE expressions with window functions
-- ============================================================================

-- Categorize employees by salary percentile
SELECT
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    NTILE(4) OVER (ORDER BY SALARY) AS SALARY_QUARTILE,
    CASE
        WHEN NTILE(4) OVER (ORDER BY SALARY) = 4 THEN 'Top 25%'
        WHEN NTILE(4) OVER (ORDER BY SALARY) = 3 THEN 'Above Average'
        WHEN NTILE(4) OVER (ORDER BY SALARY) = 2 THEN 'Below Average'
        ELSE 'Bottom 25%'
    END AS SALARY_CATEGORY
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- ============================================================================
-- Practice Exercises:
-- 1. Find the top 3 best-selling products per category using window functions
-- 2. Calculate month-over-month sales growth by region
-- 3. Identify employees who earn more than the average in their department
-- 4. Create a dashboard query showing department KPIs with rankings
-- ============================================================================
