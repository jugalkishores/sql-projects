# American Baby Names Analysis

**SQL | PostgreSQL**

## Project Overview

How have American baby name tastes changed since 1920? Which names have remained popular for over 100 years, and how do those names compare to more recent top baby names?

This project analyzes American baby-name data to explore long-term naming trends and popularity.

The dataset was provided by the **United States Social Security Administration (SSA)** and contains first names, the number of babies given each name, and the sex of the babies in each year.

The data spans **101 years, from 1920 through 2020**.

## Analytical Questions

1. What are the overall top five names in alphabetical order, and are they classified as "Classic" or "Trendy"?
2. What were the top 20 male names overall, and how did the name Paul rank?
3. Which female names appeared in both 1920 and 2020?

## Dataset

The project uses the `baby_names` table, which was **pre-loaded in the SQL learning environment**.

For processing speed, the dataset is limited to first names which were given to **over 5,000 American babies in a given year**.

### Table: `baby_names`

| Column | Type | Description |
|---|---|---|
| `year` | int | Year |
| `first_name` | varchar | First name |
| `sex` | varchar | Sex of babies given `first_name` |
| `num` | int | Number of babies of `sex` given `first_name` in that year |

A copy of the dataset used in the analysis is included in this repository:

[Dataset – baby_names.csv](./baby_names.csv)

**Note:** The repository CSV includes an additional `index` column from the CSV export. The SQL analysis uses the original `baby_names` table fields shown above.

## SQL Skills

- SELECT
- COUNT()
- CASE WHEN
- WHERE
- GROUP BY
- ORDER BY
- LIMIT
- Common Table Expressions (CTEs)
- Window Functions
- RANK()

## Analysis

### 1. Classic vs. Trendy Names

The first query lists the first five names in alphabetical order and classifies each name as either **"Classic"** or **"Trendy"** based on how many times the name appears in the dataset.

```sql
-- Use this table for the answer to question 1:
-- List the overall top five names in alphabetical order and find out if each name is "Classic" or "Trendy."
WITH name_types AS (SELECT first_name,
COUNT(first_name) AS sum,
CASE WHEN COUNT(first_name) >= 50 THEN 'Classic'
	ELSE 'Trendy' END AS popularity_type
FROM baby_names
GROUP BY first_name
ORDER BY first_name
LIMIT 5)
SELECT *
FROM name_types;
```

#### Result

| first_name | sum | popularity_type |
|---|---:|---|
| Aaliyah | 3 | Trendy |
| Aaron | 51 | Classic |
| Abigail | 28 | Trendy |
| Adam | 46 | Trendy |
| Addison | 13 | Trendy |

### 2. Top 20 Male Names and Paul's Rank

The second query ranks male names by their number of occurrences in the dataset and returns the top 20 results.

```sql
-- Use this table for the answer to question 2:
-- What were the top 20 male names overall, and how did the name Paul rank?
WITH top_20 AS (SELECT RANK() OVER(ORDER BY COUNT(first_name) DESC) AS name_rank,
first_name,
COUNT(first_name) AS sum
FROM baby_names
WHERE sex = 'M'
GROUP BY first_name
LIMIT 20)
SELECT *
FROM top_20
ORDER BY name_rank, first_name;
-- Paul rank 13
```

#### Result

| name_rank | first_name | sum |
|---:|---|---:|
| 1 | Charles | 101 |
| 1 | William | 101 |
| 1 | David | 101 |
| 1 | Thomas | 101 |
| 1 | James | 101 |
| 1 | John | 101 |
| 1 | Joseph | 101 |
| 8 | Robert | 99 |
| 9 | Anthony | 86 |
| 10 | Michael | 85 |
| 11 | Richard | 84 |
| 11 | Daniel | 84 |
| 13 | Paul | 76 |
| 13 | Kenneth | 76 |
| 15 | Edward | 73 |
| 16 | Christopher | 70 |
| 16 | Andrew | 70 |
| 18 | Kevin | 65 |
| 18 | Donald | 65 |
| 20 | Matthew | 64 |

