# Data_Analyst_Assignment
Data_Analyst_Assignment/
│
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql
│   ├── 02_Hotel_Queries.sql
│   ├── 03_Clinic_Schema_Setup.sql
│   └── 04_Clinic_Queries.sql
│
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx
│
├── Python/
│   ├── 01_Time_Converter.py
│   └── 02_Remove_Duplicates.py
│
└── README.md



🧩 1. SQL Proficiency
📁 Folder: SQL/

Contains SQL scripts for:

🔹 A. Hotel Management System

01_Hotel_Schema_Setup.sql

Database creation

Table creation: users, bookings, booking_commercials, items

Sample data inserts

02_Hotel_Queries.sql
Contains solutions for:

Last booked room per user

Booking-wise billing for Nov 2021

Bills > 1000 in Oct 2021

Most & least ordered item per month (2021)

Customers with second-highest bill per month

🔹 B. Clinic Management System

03_Clinic_Schema_Setup.sql

Table creation: clinics, customer, clinic_sales, expenses

Sample inserts

04_Clinic_Queries.sql
Solutions for:

Revenue by sales channel per year

Top 10 valuable customers

Monthly revenue, expenses, profit & status

Most profitable clinic per city per month

Second least profitable clinic per state per month

📊 2. Spreadsheet Proficiency
📁 File: Spreadsheets/Ticket_Analysis.xlsx

The Excel file contains three sheets:

1. ticket

Includes:

created_at

closed_at

outlet_id

cms_id

Helper columns:

created_date

closed_date

created_hour

closed_hour

same_day

same_hour_same_day

2. feedbacks

VLOOKUP/ARRAYFORMULA used to populate:

ticket_created_at from ticket sheet (using cms_id)

3. Summary

Outlet-wise metrics:

number of tickets created & closed on the same day

number of tickets created & closed in the same hour of same day

All formulas are implemented using Google Sheets.

🐍 3. Python Proficiency
📁 Folder: Python/
01_Time_Converter.py

Converts minutes into human readable format:
130 → 2 hrs 10 minutes,
110 → 1 hr 50 minutes

Uses basic arithmetic and formatting.

02_Remove_Duplicates.py

Removes duplicate characters from a string using a loop only.
Example:
banana → ban
