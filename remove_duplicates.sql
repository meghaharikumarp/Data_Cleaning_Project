-- SQL Project - DATA CLEANING
-- https://www.kaggle.com/datasets/swaptr/layoffs-2022


SELECT * FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null values or Blank values
-- 4. Remove any Columns Or Rows

SELECT * FROM layoffs_staging;

CREATE TABLE layoffs_staging            -- To copy all of the data from the raw table(layoffs) into layoffs_staging 
LIKE layoffs;                           -- Here only the columns are added (no data )



INSERT  layoffs_staging                 -- Here we actually inserting data from layoffs to layoffs_staging
SELECT * FROM layoffs; 


           -- 1. Remove Duplicates
           
-- Find duplicate rows by assigning a row number to each group of identical records.
-- ROW_NUMBER() starts from 1 for each group.
-- The first occurrence gets row_num = 1, while duplicates get row_num > 1.
           
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num   
FROM layoffs_staging;     

-- Create a Common Table Expression (CTE) named duplicate_cte.
-- Inside the CTE, assign row numbers to each group of identical records.
-- After the CTE is created, select only rows where row_num > 1.
-- Since the first occurrence has row_num = 1, rows with row_num > 1 are duplicate records.
-- This query helps identify duplicates before deleting or cleaning the data.

WITH duplicate_cte AS 
(SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num   
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

SELECT * 
FROM layoffs_staging
WHERE company = 'Casper';

SHOW CREATE TABLE layoffs_staging2;
CREATE TABLE `layoffs_staging2` (
   `company` text,
   `location` text,
   `industry` text,
   `total_laid_off` int DEFAULT NULL,
   `percentage_laid_off` text,
   `date` text,
   `stage` text,
   `country` text,
   `funds_raised_millions` int DEFAULT NULL,
   `row_num` int 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
SELECT * 
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num   
FROM layoffs_staging;

-- now that we have this we can delete rows were row_num is greater than 1

DELETE  
FROM layoffs_staging2
WHERE row_num > 1;

SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;