**Paul's rank: 13**

### 3. Female Names in 1920 and 2020

The third query examines female names appearing in the selected years, 1920 and 2020. A `total_occurrences` value of `2` indicates that the name appeared in both years.

```sql
-- Use this table for the answer to question 3:
-- Which female names appeared in both 1920 and 2020?
WITH a_names AS (SELECT first_name,
COUNT(first_name) AS total_occurrences
FROM baby_names
WHERE sex = 'F'
AND year IN (1920, 2020)
GROUP BY first_name)
SELECT *
FROM a_names;
```

#### Result

| first_name | total_occurrences |
|---|---:|
| Abigail | 1 |
| Alice | 1 |
| Amelia | 1 |
| Ann | 1 |
| Anna | 1 |
| Annie | 1 |
| Aria | 1 |
| Aurora | 1 |
| Ava | 1 |
| Avery | 1 |
| Barbara | 1 |
| Beatrice | 1 |
| Bernice | 1 |
| Betty | 1 |
| Camila | 1 |
| Catherine | 1 |
| Charlotte | 1 |
| Chloe | 1 |
| Clara | 1 |
| Doris | 1 |
| Dorothy | 1 |
| Edith | 1 |
| Edna | 1 |
| Eleanor | 2 |
| Elizabeth | 2 |
| Ella | 1 |
| Ellie | 1 |
| Emily | 1 |
| Emma | 2 |
| Esther | 1 |
| Ethel | 1 |
| Evelyn | 2 |
| Florence | 1 |
| Frances | 1 |
| Gertrude | 1 |
| Gianna | 1 |
| Gladys | 1 |
| Grace | 1 |
| Harper | 1 |
| Hazel | 2 |
| Helen | 1 |
| Irene | 1 |
| Isabella | 1 |
| Jane | 1 |
| Jean | 1 |
| Josephine | 1 |
| Katherine | 1 |
| Layla | 1 |
| Lillian | 1 |
| Lily | 1 |
| Lois | 1 |
| Louise | 1 |
| Lucille | 1 |
| Luna | 1 |
| Madison | 1 |
| Margaret | 1 |
| Marie | 1 |
| Marion | 1 |
| Marjorie | 1 |
| Martha | 1 |
| Mary | 1 |
| Mia | 1 |
| Mila | 1 |
| Mildred | 1 |
| Nora | 1 |
| Olivia | 1 |
| Pauline | 1 |
| Penelope | 1 |
| Riley | 1 |
| Rose | 1 |
| Ruby | 1 |
| Ruth | 1 |
| Sarah | 1 |
| Scarlett | 1 |
| Sofia | 1 |
| Sophia | 1 |
| Thelma | 1 |
| Victoria | 1 |
| Violet | 1 |
| Virginia | 1 |
| Zoey | 1 |

## Key Findings

- The first query classified the five alphabetically selected names based on how frequently they appeared in the dataset.
- Aaron was classified as **Classic**, while Aaliyah, Abigail, Adam, and Addison were classified as **Trendy** according to the query's classification rule.
- The male-name ranking shows several names tied at rank 1 because they each appeared in all 101 years of the dataset.
- Paul had a rank of **13**, with 76 occurrences across the dataset.
- In the female-name analysis, names with `total_occurrences = 2` appeared in both 1920 and 2020.
- The names appearing in both selected years include **Eleanor, Elizabeth, Emma, Evelyn, and Hazel**.

## Tools

- PostgreSQL
- SQL
- GitHub
- Markdown

## Limitations

- The dataset is limited to first names given to more than 5,000 American babies in a given year.
- The dataset covers the period from 1920 through 2020.
- The analysis is descriptive and does not explain the reasons behind changes in baby-name popularity.
- The dataset was pre-loaded in the SQL learning environment, while a copy is also included in this repository for reference.


## Project Files

- [Dataset – baby_names.csv](./baby_names.csv)
