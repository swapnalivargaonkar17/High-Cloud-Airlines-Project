CREATE DATABASE highclouds;
USE highclouds;
SHOW TABLES;
DESCRIBE maindata;

## date column 
ALTER TABLE maindata
ADD COLUMN FlightDate DATE;

ALTER TABLE maindata
ADD COLUMN FlightDate DATE;

SET SQL_SAFE_UPDATES = 0;
## date coulumn 

UPDATE maindata
SET FlightDate = STR_TO_DATE(CONCAT(`Year`,'-',`Month (#)`,'-',`Day`),'%Y-%m-%d');

##yearly load factor 
SELECT * FROM maindata LIMIT 5;

SELECT `Year`,
ROUND(SUM(`# Transported Passengers`)/SUM(`# Available Seats`)*100,2) AS LoadFactor
FROM maindata
GROUP BY `Year`
ORDER BY `Year`;


## top 10 carriers
SELECT `Carrier Name`, SUM(`# Transported Passengers`) AS Passengers
FROM maindata
GROUP BY `Carrier Name`
ORDER BY Passengers DESC
LIMIT 10;

### top routes 
SELECT`From - To City`, COUNT(*) AS Flights
FROM maindata
GROUP BY `From - To City`
ORDER BY Flights DESC;

### weekday vs weekend 
SELECT
	CASE
		WHEN DAYOFWEEK(FlightDate) IN (1,7)
			THEN 'Weekend'
		ELSE 'Weekday'
	END AS DayType,
ROUND(SUM(`# Transported Passengers`)/SUM(`# Available Seats`)*100,2) AS LoadFactor
FROM maindata
GROUP BY DayType;


## flight based on distance group
SELECT `%Distance Group ID`, COUNT(*) AS Flights
FROM maindata
GROUP BY `%Distance Group ID`
ORDER BY Flights DESC;

## monthly load factor 
SELECT MONTHNAME(FlightDate) AS MonthName,
ROUND(SUM(`# Transported Passengers`)/SUM(`# Available Seats`)*100,2) AS LoadFactor
FROM maindata
GROUP BY MonthName;

##quarterly loadfactor 
SELECT CONCAT('Q',QUARTER(FlightDate)) AS Quarter,
ROUND(SUM(`# Transported Passengers`)/SUM(`# Available Seats`)*100,2) AS LoadFactor
FROM maindata
GROUP BY Quarter;

## carrier wise load factor 
SELECT `Carrier Name`,
ROUND(SUM(`# Transported Passengers`)/SUM(`# Available Seats`)*100,2) AS LoadFactor
FROM maindata
GROUP BY `Carrier Name`
ORDER BY LoadFactor DESC;