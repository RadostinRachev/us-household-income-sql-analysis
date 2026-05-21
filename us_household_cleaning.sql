# US Household income (Data Cleaning)

SELECT * FROM us_project.us_household_income;

SELECT * FROM us_project.us_household_income_statistics;

ALTER TABLE us_project.us_household_income_statistics
RENAME COLUMN `ï»¿id` TO `id`
;

SELECT COUNT(id) FROM us_project.us_household_income;

SELECT COUNT(id) FROM us_project.us_household_income_statistics;

# Check for duplicates

SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;


SELECT *
FROM (
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
FROM us_household_income
) as duplicates
WHERE row_num > 1
;

# Deleting duplicates

DELETE FROM us_household_income
WHERE row_id IN (
SELECT row_id
FROM (
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
FROM us_household_income
) as duplicates
WHERE row_num > 1
)
;

SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;

SELECT DISTINCT State_Name
FROM us_project.us_household_income
GROUP BY 1
;

# Update columns

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'Alabama'
;

SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County' 
ORDER BY 1
;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County' 
AND City = 'Vinemont'
;

SELECT Type, COUNT(Type)
FROM us_project.us_household_income
GROUP BY Type
;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

SELECT ALand, AWater
FROM us_project.us_household_income
WHERE (AWater = '0' OR AWater = '' OR AWater IS NULL)
#AND (ALand = '0' OR ALand = '' OR ALand IS NULL)
;