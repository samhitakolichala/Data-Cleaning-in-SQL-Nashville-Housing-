**Data Cleaning in SQL for Nashville House Pricing Dataset**

This repository contains the SQL code used to clean the Nashville house pricing dataset. The dataset contains information on house sales in Nashville, TN from 2017 to 2019.

Dataset
 It contains the following columns:

Parcel Identification Number (PIN)
Sale Date
Sale Price
Property Address
Property City
Property State
Property Zip
Property County
Property Land Use
Neighborhood
Council District
Census Tract
Latitude
Longitude

**Data Cleaning Process**

The SQL code in this repository was used to clean the dataset by performing the following tasks:

Removing duplicate records.
Dropping irrelevant columns.
Standardizing and formatting the data in the SaleDate column.
Populating the property address data.
Extracting 'address','city','state' from Property Address column.
The SQL code was executed on the dataset using a SQL Server.

**Files**
The following file is included in this repository:

**data cleaning project.sql**: SQL code used to clean the Nashville house pricing dataset.

**Instructions**
To use the SQL code in this repository, follow these steps:

Create a MySQL database and import the dataset into the database.
Open data cleaning project.sql in a SQL editor.
Modify the database and table names in the SQL code to match the names of the database and table in which you imported the dataset.

**Execute the SQL code to clean the dataset**

**Acknowledgements**
The Nashville house pricing dataset was obtained from the Nashville Open Data Portal (https://data.nashville.gov/). The SQL code used to clean the dataset was created by Samhita Kolichala.
