

USE platinumrx;

-- Q1. For every user, get the user_id and last booked room_no
WITH last_booking AS (
  SELECT 
    user_id,
    room_no,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) AS rn
  FROM bookings
)
SELECT user_id, room_no AS last_room_no
FROM last_booking
WHERE rn = 1;


-- Q2. Get booking_id and total billing amount of every booking created in November 2021
SELECT 
  bc.booking_id,
  SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM booking_commercials bc
JOIN bookings b ON bc.booking_id = b.booking_id
JOIN items i   ON bc.item_id     = i.item_id
WHERE YEAR(b.booking_date) = 2021
  AND MONTH(b.booking_date) = 11
GROUP BY bc.booking_id
ORDER BY total_amount DESC;


-- Q3. Get bill_id and bill amount of all the bills raised in October 2021 having bill_amount > 1000
SELECT 
  bc.bill_id,
  SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(bc.bill_date) = 2021
  AND MONTH(bc.bill_date) = 10
GROUP BY bc.bill_id
HAVING bill_amount > 1000
ORDER BY bill_amount DESC;


-- Q4. Determine the most ordered and least ordered item of each month of year 2021
WITH monthly_qty AS (
  SELECT 
    MONTH(bc.bill_date) AS mon,
    bc.item_id,
    SUM(bc.item_quantity) AS total_qty
  FROM booking_commercials bc
  WHERE YEAR(bc.bill_date) = 2021
  GROUP BY MONTH(bc.bill_date), bc.item_id
),
ranked AS (
  SELECT
    mq.*,
    ROW_NUMBER() OVER (PARTITION BY mq.mon ORDER BY mq.total_qty DESC) AS rn_most,
    ROW_NUMBER() OVER (PARTITION BY mq.mon ORDER BY mq.total_qty ASC)  AS rn_least
  FROM monthly_qty mq
)
SELECT 
  r.mon AS month,
  r.item_id,
  r.total_qty,
  CASE 
    WHEN r.rn_most = 1 THEN 'MOST_ORDERED'
    WHEN r.rn_least = 1 THEN 'LEAST_ORDERED'
  END AS category
FROM ranked r
WHERE r.rn_most = 1 OR r.rn_least = 1
ORDER BY r.mon, category DESC;


-- Q5. Find the customers with the second highest bill value of each month of year 2021
WITH cust_month_bill AS (
  SELECT
    b.user_id,
    MONTH(bc.bill_date) AS mon,
    SUM(bc.item_quantity * i.item_rate) AS total_bill
  FROM booking_commercials bc
  JOIN bookings b ON bc.booking_id = b.booking_id
  JOIN items i    ON bc.item_id    = i.item_id
  WHERE YEAR(bc.bill_date) = 2021
  GROUP BY b.user_id, MONTH(bc.bill_date)
),
ranked AS (
  SELECT
    cmb.*,
    DENSE_RANK() OVER (PARTITION BY cmb.mon ORDER BY cmb.total_bill DESC) AS bill_rank
  FROM cust_month_bill cmb
)
SELECT 
  mon AS month,
  user_id,
  total_bill
FROM ranked
WHERE bill_rank = 2
ORDER BY month;
