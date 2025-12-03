


-- Drop child tables first to avoid FK errors
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS clinics;

-- Create clinics table
CREATE TABLE IF NOT EXISTS clinics (
  cid VARCHAR(50) PRIMARY KEY,
  clinic_name VARCHAR(200),
  city VARCHAR(100),
  state VARCHAR(100),
  country VARCHAR(100)
);

-- Create customer table
CREATE TABLE IF NOT EXISTS customer (
  uid VARCHAR(50) PRIMARY KEY,
  name VARCHAR(200),
  mobile VARCHAR(20)
);

-- Create clinic_sales table
CREATE TABLE IF NOT EXISTS clinic_sales (
  oid VARCHAR(50) PRIMARY KEY,
  uid VARCHAR(50),
  cid VARCHAR(50),
  amount DECIMAL(12,2),
  datetime DATETIME,
  sales_channel VARCHAR(100),
  CONSTRAINT fk_sales_customer FOREIGN KEY (uid) REFERENCES customer(uid),
  CONSTRAINT fk_sales_clinic   FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Create expenses table
CREATE TABLE IF NOT EXISTS expenses (
  eid VARCHAR(50) PRIMARY KEY,
  cid VARCHAR(50),
  description VARCHAR(300),
  amount DECIMAL(12,2),
  datetime DATETIME,
  CONSTRAINT fk_expenses_clinic FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Insert sample clinics (parents)
INSERT IGNORE INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-0100001', 'XYZ clinic', 'MetroCity', 'StateA', 'CountryX'),
('cnc-02',      'ABC Clinic', 'Townville', 'StateB', 'CountryX'),
('cnc-03',      'Wellness Hub','MetroCity','StateA','CountryX');

-- Insert sample customers (parents)
INSERT IGNORE INTO customer (uid, name, mobile) VALUES
('cust-001','Jon Doe','9700000001'),
('cust-002','Maya','9800000002'),
('cust-003','Rohan','9700000003'),
('cust-004','Sita','9800000004');

-- Insert sample clinic sales (children)
INSERT IGNORE INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
('ord-001','cust-001','cnc-0100001',24999.00,'2021-09-23 12:03:22','offline'),
('ord-002','cust-002','cnc-0100001',1500.00,'2021-09-15 10:00:00','online'),
('ord-003','cust-003','cnc-02',500.00,'2021-09-20 09:00:00','walkin'),
('ord-004','cust-001','cnc-03',2000.00,'2021-09-05 11:00:00','online'),
('ord-005','cust-004','cnc-02',750.00,'2021-10-10 14:00:00','offline'),
('ord-006','cust-002','cnc-0100001',5000.00,'2021-11-12 16:00:00','online'),
('ord-007','cust-003','cnc-03',3000.00,'2021-11-20 10:30:00','walkin'),
('ord-008','cust-004','cnc-0100001',12000.00,'2021-12-01 09:15:00','offline');

-- Insert sample expenses (children)
INSERT IGNORE INTO expenses (eid, cid, description, amount, datetime) VALUES
('exp-001','cnc-0100001','first-aid supplies',557.00,'2021-09-23 07:36:48'),
('exp-002','cnc-02','rent',200.00,'2021-09-01 00:00:00'),
('exp-003','cnc-03','staff salaries',1500.00,'2021-09-30 18:00:00'),
('exp-004','cnc-0100001','equipment',1200.00,'2021-11-10 12:00:00');



