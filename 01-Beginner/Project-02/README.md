# Product Carbon Footprint Analysis

**SQL | PostgreSQL**

## Project Overview

This project analyzes product carbon footprints across different industry groups using data from the Carbon Catalogue.

The analysis focuses on the total product carbon footprint recorded for each industry group in the most recent year available in the dataset.

## Analytical Question

How does the total product carbon footprint vary across industry groups in the most recent year, and how many distinct companies are represented in each industry group?

## Dataset

The project uses the `product_emissions` table containing product carbon footprint information for companies across different industries.

The analysis uses the following variables:

- `year` — year of the recorded product emissions
- `company` — company associated with the product
- `industry_group` — industry classification
- `carbon_footprint_pcf` — product carbon footprint measured in carbon dioxide equivalent

The data comes from **The Carbon Catalogue** and is publicly available through Nature:

[Source: Nature – The Carbon Catalogue](https://www.nature.com/articles/s41597-022-01178-9)

## SQL Skills

- SELECT
- WHERE
- COUNT(DISTINCT)
- SUM()
- ROUND()
- MAX()
- Subqueries
- GROUP BY
- ORDER BY
- Column aliases

## Analysis

The analysis:

1. Identifies the most recent year available in the dataset using `MAX(year)`.
2. Filters the data to that year.
3. Groups the records by `industry_group`.
4. Counts the number of distinct companies in each industry.
5. Calculates the total product carbon footprint for each industry.
6. Rounds the total footprint to one decimal place.
7. Sorts the industries from the highest to the lowest total carbon footprint.

## SQL Query

```sql
SELECT 
    industry_group,
    COUNT(DISTINCT company) AS num_companies,
    ROUND(SUM(carbon_footprint_pcf), 1) AS total_industry_footprint
FROM product_emissions
WHERE year = (
    SELECT MAX(year)
    FROM product_emissions
)
GROUP BY industry_group
ORDER BY total_industry_footprint DESC;
```
## Results

| Industry Group | Companies | Total Carbon Footprint |
|---|---:|---:|
| Materials | 3 | 107,129.0 |
| Capital Goods | 2 | 94,942.7 |
| Technology Hardware & Equipment | 4 | 21,865.1 |
| Food, Beverage & Tobacco | 1 | 3,161.5 |
| Commercial & Professional Services | 1 | 740.6 |
| Software & Services | 1 | 690.0 |

## Key Findings

- Materials had the highest total product carbon footprint in the most recent year, at 107,129.0.
- Capital Goods had the second-highest total, at 94,942.7.
- Technology Hardware & Equipment recorded a total of 21,865.1 across four distinct companies.
- The remaining industry groups had substantially lower total footprints in the dataset.
- The number of companies represented differs across industry groups, so the totals should not be interpreted as carbon footprint per company.

## Tools

- PostgreSQL
- SQL
- GitHub
- Markdown

## Limitations

- The analysis considers only the most recent year available in the dataset.
- The number of companies represented varies between industry groups.
- The results represent the products and companies included in the dataset and should not necessarily be interpreted as the total carbon footprint of entire industries.
- The analysis describes the recorded product carbon footprints and does not establish causal relationships.

## Project Files

- [Project Source](https://www.nature.com/articles/s41597-022-01178-9)
