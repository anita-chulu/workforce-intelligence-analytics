-- WORKFORCE INTELLIGENCE: EMPLOYEE ATTRITION & RETENTION
-- Dataset: 600 simulated employee records
-- Database: SQLite

-- 1. Workforce overview
SELECT
    COUNT(*) AS total_employees,
    COUNT(DISTINCT employee_id) AS unique_employee_ids,
    COUNT(DISTINCT department) AS departments,
    COUNT(DISTINCT location) AS locations,
    ROUND(AVG(monthly_salary), 2) AS average_monthly_salary
FROM employees;

-- 2. Employee turnover by department
SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN employment_status = 'Resigned' THEN 1 ELSE 0 END) AS resigned_employees,
    ROUND(
        100.0 * SUM(CASE WHEN employment_status = 'Resigned' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS turnover_rate
FROM employees
GROUP BY department
ORDER BY turnover_rate DESC;

-- 3. Turnover by length of service
SELECT
    CASE
        WHEN years_of_service < 2 THEN 'Under 2 years'
        WHEN years_of_service BETWEEN 2 AND 4 THEN '2-4 years'
        ELSE '5+ years'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN employment_status = 'Resigned' THEN 1 ELSE 0 END) AS resigned_employees,
    ROUND(
        100.0 * SUM(CASE WHEN employment_status = 'Resigned' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS turnover_rate
FROM employees
GROUP BY tenure_group
ORDER BY turnover_rate DESC;

-- 4. Turnover by overtime category
SELECT
    CASE
        WHEN overtime_hours < 15 THEN 'Low Overtime'
        WHEN overtime_hours BETWEEN 15 AND 29 THEN 'Moderate Overtime'
        ELSE 'High Overtime'
    END AS overtime_category,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN employment_status = 'Resigned' THEN 1 ELSE 0 END) AS resigned_employees,
    ROUND(
        100.0 * SUM(CASE WHEN employment_status = 'Resigned' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS turnover_rate
FROM employees
GROUP BY overtime_category
ORDER BY turnover_rate DESC;
