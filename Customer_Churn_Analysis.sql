CREATE TABLE customers (
    customerid TEXT,
    gender TEXT,
    seniorcitizen INT,
    partner TEXT,
    dependents TEXT,
    tenure INT,
    phoneservice TEXT,
    multiplelines TEXT,
    internetservice TEXT,
    onlinesecurity TEXT,
    onlinebackup TEXT,
    deviceprotection TEXT,
    techsupport TEXT,
    streamingtv TEXT,
    streamingmovies TEXT,
    contract TEXT,
    paperlessbilling TEXT,
    paymentmethod TEXT,
    monthlycharges NUMERIC,
    totalcharges TEXT,
    churn TEXT
);

SELECT *
FROM customers
LIMIT 10;

-- Total number of Churned customers
SELECT COUNT(*)
FROM customers
WHERE churn = 'Yes';

-- 1. Calculate overall customer churn rate
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers;

-- 2. Churn by contract type
SELECT
    contract,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS churned_customers,
    ROUND(
        COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY contract
ORDER BY churn_rate DESC;

-- 3. Average monthly charges by churn status
SELECT
    churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(monthlycharges), 2) AS avg_monthly_charges
FROM customers
GROUP BY churn;

-- 4. Churn by tenure group
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49-72 months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS churned_customers,
    ROUND(
        COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY tenure_group
ORDER BY MIN(tenure);

-- 5. Churn by internet service type
SELECT
    internetservice,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS churned_customers,
    ROUND(
        COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY internetservice
ORDER BY churn_rate DESC;

-- 6. Churn by technical support
SELECT 
	techsupport, 
	COUNT(*) AS Total_customers, 
	COUNT(*) FILTER (WHERE churn = 'Yes ') AS churned_customers, 
	ROUND(
        COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate 
FROM customers 
GROUP BY techsupport
ORDER BY churn_rate DESC;

-- 7. Churn by senior citizenship
SELECT 
	seniorcitizen, 
	COUNT(*) AS Total_customers, 
	COUNT(*) FILTER (WHERE churn = 'Yes ') AS churned_customers, 
	ROUND(
        COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate 
FROM customers 
GROUP BY seniorcitizen
ORDER BY churn_rate DESC;

