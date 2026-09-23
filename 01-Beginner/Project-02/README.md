# Product Carbon Footprint Analysis

**SQL | PostgreSQL**

## Project Overview

This project analyzes product carbon footprints (PCFs) across different industry groups using data from **The Carbon Catalogue**.

Product carbon footprints represent the greenhouse gas emissions attributable to a given product, measured in CO₂ (carbon dioxide equivalent).

The analysis focuses on the total product carbon footprint recorded for each industry group in the most recent year available in the dataset.

## Analytical Question

How does the total product carbon footprint vary across industry groups in the most recent year, and how many distinct companies are represented in each industry group?

## Business Context

A sustainability analyst could use this type of analysis to compare recorded product-level emissions across industry groups and identify where the largest footprints occur in the available data.

## Dataset

The project uses the `product_emissions` table in a PostgreSQL database provided in the SQL learning environment.

The dataset contains **866 product records**.

The data comes from **The Carbon Catalogue** and is publicly available through Nature:

[Source: Nature – The Carbon Catalogue](https://www.nature.com/articles/s41597-022-01178-9)

### Table: `product_emissions`

| Column | Data Type | Description |
|---|---|---|
| `id` | VARCHAR | Product record identifier |
| `year` | INT | Year of the recorded product emissions |
| `product_name` | VARCHAR | Name of the product |
| `company` | VARCHAR | Company associated with the product |
| `country` | VARCHAR | Country associated with the product |
| `industry_group` | VARCHAR | Industry classification |
| `weight_kg` | NUMERIC | Product weight in kilograms |
| `carbon_footprint_pcf` | NUMERIC | Product carbon footprint |
| `upstream_percent_total_pcf` | VARCHAR | Upstream emissions as a percentage of total PCF |
| `operations_percent_total_pcf` | VARCHAR | Operations emissions as a percentage of total PCF |
| `downstream_percent_total_pcf` | VARCHAR | Downstream emissions as a percentage of total PCF |

A copy of the dataset used in the analysis is included in this repository:

[Dataset – product_emissions.csv](./product_emissions.csv)

**Note:** The repository CSV includes an additional `index` column from the CSV export. The SQL analysis uses the original `product_emissions` table fields shown above.

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

### Industry Carbon Footprint in the Most Recent Year

The analysis:

1. Identifies the most recent year available using `MAX(year)`.
2. Filters the data to that year.
3. Groups the records by `industry_group`.
4. Counts the number of distinct companies in each industry.
5. Calculates the total product carbon footprint for each industry.
6. Rounds the total footprint to one decimal place.
7. Sorts the industries from the highest to the lowest total carbon footprint.

```sql
SELECT industry_group,
COUNT(DISTINCT company) AS num_companies,
ROUND(SUM(carbon_footprint_pcf), 1) AS total_industry_footprint
FROM product_emissions
WHERE year = (select MAX(year)
	FROM product_emissions)
GROUP BY industry_group
ORDER BY total_industry_footprint DESC;
```

### Result

The most recent year available in the dataset is **2017**.

| Industry Group | Companies | Total Carbon Footprint |
|---|---:|---:|
| Materials | 3 | 107,129.0 |
| Capital Goods | 2 | 94,942.7 |
| Technology Hardware & Equipment | 4 | 21,865.1 |
| Food, Beverage & Tobacco | 1 | 3,161.5 |
| Commercial & Professional Services | 1 | 740.6 |
| Software & Services | 1 | 690.0 |

## Key Findings

- Materials recorded the highest total product carbon footprint in the most recent year available in the dataset, at **107,129.0**.
- Capital Goods recorded a total of **94,942.7**.
- Technology Hardware & Equipment recorded **21,865.1** across four distinct companies.
- Food, Beverage & Tobacco recorded **3,161.5**.
- Commercial & Professional Services recorded **740.6**.
- Software & Services recorded **690.0**.
- The number of companies represented differs across industry groups, so the total footprint should not be interpreted as carbon footprint per company.

## Tools

- PostgreSQL
- SQL
- GitHub
- Markdown

## Limitations

- The analysis considers only the most recent year available in the dataset.
- The number of companies represented varies between industry groups.
- The results represent the products and companies included in the dataset and should not necessarily be interpreted as the total carbon footprint of entire industries.
- The analysis is descriptive and does not establish causal relationships.

## Project Files

- [Dataset – product_emissions.csv](./product_emissions.csv)
- [Project Source – Nature](https://www.nature.com/articles/s41597-022-01178-9)
