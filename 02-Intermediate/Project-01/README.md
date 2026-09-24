# Analyzing the World's Oldest Businesses

**SQL | PostgreSQL**

## Project Overview

What characteristics help a business remain in operation for centuries?

This project analyzes data on some of the world's oldest businesses and combines information from multiple tables to explore how long-established businesses are distributed across continents and business categories.

The project focuses on three questions:

- What is the oldest business on each continent?
- How many countries per continent are missing business data, and does adding newer records change the result?
- Which business categories have the oldest examples across different continents?

## Analytical Questions

1. What is the oldest business on each continent?
2. How many countries per continent lack data on the oldest businesses? Does including `new_businesses` change this?
3. Which business categories are best suited to last over the course of centuries?

## Business Context

For an analyst studying long-lived businesses, combining company, country, continent, and category information makes it possible to compare patterns across different parts of the world.

The analysis is descriptive. It identifies historical patterns in the available data rather than claiming that a particular business category causes companies to survive longer.

## Dataset

The project uses four related tables:

- `businesses` — business name, founding year, category, and country
- `new_businesses` — additional business records
- `countries` — country names, country codes, and continents
- `categories` — business category codes and category descriptions

The project brief states that the dataset was researched by **BusinessFinancing.co.uk** and compiled from information on the oldest company still in business in almost every country.

The SQL analysis was performed on the tables used in the learning environment. Copies of all four datasets are included in this repository.

**Note:** The repository CSV files contain an additional `index` column from the CSV export. The SQL analysis uses the original table fields described above.

## SQL Skills

- `SELECT`
- `INNER JOIN` and `LEFT JOIN`
- `USING`
- `UNION ALL`
- Subqueries
- `MIN()`
- `COUNT()`
- `GROUP BY`
- `ORDER BY`
- Common Table Expressions (CTEs)
- Working with related tables
- Comparing results across combined datasets

## Analysis

### 1. Oldest Business on Each Continent

The first query joins businesses to countries and uses a correlated subquery to find the minimum founding year within each continent.

```sql
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
```

#### Result

| Continent | Country | Business | Year Founded |
|---|---|---|---:|
| Africa | Mauritius | Mauritius Post | 1772 |
| Asia | Japan | Kongō Gumi | 578 |
| Europe | Austria | St. Peter Stifts Kulinarium | 803 |
| North America | Mexico | La Casa de Moneda de México | 1534 |
| Oceania | Australia | Australia Post | 1809 |
| South America | Peru | Casa Nacional de Moneda | 1565 |

### 2. Countries Without Business Data

The second query combines `businesses` and `new_businesses` with `UNION ALL`, then uses a `LEFT JOIN` to identify countries for which no business record is available.

```sql
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
```

#### Result

| Continent | Countries Without Businesses |
|---|---:|
| Africa | 3 |
| Asia | 7 |
| Europe | 3 |
| North America | 5 |
| Oceania | 10 |
| South America | 3 |

Including `new_businesses` reduces the number of countries without business data in **North America from 6 to 5** and in **Oceania from 11 to 10**. The counts for the other continents remain unchanged.

### 3. Oldest Business by Category and Continent

The third query joins businesses with country and category information, then finds the earliest founding year for each continent-category combination.

```sql
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
```

#### Result

| Continent | Category | Year Founded |
|---|---|---:|
| Africa | Agriculture | 1947 |
| Africa | Aviation & Transport | 1854 |
| Africa | Banking & Finance | 1892 |
| Africa | Distillers, Vintners, & Breweries | 1933 |
| Africa | Energy | 1968 |
| Africa | Food & Beverages | 1878 |
| Africa | Manufacturing & Production | 1820 |
| Africa | Media | 1943 |
| Africa | Mining | 1962 |
| Africa | Postal Service | 1772 |
| Asia | Agriculture | 1930 |
| Asia | Aviation & Transport | 1858 |
| Asia | Banking & Finance | 1830 |
| Asia | Cafés, Restaurants & Bars | 1153 |
| Asia | Conglomerate | 1841 |
| Asia | Construction | 578 |
| Asia | Defense | 1808 |
| Asia | Distillers, Vintners, & Breweries | 1853 |
| Asia | Energy | 1928 |
| Asia | Food & Beverages | 1820 |
| Asia | Manufacturing & Production | 1736 |
| Asia | Media | 1931 |
| Asia | Mining | 1913 |
| Asia | Postal Service | 1800 |
| Asia | Retail | 1883 |
| Asia | Telecommunications | 1885 |
| Asia | Tourism & Hotels | 1584 |
| Europe | Agriculture | 1218 |
| Europe | Banking & Finance | 1606 |
| Europe | Cafés, Restaurants & Bars | 803 |
| Europe | Consumer Goods | 1649 |
| Europe | Defense | 1878 |
| Europe | Distillers, Vintners, & Breweries | 862 |
| Europe | Manufacturing & Production | 864 |
| Europe | Medical | 1422 |
| Europe | Mining | 1248 |
| Europe | Postal Service | 1520 |
| Europe | Telecommunications | 1912 |
| Europe | Tourism & Hotels | 1230 |
| North America | Agriculture | 1638 |
| North America | Aviation & Transport | 1870 |
| North America | Banking & Finance | 1891 |
| North America | Distillers, Vintners, & Breweries | 1703 |
| North America | Food & Beverages | 1920 |
| North America | Manufacturing & Production | 1534 |
| North America | Media | 1909 |
| North America | Retail | 1670 |
| North America | Tourism & Hotels | 1770 |
| Oceania | Banking & Finance | 1861 |
| Oceania | Postal Service | 1809 |
| South America | Banking & Finance | 1565 |
| South America | Cafés, Restaurants & Bars | 1877 |
| South America | Defense | 1811 |
| South America | Food & Beverages | 1660 |
| South America | Manufacturing & Production | 1621 |
| *(no continent match)* | Media | 1999 |

## Key Findings

- **Kongō Gumi** is the oldest business returned for any continent in the analysis, with a founding year of **578** in Asia.
- **St. Peter Stifts Kulinarium** is the oldest business returned for Europe, founded in **803**.
- The addition of `new_businesses` fills one missing country in **North America** and one in **Oceania**.
- The category analysis shows that the earliest recorded business varies substantially by continent and category.
- The category-level results also contain one unmatched country record, which is reflected by the missing continent in the final row.

## Data Quality Note

The business record for **Meridian Corporation** uses the country code `XK `, while the corresponding country record uses `XK`. Because the join is based on an exact `country_code` match, that record does not join to a country and therefore appears with a missing continent in the third analysis.

The data has been left unchanged. The mismatch is documented rather than silently corrected so that the analysis remains reproducible against the provided dataset.

## Limitations

- The dataset covers almost every country rather than every country and does not represent every business in each country.
- Missing business records mean that the oldest business in a continent or category may not represent the true oldest business.
- The analysis identifies the earliest founding year in the available data; it does not independently verify whether each business has operated continuously since its founding.
- The results depend on the country and category classifications provided in the dataset.
- The `new_businesses` table contains only two additional records, so its effect on the missing-country analysis is limited.

## Project Files

- [Dataset – businesses.csv](./businesses.csv)
- [Dataset – new_businesses.csv](./new_businesses.csv)
- [Dataset – countries.csv](./countries.csv)
- [Dataset – categories.csv](./categories.csv)

## Source

The project brief attributes the underlying research to **BusinessFinancing.co.uk**.
