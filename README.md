# SQL Data Analysis Portfolio

A collection of practical SQL projects built with **PostgreSQL**. Each project starts with a data question and documents the SQL used to answer it, the resulting output, and the main observations.

The projects progress from foundational filtering and aggregation to joins, subqueries, CTEs, and window functions. The goal is to show how I use SQL to turn structured datasets into clear, reproducible analysis.

## What I Work With

- SQL and PostgreSQL
- Data filtering and aggregation
- `GROUP BY` and aggregate functions
- `JOIN` operations
- Subqueries
- Common Table Expressions (CTEs)
- `CASE` statements
- Window functions
- Ranking and analytical calculations
- Data exploration and interpretation
- Presenting analysis clearly with Markdown

## Projects

These six projects form the **Beginner SQL** section of the portfolio. They cover different datasets and analytical scenarios rather than repeating the same type of query.

### 01. International Student Mental Health Analysis

Explores how average mental health indicators vary across different lengths of stay among international university students.

**Key SQL concepts:** Filtering, `GROUP BY`, `COUNT()`, `AVG()`, `ROUND()`, aggregation

[View Project →](./01-Beginner/Project-01)

---

### 02. Product Carbon Footprint Analysis

Analyzes product carbon footprints across industry groups and compares total footprint values and the number of companies represented in the most recent year.

**Key SQL concepts:** `COUNT(DISTINCT)`, `SUM()`, `ROUND()`, `MAX()`, subqueries, `GROUP BY`

[View Project →](./01-Beginner/Project-02)

---

### 03. Electric Vehicle Charging Session Analysis

Examines shared EV charging behavior in apartment-building parking garages, including user activity, popular charging times, and long-duration sessions.

**Key SQL concepts:** `COUNT(DISTINCT)`, `AVG()`, `HAVING`, `GROUP BY`, CTEs

[View Project →](./01-Beginner/Project-03)

---

### 04. American Baby Names Analysis

Uses historical baby-name data from 1920 to 2020 to explore name popularity, classify names, rank male names, and compare female names across years.

**Key SQL concepts:** `CASE`, CTEs, window functions, `RANK()`, aggregation

[View Project →](./01-Beginner/Project-04)

---

### 05. International Debt Analysis

Analyzes international debt indicators to identify the number of countries represented, the country with the highest total debt, and the lowest principal repayment value.

**Key SQL concepts:** `COUNT(DISTINCT)`, `SUM()`, `MIN()`, filtering, `GROUP BY`, `ORDER BY`

[View Project →](./01-Beginner/Project-05)

---

### 06. Golden Age of Video Games Analysis

Explores video game sales, critic scores, and user ratings to examine sales performance and differences in ratings across release years.

**Key SQL concepts:** `JOIN`, CTEs, `COUNT()`, `AVG()`, `ROUND()`, `HAVING`, filtering

[View Project →](./01-Beginner/Project-06)

## SQL Skills Demonstrated

| Skill | Projects |
|---|---|
| Filtering & aggregation | 01, 02, 03, 05 |
| `GROUP BY` & aggregate functions | 01–06 |
| `COUNT(DISTINCT)` | 02, 03, 05 |
| Subqueries | 02 |
| `HAVING` | 03, 06 |
| Common Table Expressions (CTEs) | 03, 04, 06 |
| `CASE` statements | 04 |
| Window functions & `RANK()` | 04 |
| `INNER JOIN` / `USING` | 06 |
| Multi-table analysis | 06 |

## Repository Structure

```text
sql-projects/
├── README.md
└── 01-Beginner/
    ├── Project-01/
    │   ├── README.md
    │   └── students.csv
    ├── Project-02/
    │   ├── README.md
    │   └── product_emissions.csv
    ├── Project-03/
    │   ├── README.md
    │   └── charging_sessions.csv
    ├── Project-04/
    │   ├── README.md
    │   └── baby_names.csv
    ├── Project-05/
    │   ├── README.md
    │   └── international_debt.csv
    └── Project-06/
        ├── README.md
        ├── game_sales.csv
        ├── reviews.csv
        ├── users_avg_year_rating.csv
        └── yearly rating summary CSVs
```

## About This Repository

I use this repository to document hands-on SQL practice and build a portfolio around practical data questions. Each project includes the dataset used, analytical questions, SQL queries, results, and key observations.

The projects are intentionally focused on SQL analysis rather than presentation-heavy dashboards. As the portfolio develops, later sections will build on this foundation with Python, Excel, Tableau, and Power BI work.
