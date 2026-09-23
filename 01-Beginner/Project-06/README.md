# Golden Age of Video Games Analysis

**SQL | PostgreSQL**

## Project Overview

Video games are big business, with billions of dollars generated through game sales worldwide. This project explores whether there has been a "golden age" of video games by analyzing critic reviews, user ratings, and sales data.

The analysis examines the top 400 video games released since 1977 and explores:

- The best-selling video games
- The years with the highest average critic scores
- Years where users or critics gave exceptionally high ratings

The project uses SQL techniques including joins, aggregations, filtering, ordering, Common Table Expressions (CTEs), and comparisons between datasets.

## Analytical Questions

1. Which are the top 10 best-selling video games?
2. Which years have the highest average critic scores?
3. Which years could be considered "golden years" based on critic and user ratings?

## Dataset

The SQL learning environment provided a **limited version of the video game dataset**, with the relevant tables restricted to 400 rows for the project.

The complete dataset contains **more than 13,000 video games** and is available on Kaggle.

### Source Dataset

[Video Game Sales Data – Kaggle](https://www.kaggle.com/datasets/holmjason2/videogamedata)

The Kaggle dataset contains video game information covering games from 1977 through the middle of 2020. The data primarily comes from VGChartz, while critic and user scores were collected from sources including Metacritic.

**Note:** Copies of all four tables used in the SQL analysis are included in this repository as CSV files. The CSV exports include an additional `index` column from the export; the SQL analysis uses the original table fields shown above.

## Database Tables

### Table: `game_sales`

| Column | Data Type | Description |
|---|---|---|
| `name` | varchar | Name of the video game |
| `platform` | varchar | Gaming platform |
| `publisher` | varchar | Game publisher |
| `developer` | varchar | Game developer |
| `games_sold` | float | Number of copies sold, in millions |
| `year` | int | Release year |

### Table: `reviews`

| Column | Data Type | Description |
|---|---|---|
| `name` | varchar | Name of the video game |
| `critic_score` | float | Critic score according to Metacritic |
| `user_score` | float | User score according to Metacritic |

### Table: `users_avg_year_rating`

| Column | Data Type | Description |
|---|---|---|
| `year` | int | Release year of the games reviewed |
| `num_games` | int | Number of games released that year |
| `avg_user_score` | float | Average user score for the year |

### Table: `critics_avg_year_rating`

| Column | Data Type | Description |
|---|---|---|
| `year` | int | Release year of the games reviewed |
| `num_games` | int | Number of games released that year |
| `avg_critic_score` | float | Average critic score for the year |

## SQL Skills

- SELECT
- Common Table Expressions (CTEs)
- INNER JOIN
- USING
- COUNT()
- AVG()
- ROUND()
- WHERE
- HAVING
- ORDER BY
- LIMIT
- Arithmetic calculations
- Table joins

## Analysis

### 1. Top 10 Best-Selling Video Games

The first analysis identifies the ten best-selling games based on the number of copies sold.

```sql
-- best_selling_games
WITH best_selling_games AS (SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10)
SELECT *
FROM best_selling_games;
```

### Result

| Name | Platform | Publisher | Developer | Games Sold (Millions) | Year |
|---|---|---|---|---:|---:|
| Wii Sports for Wii | Wii | Nintendo | Nintendo EAD | 82.90 | 2006 |
| Super Mario Bros. for NES | NES | Nintendo | Nintendo R&D4 | 40.24 | 1985 |
| Counter-Strike: Global Offensive for PC | PC | Valve | Valve Corporation | 40.00 | 2012 |
| Mario Kart Wii for Wii | Wii | Nintendo | Nintendo EAD | 37.32 | 2008 |
| PLAYERUNKNOWN'S BATTLEGROUNDS for PC | PC | PUBG Corporation | PUBG Corporation | 36.60 | 2017 |
| Minecraft for PC | PC | Mojang | Mojang | 33.15 | 2010 |
| Wii Sports Resort for Wii | Wii | Nintendo | Nintendo EAD | 33.13 | 2009 |
| Pokemon Red / Green / Blue Version for GB | GB | Nintendo | Game Freak | 31.38 | 1998 |
| New Super Mario Bros. for DS | DS | Nintendo | Nintendo EAD | 30.80 | 2006 |
| New Super Mario Bros. Wii for Wii | Wii | Nintendo | Nintendo EAD | 30.30 | 2009 |

### 2. Years with the Highest Average Critic Scores

The second analysis joins `reviews` with `game_sales`, groups games by release year, calculates the average critic score, and returns the ten highest-rated years. Only years with more than four reviewed games are included.

```sql
-- critics_top_ten_years
WITH critics_top_ten_years AS (SELECT gs.year,
COUNT(*) AS num_games,
ROUND(AVG(critic_score), 2) AS avg_critic_score
FROM reviews AS rs
INNER JOIN game_sales AS gs
ON rs.name = gs.name
GROUP BY year
HAVING count(*) > 4
ORDER BY avg_critic_score DESC, year DESC
LIMIT 10)
SELECT *
FROM critics_top_ten_years;
```

### Result

| Year | Number of Games | Average Critic Score |
|---:|---:|---:|
| 1998 | 10 | 9.32 |
| 2004 | 11 | 9.03 |
| 2002 | 9 | 8.99 |
| 1999 | 11 | 8.93 |
| 2001 | 13 | 8.82 |
| 2011 | 26 | 8.76 |
| 2016 | 13 | 8.67 |
| 2013 | 18 | 8.66 |
| 2008 | 20 | 8.63 |
| 2017 | 13 | 8.62 |

### 3. Years with High Critic or User Ratings

The third analysis joins the yearly critic and user rating tables and identifies years where either the average critic score or average user score was above 9.

The `diff` column shows the difference between the average critic score and average user score.

```sql
-- golden_years
WITH golden_years AS (SELECT ct.year,
ct.num_games,
ct.avg_critic_score,
ut.avg_user_score,
ct.avg_critic_score - ut.avg_user_score AS diff
FROM critics_avg_year_rating AS ct
INNER JOIN users_avg_year_rating AS ut
USING (year)
WHERE ct.avg_critic_score > 9
OR ut.avg_user_score > 9
ORDER BY year)
SELECT *
FROM golden_years;
```

### Result

| Year | Number of Games | Average Critic Score | Average User Score | Difference |
|---:|---:|---:|---:|---:|
| 1997 | 8 | 7.93 | 9.50 | -1.57 |
| 1998 | 10 | 9.32 | 9.40 | -0.08 |
| 2004 | 11 | 9.03 | 8.55 | 0.48 |
| 2008 | 20 | 8.63 | 9.03 | -0.40 |
| 2009 | 20 | 8.55 | 9.18 | -0.63 |
| 2010 | 23 | 8.41 | 9.24 | -0.83 |

## Key Findings

- `Wii Sports for Wii` was the highest-selling game in the dataset, with **82.90 million copies sold**.
- `1998` had the highest average critic score among the years meeting the query's minimum of more than four reviewed games, with an average score of **9.32**.
- Several years had an average user score above 9, including **1997, 1998, 2008, 2009, and 2010**.
- `1998` was the only year in the final result where both the average critic score and average user score were above 9.
- The comparison between critic and user scores shows that the two groups did not always rate the same years equally.

## Tools

- PostgreSQL
- SQL
- GitHub
- Markdown

## Limitations

- The SQL learning environment used a limited set of 400 rows for the project rather than the complete dataset.
- The complete dataset contains more than 13,000 games, so results from the project tables should not be interpreted as an analysis of the full Kaggle dataset.
- The analysis depends on the games and ratings available in the provided tables.
- The use of average scores can be affected by the number of games represented in each year.
- The project tables contain 400 game records and 400 review records, while the yearly rating tables contain 24 years of summarized data.
- The analysis is descriptive and does not establish why particular years received higher critic or user ratings.

## Project Files

- [Dataset – game_sales.csv](./game_sales.csv)
- [Dataset – reviews.csv](./reviews.csv)
- [Dataset – users_avg_year_rating.csv](./users_avg_year_rating.csv)
- [Dataset – critics_avg_year_rating.csv](./critics_avg_year_rating.csv)
- [Original Dataset Source – Kaggle](https://www.kaggle.com/datasets/holmjason2/videogamedata)
