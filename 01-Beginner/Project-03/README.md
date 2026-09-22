# Electric Vehicle Charging Session Analysis

**SQL | PostgreSQL**

## Project Overview

As electric vehicles (EVs) become more popular, apartment buildings are increasingly adding shared charging stations to their parking garages.

This project analyzes EV charging session data to help apartment building managers better understand how tenants use shared charging stations.

The analysis focuses on:

- The number of unique shared-charging users at each garage
- The most popular days and hours for shared charging sessions
- Users with an average shared-charging session duration of more than 10 hours

## Analytical Questions

1. How many unique users use shared charging stations at each garage?
2. What are the most popular days and hours for shared charging sessions?
3. Which shared-charging users have an average charging duration of more than 10 hours?

## Dataset

The data is stored in the `charging_sessions` table.

The table contains the following variables:

- `garage_id` — identifier for the garage or building
- `user_id` — identifier for the individual user
- `user_type` — indicates whether the station is Shared or Private
- `start_plugin` — date and time the charging session started
- `start_plugin_hour` — hour when the charging session started
- `end_plugout` — date and time the charging session ended
- `end_plugout_hour` — hour when the charging session ended
- `duration_hours` — length of the charging session in hours
- `el_kwh` — electricity used in kilowatt hours
- `month_plugin` — month when the session started
- `weekdays_plugin` — day of the week when the session started

The dataset is available under **CC BY 4.0** through Kaggle:

[EV Charging from Apartment Buildings – Kaggle](https://www.kaggle.com/datasets/anshtanwar/residential-ev-chargingfrom-apartment-buildings)

## SQL Skills

- SELECT
- WHERE
- COUNT()
- COUNT(DISTINCT)
- AVG()
- GROUP BY
- HAVING
- ORDER BY
- LIMIT
- Common Table Expressions (CTEs)

## Analysis

### 1. Unique Shared-Charging Users per Garage

The first analysis counts the distinct users at each garage who use shared charging stations.

```sql
WITH unique_users_per_garage AS (
    SELECT 
        garage_id,
        COUNT(DISTINCT user_id) AS num_unique_users
    FROM charging_sessions
    WHERE user_type = 'Shared'
    GROUP BY garage_id
    ORDER BY num_unique_users DESC
)
SELECT *
FROM unique_users_per_garage;
```

### 2. Most Popular Shared-Charging Start Times

The second analysis identifies the ten most common combinations of weekday and starting hour for shared charging sessions.

```sql
WITH most_popular_shared_start_times AS (
    SELECT 
        weekdays_plugin,
        start_plugin_hour,
        COUNT(*) AS num_charging_sessions
    FROM charging_sessions
    WHERE user_type = 'Shared'
    GROUP BY weekdays_plugin, start_plugin_hour
    ORDER BY num_charging_sessions DESC
    LIMIT 10
)
SELECT *
FROM most_popular_shared_start_times;
```

### 3. Users with Long Average Charging Sessions

The third analysis identifies shared-charging users whose average charging session lasts more than 10 hours.

```sql
WITH long_duration_shared_users AS (
    SELECT 
        user_id,
        AVG(duration_hours) AS avg_charging_duration
    FROM charging_sessions
    WHERE user_type = 'Shared'
    GROUP BY user_id
    HAVING AVG(duration_hours) > 10
    ORDER BY avg_charging_duration DESC
)
SELECT *
FROM long_duration_shared_users;
```

## Results

The SQL analysis produces three result sets:

- A list of garages ranked by the number of unique shared-charging users.
- The ten most common weekday and starting-hour combinations for shared charging sessions.
- A list of shared-charging users whose average charging session duration exceeds 10 hours.

## Key Findings

- Shared charging usage can be compared across garages by counting distinct users.
- Charging demand can be examined by combining the weekday and starting hour of each session.
- Users with average charging durations above 10 hours can be identified using `GROUP BY` and `HAVING`.
- The analysis provides descriptive insights into shared EV charging behavior in apartment buildings.

## Tools

- PostgreSQL
- SQL
- GitHub
- Markdown

## Limitations

- The analysis focuses specifically on sessions where `user_type` is `Shared`.
- The results describe the charging sessions represented in the dataset and may not represent all apartment buildings or EV users.
- The analysis is descriptive and does not explain why users choose particular charging times or durations.
- The SQL queries in the source project do not provide statistical testing or causal analysis.

## Project Files

- [Dataset](./Dataset%201_EV%20charging%20reports.csv)
- [Original Dataset Source – Kaggle](https://www.kaggle.com/datasets/anshtanwar/residential-ev-chargingfrom-apartment-buildings)
