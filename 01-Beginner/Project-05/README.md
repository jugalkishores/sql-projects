# International Debt Analysis

**SQL | PostgreSQL**

## Project Overview

Countries may take on external debt to help finance economic development, including infrastructure and other investments.

This project analyzes international debt data collected by the **World Bank** and examines debt owed by developing countries across different debt indicators.

The analysis answers three questions:

- How many distinct countries are present in the database?
- Which country has the highest total amount of debt?
- Which country has the lowest principal repayment amount?

## Analytical Questions

1. What is the number of distinct countries present in the database?
2. What country has the highest amount of debt?
3. What country has the lowest amount of principal repayments?

## Dataset

The project uses the `international_debt` table, which was **pre-loaded in the SQL learning environment**.

The dataset contains information about debt owed by developing countries across several debt indicators.

### Table: `international_debt`

| Column | Data Type | Description |
|---|---|---|
| `country_name` | varchar | Name of the country |
| `country_code` | varchar | Code representing the country |
| `indicator_name` | varchar | Description of the debt indicator |
| `indicator_code` | varchar | Code representing the debt indicator |
| `debt` | float | Value of the debt indicator for the given country in current US dollars |

**Note:** The dataset was provided as a pre-loaded SQL table in the learning environment and is therefore not included as a separate CSV file in this repository.

## SQL Skills

- SELECT
- COUNT()
- COUNT(DISTINCT)
- SUM()
- MIN()
- WHERE
- GROUP BY
- ORDER BY
- LIMIT
- Column aliases

## Analysis

### 1. Number of Distinct Countries

The first query counts the number of unique countries present in the `international_debt` table.

```sql
-- num_distinct_countries 
-- Write your query here... 
SELECT COUNT(DISTINCT country_name) total_distinct_countries
FROM international_debt AS num_distinct_countries;
```

### Result

| total_distinct_countries |
|---:|
| 124 |

There are **124 distinct countries** represented in the dataset.

### 2. Country with the Highest Total Debt

The second query calculates the total debt for each country, sorts the results from highest to lowest, and returns the country with the highest total debt.

```sql
-- highest_debt_country 
-- Write your query here... 
SELECT country_name,
SUM(debt) AS total_debt
FROM international_debt AS highest_debt_country
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;
```

### Result

| country_name | total_debt |
|---|---:|
| China | 285,793,494,734.2 |

**China** had the highest total debt in the query result, with a total of **285,793,494,734.2 US dollars**.

### 3. Country with the Lowest Principal Repayment

The third query filters the data to the principal repayment indicator, finds the minimum repayment value for each country, and returns the lowest value.

```sql
-- lowest_principal_repayment 
-- Write your query here... 
SELECT country_name,
indicator_name,
MIN(debt) AS lowest_repayment
FROM international_debt AS international_debt
WHERE indicator_code = 'DT.AMT.DLXF.CD'
GROUP BY country_name, indicator_name
ORDER BY lowest_repayment
LIMIT 1;
```

### Result

| country_name | indicator_name | lowest_repayment |
|---|---|---:|
| Timor-Leste | Principal repayments on external debt, long-term (AMT, current US$) | 825,000 |

**Timor-Leste** had the lowest principal repayment value in the query result, at **825,000 US dollars**.

## Key Findings

- The dataset contains **124 distinct countries**.
- China had the highest total debt in the analysis, with **285,793,494,734.2 US dollars**.
- Timor-Leste had the lowest principal repayment value for the selected indicator, at **825,000 US dollars**.
- The analysis demonstrates how SQL aggregation and filtering can be used to compare international debt indicators across countries.

## Tools

- PostgreSQL
- SQL
- GitHub
- Markdown

## Limitations

- The analysis is based on the countries and debt indicators included in the provided dataset.
- The dataset was pre-loaded in the SQL learning environment rather than provided as a separate CSV file.
- The analysis is descriptive and does not explain the economic factors behind differences in debt or repayment values.
- Debt values are reported in current US dollars as represented in the dataset.
