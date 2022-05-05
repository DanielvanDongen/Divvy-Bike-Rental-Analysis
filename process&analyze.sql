use casestudybike;

-- Cleaning (triplength)

-- Find out if the data set contains any extrem values that doesn't make sense.
SELECT max(ride_length) AS Maximal, min(ride_length) AS Minimal FROM triplength;

-- Clean all rows which ride_length is zero.
SELECT * FROM triplength WHERE ride_length = "00:00:00";
DELETE FROM triplength WHERE ride_length = "00:00:00";


-- Cleaning (tripdata)

-- Find out if there are any empty cells. 
SELECT * FROM tripdata WHERE end_station_id IS NULL OR end_station_name IS NULL;
SELECT * FROM tripdata WHERE start_station_id IS NULL OR start_station_name IS NULL;
SELECT * FROM tripdata WHERE started_at IS NULL OR ended_at IS NULL OR member_casusl IS NULL;


-- Deleting all columns which I dont work with: rideable_type, start_lat, start_lng, end_lat, end_lng
ALTER TABLE tripdata
DROP COLUMN rideable_type;

ALTER TABLE tripdata 
DROP COLUMN start_lat;

ALTER TABLE tripdata 
DROP COLUMN start_lng;

ALTER TABLE tripdata 
DROP COLUMN end_lat;

ALTER TABLE tripdata 
DROP COLUMN end_lng;



-- Analyze

-- How many trips were riden by members/casuals?
SELECT COUNT(*) AS Amount_of_casuals FROM tripdata WHERE member_casual = "casual";
SELECT COUNT(*) AS Amount_of_members FROM tripdata WHERE member_casual = "member";


-- Which start_Stations are used the most ? 
SELECT start_station_id, start_station_name, COUNT(*) AS Amount_of_trips_from_each_station 
FROM tripdata GROUP BY start_station_id ORDER BY Amount_of_trips_from_each_station DESC;

SELECT start_station_id, start_station_name, member_casual, COUNT(*) AS Amount_of_trips_from_each_station 
FROM tripdata WHERE member_casual = "member" GROUP BY start_station_id ORDER BY Amount_of_trips_from_each_station DESC;

SELECT start_station_id, start_station_name, member_casual, COUNT(*) AS Amount_of_trips_from_each_station
FROM tripdata WHERE member_casual = "casual" GROUP BY start_station_id ORDER BY Amount_of_trips_from_each_station DESC;


-- Which end_Stations are used the most ? 
SELECT end_station_id, end_station_name, COUNT(*) AS Amount_of_trips_from_each_station 
FROM tripdata 
GROUP BY end_station_id ORDER BY Amount_of_trips_from_each_station DESC;

SELECT end_station_id, end_station_name, member_casual, COUNT(*) AS Amount_of_trips_from_each_station 
FROM tripdata 
WHERE member_casual = "member" GROUP BY end_station_id ORDER BY Amount_of_trips_from_each_station DESC;

SELECT end_station_id, end_station_name, member_casual, COUNT(*) AS Amount_of_trips_from_each_station 
FROM tripdata 
WHERE member_casual = "casual" GROUP BY end_station_id ORDER BY Amount_of_trips_from_each_station DESC;



-- How many members/casuals have a 00:01:00, 00:10:00, 01:00:00 or longer ride_length?
-- 00:01:00 
SELECT COUNT(*) AS Amount_of_casuals
FROM tripdata NATURAL INNER JOIN triplength 
WHERE member_casual = "casual" AND ride_length <= "00:01:00";

SELECT COUNT(*) AS Amount_of_members 
FROM tripdata NATURAL INNER JOIN triplength 
WHERE member_casual = "member" AND ride_length <= "00:01:00";

-- 00:10:00 
SELECT COUNT(*) AS Amount_of_casuals 
FROM tripdata NATURAL INNER JOIN triplength 
WHERE member_casual = "casual" AND ride_length <= "00:10:00" AND ride_length > "00:01:00";

SELECT COUNT(*) AS Amount_of_members 
FROM tripdata NATURAL INNER JOIN triplength 
WHERE member_casual = "member" AND ride_length <= "00:10:00" AND ride_length > "00:01:00";

-- 01:00:00 
SELECT COUNT(*) AS Amount_of_casuals 
FROM tripdata NATURAL INNER JOIN triplength 
WHERE member_casual = "casual" AND ride_length <= "01:00:00" AND ride_length > "00:10:00";

SELECT COUNT(*) AS Amount_of_members 
FROM tripdata NATURAL INNER JOIN triplength 
WHERE member_casual = "member" AND ride_length <= "01:00:00" AND ride_length > "00:10:00";

-- >01:00:00
SELECT COUNT(*) AS Amount_of_casuals 
FROM tripdata NATURAL INNER JOIN triplength 
WHERE member_casual = "casual" AND ride_length > "01:00:00";

SELECT COUNT(*) AS Amount_of_members 
FROM tripdata NATURAL INNER JOIN triplength 
WHERE member_casual = "member" AND ride_length > "01:00:00";



-- In which time frame, are most trips made ? 
-- time frames 00:00:00 -> 24:00:00

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%00:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%01:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%02:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%03:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%04:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%05:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%06:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%07:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%08:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%09:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%10:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%11:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%12:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%13:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%14:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%15:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%16:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%17:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%18:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%19:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%20:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%21:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%22:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%23:__:__" GROUP BY member_casual;
