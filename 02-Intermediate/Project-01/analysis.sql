-- Analyzing the World's Oldest Businesses
-- SQL | PostgreSQL

-- 1. What is the oldest business on each continent?
WITH oldest_business_continent AS (
    SELECT c.continent,
        c.country,
        b.business,
        b.year_founded
    FROM businesses AS b
    INNER JOIN countries AS c
    USING (country_code)
    WHERE b.year_founded = (
        SELECT MIN(year_founded)
        FROM businesses AS b2
        INNER JOIN countries AS c2
        USING (country_code)
        WHERE c2.continent = c.continent
    )
)
SELECT *
FROM oldest_business_continent
ORDER BY continent, year_founded;


-- 2. How many countries per continent lack data on the oldest businesses?
-- Does including new_businesses change this?
WITH count_missing AS (
    SELECT c.continent,
        COUNT(c.country_code) AS countries_without_businesses
    FROM countries AS c
    LEFT JOIN (
        SELECT *
        FROM businesses
        UNION ALL
        SELECT *
        FROM new_businesses
    ) AS b
    USING (country_code)
    WHERE b.business IS NULL
    GROUP BY c.continent
)
SELECT *
FROM count_missing
ORDER BY continent;


-- 3. Which business categories are best suited to last over the course of centuries?
WITH oldest_by_continent_category AS (
    SELECT co.continent,
        ca.category,
        MIN(b.year_founded) AS year_founded
    FROM businesses AS b
    LEFT JOIN countries AS co
    USING (country_code)
    LEFT JOIN categories AS ca
    USING (category_code)
    GROUP BY co.continent, ca.category
)
SELECT *
FROM oldest_by_continent_category
ORDER BY continent, category;
