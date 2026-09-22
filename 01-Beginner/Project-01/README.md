# International Student Mental Health Analysis

**DataCamp Guided Project | SQL | PostgreSQL**

## Project Overview

This project explores the mental health of international university students and examines how mental health indicators vary across different lengths of stay.

The analysis focuses on three measures:

- PHQ-9 depression score
- Social connectedness score (SCS)
- Acculturative stress score (ASISS)

## Analytical Question

Does the length of stay of international students show differences in their average:

- Depression scores?
- Social connectedness?
- Acculturative stress?

## Dataset

The project uses a student survey dataset containing demographic, academic, social, and mental-health-related information.

## SQL Skills

- SELECT
- WHERE
- GROUP BY
- COUNT()
- AVG()
- ROUND()
- ORDER BY
- LIMIT

## Project Type

This is a **DataCamp Guided Project** completed as part of my SQL learning journey.

## Analysis

The analysis focuses specifically on international students and groups them by their current length of stay.

For each length-of-stay group, the analysis calculates:

- Number of international students
- Average PHQ-9 depression score
- Average social connectedness score
- Average acculturative stress score

## SQL Query

```sql
SELECT 
    stay,
    COUNT(inter_dom) AS count_int,
    ROUND(AVG(todep), 2) AS average_phq,
    ROUND(AVG(tosc), 2) AS average_scs,
    ROUND(AVG(toas), 2) AS average_as
FROM students
WHERE inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay DESC
LIMIT 9;
```

## Results

| Stay (Years) | International Students | Avg PHQ | Avg SCS | Avg AS |
|---:|---:|---:|---:|---:|
| 10 | 1 | 13.00 | 32.00 | 50.00 |
| 8 | 1 | 10.00 | 44.00 | 65.00 |
| 7 | 1 | 4.00 | 48.00 | 45.00 |
| 6 | 3 | 6.00 | 38.00 | 58.67 |
| 5 | 1 | 0.00 | 34.00 | 91.00 |
| 4 | 14 | 8.57 | 33.93 | 87.71 |
| 3 | 46 | 9.09 | 37.13 | 78.00 |
| 2 | 39 | 8.28 | 37.08 | 77.67 |
| 1 | 95 | 7.48 | 38.11 | 72.80 |
