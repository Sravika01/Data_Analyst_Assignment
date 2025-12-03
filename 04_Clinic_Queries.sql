

USE platinumrx;

-- Q1: Revenue from each sales_channel in a given year (example uses 2021)
SELECT sales_channel,
       SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel
ORDER BY total_revenue DESC;


-- Q2: Top 10 most valuable customers for a given year (2021)
SELECT cs.uid,
       c.name,
       SUM(cs.amount) AS total_spent
FROM clinic_sales cs
LEFT JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY cs.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;


-- Q3: Month-wise revenue, expense, profit, status (profitable / not-profitable) for a given year (2021)
WITH revenue AS (
  SELECT MONTH(datetime) AS mon, SUM(amount) AS total_revenue
  FROM clinic_sales
  WHERE YEAR(datetime) = 2021
  GROUP BY MONTH(datetime)
),
expense AS (
  SELECT MONTH(datetime) AS mon, SUM(amount) AS total_expense
  FROM expenses
  WHERE YEAR(datetime) = 2021
  GROUP BY MONTH(datetime)
),
months AS (
  SELECT 1 AS mon UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
  UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
  UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
)
SELECT m.mon AS month,
       COALESCE(r.total_revenue,0) AS revenue,
       COALESCE(e.total_expense,0) AS expense,
       COALESCE(r.total_revenue,0) - COALESCE(e.total_expense,0) AS profit,
       CASE WHEN COALESCE(r.total_revenue,0) - COALESCE(e.total_expense,0) >= 0 THEN 'PROFITABLE' ELSE 'NOT-PROFITABLE' END AS status
FROM months m
LEFT JOIN revenue r ON m.mon = r.mon
LEFT JOIN expense e ON m.mon = e.mon
ORDER BY m.mon;


-- Q4: For each city find the most profitable clinic for a given month (example month = 9, year = 2021)
WITH clinic_profit AS (
  SELECT c.cid, c.city,
         COALESCE(SUM(cs.amount),0) AS revenue,
         COALESCE((SELECT SUM(e.amount) FROM expenses e WHERE e.cid = c.cid AND YEAR(e.datetime)=2021 AND MONTH(e.datetime)=9),0) AS expense
  FROM clinics c
  LEFT JOIN clinic_sales cs ON cs.cid = c.cid AND YEAR(cs.datetime)=2021 AND MONTH(cs.datetime)=9
  GROUP BY c.cid, c.city
),
ranked AS (
  SELECT cid, city, (revenue - expense) AS net_profit,
         ROW_NUMBER() OVER (PARTITION BY city ORDER BY (revenue - expense) DESC) AS rn
  FROM clinic_profit
)
SELECT city, cid, net_profit
FROM ranked
WHERE rn = 1
ORDER BY city;


-- Q5: For each state find the second least profitable clinic for a given month (example month = 9, year = 2021)
WITH clinic_profit AS (
  SELECT c.cid, c.state,
         COALESCE(SUM(cs.amount),0) AS revenue,
         COALESCE((SELECT SUM(e.amount) FROM expenses e WHERE e.cid = c.cid AND YEAR(e.datetime)=2021 AND MONTH(e.datetime)=9),0) AS expense
  FROM clinics c
  LEFT JOIN clinic_sales cs ON cs.cid = c.cid AND YEAR(cs.datetime)=2021 AND MONTH(cs.datetime)=9
  GROUP BY c.cid, c.state
),
ranked AS (
  SELECT cid, state, (revenue - expense) AS net_profit,
         ROW_NUMBER() OVER (PARTITION BY state ORDER BY (revenue - expense) ASC) AS rn
  FROM clinic_profit
)
SELECT state, cid, net_profit
FROM ranked
WHERE rn = 2
ORDER BY state;
