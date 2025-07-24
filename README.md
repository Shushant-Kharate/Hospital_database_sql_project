# Hospital Management Database
![Hospital Management logo](https://github.com/Shushant-Kharate/Hospital_database_sql_project/blob/main/logo.png)
## Overview
This project is a structured SQL practice set based on a hospital management scenario. It involves querying a healthcare database that includes patients, doctors, admissions, and province information. The queries cover a wide range of SQL concepts such as filtering, joining tables, aggregation, grouping, and conditional logic.

## Objective

- To simulate a hospital database environment for practicing SQL queries with realistic healthcare data.
- To assist in understanding how doctors and hospital administrators can retrieve meaningful insights from data.
- To explore core SQL concepts including `SELECT`, `JOIN`, `GROUP BY`, `HAVING`, and `CASE`.
- To simulate practical data retrieval tasks from a hospital database system.
- To understand how to query and analyze relational data using SQL.
- To demonstrate how structured queries can be used for patient management, diagnosis tracking, and resource analysis.
- To create a ready-to-use SQL portfolio project for interviews or coursework showcasing hands-on database skills.

## Schemas of Hospital Management System

```sql
CREATE TABLE province_names
(
    province_id   char(2) PRIMARY KEY,
    province_name text
);

CREATE TABLE patients
(
    patient_id  integer PRIMARY KEY,
    first_name  text,
    last_name   text,
    gender      varchar(1),
    birth_date  DATE,
    city        text,
    allergies   text,
    height      integer,
    weight      integer,
    province_id char(2) REFERENCES province_names (province_id)
);

CREATE TABLE admissions
(
    patient_id          integer REFERENCES patients (patient_id),
    admission_date      date,
    discharge_date      date,
    diagnosis           text,
    attending_doctor_id integer REFERENCES doctors (doctor_id)
);

CREATE TABLE doctors
(
    doctor_id  integer PRIMARY KEY,
    first_name text,
    last_name  text,
    speciality text
);
```

## Problems and Solutions

### 1. Show first name, last name, and gender of patients whose gender is 'M'

```sql
SELECT first_name, last_name, gender 
FROM patients1 
WHERE gender = 'M';
```
