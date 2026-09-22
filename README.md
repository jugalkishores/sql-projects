# SQL Data Analysis Portfolio

A collection of SQL projects built to develop practical skills in querying, analyzing, and interpreting data using **PostgreSQL**.

This repository documents my progression from foundational SQL concepts to more advanced querying techniques through projects based on different real-world datasets and analytical questions.

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

## Repository Structure

```text
sql-projects/
└── 01-Beginner/
    ├── Project-01/
    │   ├── README.md
    │   └── students.csv
    ├── Project-02/
    │   └── README.md
    ├── Project-03/
    │   ├── README.md
    │   └── ev_charging_sessions.csv
    ├── Project-04/
    │   └── README.md
    ├── Project-05/
    │   └── README.md
    └── Project-06/
        └── README.md
```

## About This Repository

I use this repository to document my hands-on SQL learning and build a portfolio of projects that demonstrate how I approach data questions using SQL.

Each project includes the analytical questions, SQL queries, results, and key observations from the analysis.

More projects will be added as I continue developing my SQL and data analysis skills.
