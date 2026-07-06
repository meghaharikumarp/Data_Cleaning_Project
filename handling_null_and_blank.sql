-- 3. Handling null and blank values

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL;

-- WHEN CHECKING THIS WE FOUND BOTH total_laid_off AND percentage_laid_off IS  NULL .
-- I THINK IT NEEDS TO BE DELETED BECAUSE IT LOOKS LIKE USELESS DATA .

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS  NULL;

-- DELETING

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS  NULL;

SELECT *
FROM layoffs_staging2;

SELECT DISTINCT(industry)
FROM layoffs_staging2;  -- industry have both null and blank values

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry LIKE '';

SELECT *
FROM layoffs_staging2
WHERE company ='Airbnb'; -- Going to populate bcause the data in some columns are blank or null

SELECT  * 
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
  AND t1.location = t2.location
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL ;

SELECT t1.industry ,t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL ;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL ;

SELECT *
FROM layoffs_staging2
WHERE company ='Airbnb';

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

-- REMOVING ROW_NUM COLUMN

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;