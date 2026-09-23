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

The project uses the `charging_sessions` table, which was **pre-loaded in the SQL learning environment**.

The dataset contains information about EV charging sessions in apartment-building parking garages.

### Table: `charging_sessions`

| Column | Definition | Data Type |
|---|---|---|
| `garage_id` | Identifier for the garage/building | VARCHAR |
| `user_id` | Identifier for the individual user | VARCHAR |
| `user_type` | Indicates whether the station is `Shared` or `Private` | VARCHAR |
| `start_plugin` | Date and time the session started | DATETIME |
| `start_plugin_hour` | Hour in military time that the session started | NUMERIC |
| `end_plugout` | Date and time the session ended | DATETIME |
| `end_plugout_hour` | Hour in military time that the session ended | NUMERIC |
| `duration_hours` | Length of the session in hours | NUMERIC |
| `el_kwh` | Amount of electricity used in kilowatt hours | NUMERIC |
| `month_plugin` | Month that the session started | VARCHAR |
| `weekdays_plugin` | Day of the week that the session started | VARCHAR |

The dataset is available under **CC BY 4.0** through Kaggle:

[EV Charging from Apartment Buildings – Kaggle](https://www.kaggle.com/datasets/anshtanwar/residential-ev-chargingfrom-apartment-buildings)

**Note:** The analysis was performed on the `charging_sessions` table pre-loaded in the SQL learning environment. A copy of the dataset is also included in this repository as `charging_sessions.csv`. The SQL results shown in this README are based on the original SQL table used for the analysis.

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
-- unique_users_per_garage
WITH unique_users_per_garage AS (SELECT garage_id,
COUNT(DISTINCT user_id)	AS num_unique_users
FROM charging_sessions
WHERE user_type = 'Shared'
GROUP BY garage_id
ORDER BY num_unique_users DESC)
SELECT *
FROM unique_users_per_garage;
```

#### Result

| garage_id | num_unique_users |
|---|---:|
| Bl2 | 18 |
| AsO2 | 17 |
| UT9 | 16 |
| AdO3 | 3 |
| MS1 | 2 |
| SR2 | 2 |
| AdA1 | 1 |
| Ris | 1 |

### 2. Most Popular Shared-Charging Start Times

The second analysis identifies the ten most common combinations of weekday and starting hour for shared charging sessions.

```sql
-- most_popular_shared_start_times
WITH most_popular_shared_start_times AS (
	SELECT weekdays_plugin,
	start_plugin_hour,
	COUNT(*) AS num_charging_sessions
	FROM charging_sessions
	WHERE user_type = 'Shared'
	GROUP BY weekdays_plugin, start_plugin_hour
	ORDER BY num_charging_sessions DESC
	LIMIT 10)
SELECT *
FROM most_popular_shared_start_times;
```

#### Result

| weekdays_plugin | start_plugin_hour | num_charging_sessions |
|---|---:|---:|
| Sunday | 17 | 30 |
| Friday | 15 | 28 |
| Thursday | 16 | 26 |
| Thursday | 19 | 26 |
| Sunday | 18 | 25 |
| Sunday | 15 | 25 |
| Wednesday | 19 | 25 |
| Monday | 15 | 24 |
| Friday | 16 | 24 |
| Sunday | 14 | 23 |

### 3. Users with Long Average Charging Sessions

The third analysis identifies shared-charging users whose average charging session duration is greater than 10 hours.

```sql
-- long_duration_shared_users
WITH long_duration_shared_users AS (
	SELECT user_id,
	AVG(duration_hours) AS avg_charging_duration
	FROM charging_sessions
	WHERE user_type = 'Shared'
	GROUP BY user_id
	HAVING AVG(duration_hours) > 10
	ORDER BY avg_charging_duration DESC)
SELECT *
FROM long_duration_shared_users;
```

#### Result

| user_id | avg_charging_duration |
|---|---:|
| Share-9 | 16.845833335 |
| Share-17 | 12.8945555511 |
| Share-25 | 12.2144747466 |
| Share-18 | 12.0888071898 |
| Share-8 | 11.5504308392 |
| AdO3-1 | 10.3693869729 |

## Key Findings

- Garage `Bl2` had the highest number of unique shared-charging users with **18 users**.
- The most frequent shared-charging start time in the result set was **Sunday at 17:00**, with **30 sessions**.
- Six shared-charging users had an average charging duration of more than **10 hours**.
- `Share-9` had the highest average charging duration in the result set at approximately **16.85 hours**.
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
- The dataset was pre-loaded in the SQL learning environment.

## Project Files

- [Dataset – charging_sessions.csv](./charging_sessions.csv)
- [Original Dataset Source – Kaggle](https://www.kaggle.com/datasets/anshtanwar/residential-ev-chargingfrom-apartment-buildings)
