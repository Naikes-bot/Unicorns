-- 116 companies joined Unicorn status in 2022
Select COUNT(company)
FROM Unicorns.unicorn_companies
WHERE date_joined LIKE '2022%'; 


-- 59 companies were funded by Sequoia Capital
Select COUNT(Company) 
FROM Unicorns.unicorn_companies
WHERE select_investors LIKE 'Sequoia Capital%';

-- There are 84 AI companies as unicorns
SELECT COUNT(company), industry
FROM Unicorns.unicorn_companies
WHERE industry = 'Artificial intelligence'
GROUP BY industry;

 

-- Top 10 longest operating companies since they have been founded (Tableau)
SELECT company, 
       (date_joined - year_founded) AS operation_in_years
FROM Unicorns.unicorn_companies
ORDER BY operation_in_years DESC 
LIMIT 10; 


-- Number of companies founded in the last 5 years (142)
Select COUNT(*)
FROM Unicorns.unicorn_companies
WHERE year_founded >= (YEAR(CURDATE()) - 5); 

-- Top 10 highest valuated companies (tableau)
Select company, 
       valuation
FROM Unicorns.unicorn_companies
LIMIT 10; 

-- Workhuman received the most funding with $9M
Select company, funding 
FROM Unicorns.unicorn_companies
WHERE funding = (
   Select MAX(funding)
   FROM Unicorns.unicorn_companies
   WHERE funding <> 'Unknown'
); 

-- Fintech has the highest number of Unicorns (tableau)

Select industry, COUNT(*)AS total
FROM Unicorns.unicorn_companies
GROUP BY industry
ORDER BY total DESC; 

-- Number of US companies in the Unicorn list

Select COUNT(*)
FROM Unicorns.unicorn_companies
WHERE country IN ('United States'); 

-- What percentage do US companies make the Unicorn list (52%)

Select COUNT(*)
FROM Unicorns.unicorn_companies;


Select COUNT(*) / 1074 * 100 AS Percentage
FROM Unicorns.unicorn_companies
WHERE country = 'United States'; 

-- Country ranked with highest valuation in specific industry (Tableau)

Select country,
       industry,
       MAX(valuation) AS valuation,
       DENSE_RANK() OVER (ORDER BY MAX(valuation) DESC) AS country_rank
FROM Unicorns.unicorn_companies
GROUP BY country, industry
ORDER BY country_rank;

-- Asian cities with valuations
Select country, city, valuation
FROM Unicorns.unicorn_companies
WHERE continent = 'Asia'
ORDER BY Valuation DESC; 

-- Unicorns in the Netherlands
Select *
FROM Unicorns.unicorn_companies
WHERE country = 'Netherlands';


-- Companies by founding years 
Select company, year_founded,
   CASE WHEN year_founded < 2010 THEN 'Ancient'
        WHEN year_founded BETWEEN 2010 AND 2020 THEN 'Recent Past'
        ELSE 'Present'
	END AS time
FROM Unicorns.unicorn_companies
ORDER BY year_founded;

-- Which city has the most number of companies (San Francisco with 152)

Select city, 
       COUNT(*) AS num_companies
FROM Unicorns.unicorn_companies
GROUP BY city
ORDER BY num_companies DESC
LIMIT 20;

-- Which was the first and last company to join the Unicorn status
-- First company was Veepee and last was Oura (in 2022)

Select company, 
       MAX(date_joined) AS date
FROM Unicorns.unicorn_companies
GROUP BY company
ORDER BY date;

-- Continent with the highest funding & valuation (not for tableau)

SELECT DISTINCT continent,
        (SELECT company
         FROM Unicorns.unicorn_companies AS uc2
         WHERE uc2.continent = uc1.continent
         AND uc2.funding = uc1.funding
         LIMIT 1) AS company, 
         funding 
FROM Unicorns.unicorn_companies AS uc1
WHERE funding <> 'Unknown'
ORDER BY funding DESC
LIMIT 10; 

-- List of continents and funding amounts for which there are multiple companies
SELECT continent, funding, COUNT(company)
FROM Unicorns.unicorn_companies
WHERE funding <> 'Unknown'
GROUP BY continent, funding
HAVING COUNT(company) > 1;

-- 65 unicorns are from India
Select COUNT(company)
FROM Unicorns.unicorn_companies
WHERE country = 'India';

-- Cities with number of companies with valuation of $1 billion 
Select city, COUNT(*)AS num_companies
FROM Unicorns.unicorn_companies
WHERE valuation = '$1B'
GROUP BY city 
ORDER BY num_companies DESC;


-- List of all the cities and valuations that have multiple occurrences in the database.
SELECT city, valuation, COUNT(*)
FROM Unicorns.unicorn_companies
GROUP BY city, valuation
HAVING COUNT(*) > 1;

-- Top 5 Companies based in San Francisco who got the highest funding and have a valuation over 30B 

Select company,
       MAX(funding) AS funding_received,
       YEAR(date_joined) AS Year, 
       MONTH(date_joined) AS Month
FROM Unicorns.unicorn_companies
WHERE valuation > '$30B' AND funding <> 'Unknown' AND city = 'San Francisco'
GROUP BY company, Year, Month
ORDER BY funding_received DESC
LIMIT 5;


-- Total number of investors (1059)
Select COUNT(DISTINCT(select_investors)) AS num_investors
FROM Unicorns.unicorn_companies;


SELECT COUNT(Company) 
FROM Unicorns.unicorn_companies;


-- Company to Investor Ratio  (0.98, near 1 to 1 ratio) 
SELECT COUNT(DISTINCT(select_investors))/ 
            (SELECT COUNT(Company)
            FROM Unicorns.unicorn_companies) AS num_companies 
	FROM Unicorns.unicorn_companies; 
    
