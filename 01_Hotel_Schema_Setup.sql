
CREATE DATABASE IF NOT EXISTS platinumrx;
USE platinumrx;

CREATE TABLE users (
  user_id         VARCHAR(50) PRIMARY KEY,
  name            VARCHAR(200),
  phone_number    VARCHAR(20),
  mail_id         VARCHAR(200),
  billing_address TEXT
);
CREATE TABLE bookings (
  booking_id   VARCHAR(50) PRIMARY KEY,
  booking_date DATETIME,
  room_no      VARCHAR(50),
  user_id      VARCHAR(50),
  CONSTRAINT fk_bookings_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE items (
  item_id   VARCHAR(50) PRIMARY KEY,
  item_name VARCHAR(200),
  item_rate DECIMAL(10,2)
);
CREATE TABLE booking_commercials (
  id            VARCHAR(50) PRIMARY KEY,
  booking_id    VARCHAR(50),
  bill_id       VARCHAR(50),
  bill_date     DATETIME,
  item_id       VARCHAR(50),
  item_quantity DECIMAL(10,3),
  CONSTRAINT fk_bc_booking
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
  CONSTRAINT fk_bc_item
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- users
INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('21wrcxuy-67erfn', 'John Doe', '97XXXXXXXX', 'john.doe@example.com', 'XX, Street Y, ABC City'),
('u-2',              'Alice',    '98YYYYYYYY', 'alice@example.com',   'Some Address 2');

-- items
INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu', 'Tawa Paratha', 18.00),
('itm-a07vh-aer8','Mix Veg',      89.00),
('itm-w978-23u4','Samosa',        25.00);

-- bookings
INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-nov1-2021',  '2021-11-05 14:10:00', 'rm-A',          '21wrcxuy-67erfn'),
('bk-nov2-2021',  '2021-11-15 19:00:00', 'rm-B',          'u-2'),
-- this one is needed for the October bill
('bk-oct-1',      '2021-10-10 09:00:00', 'rm-OCT-1',      '21wrcxuy-67erfn');

-- 4.4 booking_commercials
INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
('q34r-3q4o8-q34u','bk-09f3e-95hj','bl-0a87y-q340','2021-09-23 12:03:22','itm-a9e8-q8fu', 3),
('q3o4-ahf32-o2u4','bk-09f3e-95hj','bl-0a87y-q340','2021-09-23 12:03:22','itm-a07vh-aer8',1),

('bcn-nov-1',     'bk-nov1-2021', 'bl-nov1-1',    '2021-11-05 14:20:00','itm-a9e8-q8fu',10),
('bcn-nov-2',     'bk-nov1-2021', 'bl-nov1-1',    '2021-11-05 14:20:00','itm-a07vh-aer8',2),

('bcn-nov-3',     'bk-nov2-2021', 'bl-nov2-1',    '2021-11-15 19:30:00','itm-w978-23u4',40),

('oct-bill-1',    'bk-oct-1',     'bl-oct-1',     '2021-10-10 13:00:00','itm-w978-23u4',50);


