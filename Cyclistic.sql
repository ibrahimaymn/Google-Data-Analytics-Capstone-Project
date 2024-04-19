-- Finding out difference between casual riders and members 

-- average trip_duration
SELECT 
  user_type,
  AVG((EXTRACT(EPOCH FROM ended_at) - EXTRACT(EPOCH FROM started_at)) / 60) AS avg_trip_duration_mins
FROM 
  year_2023
GROUP BY
  user_type;
-- casual riders tend to have longer trips than members

-- Which day of the week is them most busy for casual riders and member?
SELECT 
  TO_CHAR(started_at , 'Day') AS day,
  SUM(CASE WHEN user_type = 'casual' THEN 1 ELSE 0 END) AS casual_trip_count,
  SUM(CASE WHEN user_type = 'member' THEN 1 ELSE 0 END) AS member_trip_count
FROM 
  year_2023
GROUP BY 
  TO_CHAR(started_at , 'Day');
-- casual riders ride more often at the weekends while members ride more in the middle of the week

-- Busiest hours
SELECT 
  hours,
  SUM(CASE WHEN user_type = 'casual' THEN 1 ELSE 0 END) AS casual_trip_count,
  SUM(CASE WHEN user_type = 'member' THEN 1 ELSE 0 END) AS member_trip_count
FROM
(SELECT  
  user_type,
  (CASE
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 0 AND 2 THEN 'From 12AM to 2AM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 2 AND 4 THEN 'From 2AM to 4AM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 4 AND 6 THEN 'From 4AM to 6AM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 6 AND 8 THEN 'From 6AM to 8AM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 8 AND 10 THEN 'From 8AM to 10AM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 10 AND 12 THEN 'From 10AM to 12PM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 12 AND 14 THEN 'From 12PM to 2PM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 14 AND 16 THEN 'From 2PM to 4PM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 16 AND 18 THEN 'From 4PM to 6PM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 18 AND 20 THEN 'From 6PM to 8PM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 20 AND 22 THEN 'From 8PM to 10PM'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 22 AND 24 THEN 'From 10PM to 12AM'
    END) AS hours
FROM 
  year_2023) hours_classification
GROUP BY 
  hours;
-- both members and casual rider's busiest hours are From 4PM to 6PM and From 2PM to 4PM

--Most used bike type
-- casual:
SELECT 
  bike_type,
  SUM(CASE WHEN user_type = 'casual' THEN 1 ELSE 0 END) AS casual_bike_count,
  SUM(CASE WHEN user_type = 'member' THEN 1 ELSE 0 END) AS member_bike_count
FROM 
  year_2023
GROUP BY 
  bike_type;

--
SELECT 
  TO_CHAR(started_at , 'YYYY-MM-DD') AS date,
  SUM(CASE WHEN user_type = 'casual' THEN 1 ELSE 0 END) AS casual_trip_count,
  SUM(CASE WHEN user_type = 'member' THEN 1 ELSE 0 END) AS member_trip_count
FROM
  year_2023
GROUP BY 
  TO_CHAR(started_at , 'YYYY-MM-DD');