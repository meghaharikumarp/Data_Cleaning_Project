-- 2. Standardizing Data

SELECT *
FROM layoffs_staging2;

-- HERE WE NOTICED SOME WHITESPACE IN THE COLUMN 'COMPANY' NAME SO TO RID OF THIS TRIM FUNCTION IS USED 

SELECT DISTINCT(company)
FROM layoffs_staging2;

SELECT company,TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- Now we look at the column industry

SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1;

-- I noticed the Crypto has multiple different variations. We need to standardize that - let's say all to Crypto

SELECT * 
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT(location)
FROM layoffs_staging2
ORDER BY 1;

-- DÃ¼sseldorf is actually a misencoded version of the real German city Düsseldorf. So we need to fix it

UPDATE layoffs_staging2
SET location = REPLACE(location, 'DÃ¼sseldorf', 'Düsseldorf');

UPDATE layoffs_staging2
SET location = REPLACE(
                 REPLACE(location, 'MalmÃ¶', 'Malmö'),
                 'FlorianÃ³polis', 'Florianópolis'
               );

SELECT DISTINCT(country)
FROM layoffs_staging2
ORDER BY 1;

-- In Country column we have some "United States" and some "United States."

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

-- changing data type of date
SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y'); -- HERE IT FORMAT THE DATA BUT THE TYPE IS NOT CHANGED YET

SELECT `date`
FROM layoffs_staging2;

ALTER  TABLE layoffs_staging2  
MODIFY COLUMN `date` DATE;     -- NOW IT TYPE BECOMES DATE
