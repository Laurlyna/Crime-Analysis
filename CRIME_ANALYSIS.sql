USE crime_dataset ;

CREATE TABLE crime_data (
    DR_NO VARCHAR(50),
    Date_Rptd VARCHAR(50),
    DATE_OCC VARCHAR(50),
    TIME_OCC VARCHAR(50),
    AREA VARCHAR(50),
    AREA_NAME VARCHAR(100),
    Rpt_Dist_No VARCHAR(50),
    `Part 1-2` VARCHAR(10),
    Crm_Cd VARCHAR(50),
    Crm_Cd_Desc VARCHAR(255),
    Mocodes TEXT,
    Vict_Age VARCHAR(10),
    Vict_Sex VARCHAR(10),
    Vict_Descent VARCHAR(10),
    Premis_Cd VARCHAR(50),
    Premis_Desc VARCHAR(255),
    Weapon_Used_Cd VARCHAR(50),
    Weapon_Desc VARCHAR(255),
    Status VARCHAR(50),
    Status_Desc VARCHAR(100),
    Crm_Cd_1 VARCHAR(50),
    Crm_Cd_2 VARCHAR(50),
    Crm_Cd_3 VARCHAR(50),
    Crm_Cd_4 VARCHAR(50),
    LOCATION VARCHAR(255),
    Cross_Street VARCHAR(255),
    LAT VARCHAR(50),
    LON VARCHAR(50)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/crime_data.csv'
INTO TABLE crime_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT COUNT(*)
FROM crime_set;

CREATE TABLE crime_set LIKE crime_data;

INSERT INTO crime_set 
SELECT*
FROM crime_data;

SELECT*
FROM crime_data;

--- renaming columns

ALTER TABLE crime_data
RENAME COLUMN DR_NO TO record_id;

ALTER TABLE crime_data
RENAME COLUMN Date_Rptd TO date_reported,
RENAME COLUMN DATE_OCC TO date_occured,
RENAME COLUMN TIME_OCC TO time_occured,
RENAME COLUMN AREA TO area_code ,
RENAME COLUMN AREA_NAME TO area_name  ,
RENAME COLUMN Rpt_Dist_No TO report_district_no,
RENAME COLUMN `Part 1-2` TO crime_part,
RENAME COLUMN  Crm_Cd TO crime_code,
RENAME COLUMN Crm_Cd_Desc TO crime_description ,
RENAME COLUMN Vict_Age TO victim_age,
RENAME COLUMN Vict_Sex TO victim_sex,
RENAME COLUMN Vict_Descent TO victim_descent ,
RENAME COLUMN Premis_Cd TO premises_code ,
RENAME COLUMN Premis_Desc TO premises_description,
RENAME COLUMN Weapon_Used_Cd TO weapon_code,
RENAME COLUMN Weapon_Desc TO weapon_description,
RENAME COLUMN Status TO case_status,
RENAME COLUMN  Status_Desc TO status_description ,
RENAME COLUMN Crm_Cd_1 TO primary_crime_code,
RENAME COLUMN Crm_Cd_2 TO secondary_crime_code ,
RENAME COLUMN Crm_Cd_3  TO third_crime_code,
RENAME COLUMN Crm_Cd_4 TO forth_crime_code,
RENAME COLUMN LOCATION TO location,
RENAME COLUMN Cross_Street TO cross_street,
RENAME COLUMN LAT TO latitude,
RENAME COLUMN LON TO longitude;

SELECT*
FROM crime_data ;

--- fixing datatype

ALTER TABLE crime_data
MODIFY COLUMN record_id BIGINT ;

SELECT*
FROM crime_data;

SELECT record_id, COUNT(*) AS duplicate_count
FROM crime_data
GROUP BY record_id 
HAVING COUNT(*) > 1 ;

SELECT*
FROM crime_data
WHERE record_id IN (SELECT record_id
FROM crime_data
GROUP BY record_id
HAVING COUNT(*) > 1);

SELECT DISTINCT(date_reported)
FROM crime_data ;

SELECT DISTINCT(date_occured)
FROM crime_data ;

ALTER TABLE crime_data
MODIFY COLUMN date_reported DATE ;

SELECT date_reported
FROM crime_data
WHERE date_reported IS NULL 
OR date_reported = ''
OR date_reported NOT LIKE '%/%/%';

SELECT STR_TO_DATE(date_reported,'%m/%d/%Y %H:%i')
FROM crime_data;

UPDATE  crime_data
SET date_reported = STR_TO_DATE(date_reported,'%m/%d/%Y %H:%i');

SET SQL_SAFE_UPDATES = 0 ;

ALTER TABLE crime_data
MODIFY COLUMN date_reported DATE ;

ALTER TABLE crime_data
MODIFY COLUMN date_occured DATE ;


SELECT DISTINCT(time_occured)
FROM crime_data;

SELECT time_occured, LPAD(time_occured,4,'0') AS padded_time
FROM crime_data;

SELECT time_occured, CONCAT( LEFT(LPAD(time_occured,4,'0'), 2), RIGHT(LPAD(time_occured,4,'0'),2 ))
FROM crime_data;


UPDATE crime_data 
SET time_occured = CONCAT( LEFT(LPAD(time_occured,4,'0'), 2),':', RIGHT(LPAD(time_occured,4,'0'), 2));

SELECT TIME_OCC
FROM crime_set;

ALTER TABLE crime_data
MODIFY COLUMN time_occured TIME ;

SELECT time_occured, CONCAT(time_occured,':00')
FROM crime_data;

UPDATE crime_data
SET time_occured = CONCAT(time_occured,':00');

SELECT time_occured
FROM crime_data;

ALTER TABLE crime_data
MODIFY COLUMN area_code INT ;

ALTER TABLE crime_data
MODIFY COLUMN area_name VARCHAR(100) ,
MODIFY COLUMN report_district_no INT ,
MODIFY COLUMN crime_part INT ,
MODIFY COLUMN crime_code INT ,
MODIFY COLUMN crime_description VARCHAR(255) ,
MODIFY COLUMN victim_age INT,
MODIFY COLUMN victim_sex VARCHAR(10),
MODIFY COLUMN victim_descent VARCHAR(50),
MODIFY COLUMN case_status VARCHAR(10)
 ;

SELECT DISTINCT(premises_code)
FROM crime_data; 

ALTER TABLE crime_data
MODIFY COLUMN premises_code INT ;

UPDATE crime_data
SET premises_code = NULL
WHERE premises_code = '';

SELECT DISTINCT(weapon_code)
FROM crime_data; 

UPDATE crime_data
SET weapon_code = NULL
WHERE weapon_code = '';

ALTER TABLE crime_data
MODIFY COLUMN weapon_code INT ;

SELECT DISTINCT(primary_crime_code)
FROM crime_data; 

UPDATE crime_data
SET primary_crime_code = NULL
WHERE primary_crime_code = '';

UPDATE crime_data
SET secondary_crime_code = NULL
WHERE secondary_crime_code = '';

UPDATE crime_data
SET third_crime_code = NULL
WHERE third_crime_code = '';

UPDATE crime_data
SET forth_crime_code = NULL
WHERE forth_crime_code = '';

ALTER TABLE crime_data
Modify COLUMN forth_crime_code INT,
Modify COLUMN third_crime_code INT,
Modify COLUMN secondary_crime_code INT,
Modify COLUMN primary_crime_code INT;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE crime_data
Modify COLUMN longitude DECIMAL(10,7),
Modify COLUMN latitude DECIMAL(10,7);

SELECT*
FROM crime_data;

---- handling missing values and nulls 

SELECT*
FROM crime_data;

SELECT DISTINCT(area_code),area_name
FROM crime_data
ORDER BY area_code ASC;

SELECT DISTINCT(crime_code),crime_description
FROM crime_data
ORDER BY crime_code ASC;

SELECT DISTINCT(premises_code),premises_description
FROM crime_data
ORDER BY premises_code ASC;

SELECT DISTINCT(report_district_no)
FROM crime_data
ORDER BY report_district_no ASC;

SELECT DISTINCT(victim_sex)
FROM crime_data
ORDER BY victim_sex ASC;

SELECT DISTINCT(weapon_code),weapon_description
FROM crime_data
ORDER BY weapon_code ASC;

SELECT DISTINCT(case_status),status_description
FROM crime_data
ORDER BY case_status ASC;

UPDATE crime_data
SET case_status = 'CC'
WHERE status_description = 'UNK';

SELECT DISTINCT(crime_code),primary_crime_code
FROM crime_data
ORDER BY crime_code ASC;

SELECT DISTINCT(primary_crime_code),crime_description,crime_code, secondary_crime_code,third_crime_code,forth_crime_code
FROM crime_data
ORDER BY primary_crime_code ASC;

SELECT DISTINCT(victim_sex)
FROM crime_data
ORDER BY victim_sex ASC;

SELECT*
FROM crime_data;

UPDATE crime_data
SET mocodes = NULL
WHERE mocodes = '' ;

SET SQL_SAFE_UPDATES = 0 ;

UPDATE crime_data
SET victim_age = NULL
WHERE victim_age <= 0 ;

UPDATE crime_data
SET victim_sex = NULL
WHERE victim_sex = '' ;


SELECT COUNT(*)
FROM crime_data 
WHERE victim_sex = 'X' ;

UPDATE crime_data
SET victim_sex = CASE
   WHEN victim_sex = 'F' THEN 'Female'
   WHEN victim_sex = 'M' THEN  'Male'
   WHEN victim_sex IN ('X','H') THEN  'Others'
   ELSE victim_sex
   END;
    
SELECT *
FROM crime_data; 

SELECT DISTINCT(longitude)
FROM crime_data
ORDER BY longitude ASC; 

UPDATE crime_data
SET victim_descent = NULL
WHERE victim_descent = '-' OR victim_descent = '' ;

UPDATE crime_data
SET premises_description = NULL
WHERE premises_description = ''  ;

UPDATE crime_data
SET weapon_description = NULL
WHERE weapon_description= ''  ;


UPDATE crime_data
SET case_status = NULL
WHERE case_status= ''  ;

UPDATE crime_data
SET status_description = NULL
WHERE status_description= ''  ;

UPDATE crime_data
SET longitude = NULL
WHERE longitude= ''  ;

UPDATE crime_data
SET location = NULL
WHERE location= ''  ;

UPDATE crime_data
SET cross_street = NULL
WHERE cross_street ='';

UPDATE crime_data
SET latitude = NULL
WHERE latitude = ''  ;

-- EDA
-- most common case_status

SELECT case_status,area_name,  COUNT(*) total_crime
FROM crime_data
WHERE case_status = 'IC'
GROUP BY case_status,area_name
ORDER BY total_crime DESC;

SELECT DISTINCT (status_description),case_status
FROM crime_data;

--- crime description with with most ungoing investigation

SELECT crime_description,case_status,COUNT(*) total_crime
FROM crime_data
WHERE case_status = 'IC'
GROUP BY crime_description
ORDER BY total_crime DESC ;

--- crime trend by time of day

SELECT 
CASE 
	WHEN HOUR(time_occured) BETWEEN 5 AND 11 THEN 'Morning'
    WHEN HOUR(time_occured) BETWEEN 12 AND 16 THEN 'Afternoon'
    WHEN HOUR(time_occured) BETWEEN 17 AND 20 THEN 'Evening'
    ELSE 'Night'
    END AS times_of_day,
    COUNT(*) AS total_crime
    FROM crime_data
    GROUP BY times_of_day 
    ORDER BY total_crime ASC;
    
--- seasonal crime pattern
SELECT 
CASE 
	WHEN MONTH(date_occured) IN (1,2,3) THEN 'Winter'
    WHEN MONTH(date_occured) IN (4,5,6) THEN 'Spring'
    WHEN MONTH(date_occured) IN (7,8,9) THEN 'Summer'
    WHEN MONTH(date_occured) IN (10,11,12) THEN 'Autumn'
    END AS seasons,
    COUNT(*) AS total_crime
    FROM crime_data
    GROUP BY seasons 
    ORDER BY total_crime ASC;
    
--- Weekend vs Weekday
SELECT 
CASE
	WHEN DAYNAME(date_occured) IN ('Saturday','Sunday') THEN ' Weekend'
    ELSE 'Weekday'
END AS day_type,
COUNT(*) AS total_crime
    FROM crime_data
    GROUP BY day_type
    ORDER BY total_crime ASC;

--- most dangerous hours

SELECT HOUR(time_occured) AS crime_hour,
COUNT(*) AS total_crime
FROM crime_data
GROUP BY crime_hour
ORDER BY total_crime ASC;


--- crime distribution by premises type

SELECT premises_description, COUNT(*) AS total_crime
FROM crime_data
GROUP BY premises_description
ORDER BY total_crime DESC;

--- Victim sex distribution
SELECT victim_sex ,COUNT(*) AS total_crime
FROM crime_data
GROUP BY victim_sex
ORDER BY total_crime DESC;

--- top crime combination
SELECT crime_description,weapon_description ,COUNT(*) AS total_crime
FROM crime_data
WHERE weapon_description IS NOT NULL
GROUP BY crime_description,weapon_description
ORDER BY total_crime DESC
LIMIT 20;

--- Area vs weapon analysis
SELECT area_name,weapon_description ,COUNT(*) AS total_crime
FROM crime_data
WHERE weapon_description IS NOT NULL
GROUP BY area_name,weapon_description
ORDER BY total_crime DESC
LIMIT 20;

-- Top_crime_case

SELECT crime_description ,COUNT(*) AS total_crime
FROM crime_data
WHERE crime_description IS NOT NULL
GROUP BY crime_description
ORDER BY total_crime DESC
LIMIT 20;

--- crime part1 vs crime part2
SELECT crime_part ,COUNT(*) AS total_crime
FROM crime_data
GROUP BY crime_part
ORDER BY total_crime DESC
;

--- Most common crimes by premise type

SELECT premises_description,crime_description ,COUNT(*) AS total_crime
FROM crime_data
GROUP BY premises_description,crime_description
ORDER BY total_crime DESC
;

--- victim age distribution

SELECT
CASE
    WHEN victim_age BETWEEN 0 AND 17 THEN '0-17'
    WHEN victim_age BETWEEN 18 AND 30 THEN '18-30'
    WHEN victim_age BETWEEN 31 AND 50 THEN '31-50'
    WHEN victim_age BETWEEN 51 AND 70 THEN '51-70'
    ELSE '71+'
END AS age_group,
COUNT(*) AS total_victims
FROM crime_data
WHERE victim_age IS NOT NULL
GROUP BY age_group
ORDER BY total_victims DESC;


SELECT*
FROM crime_data;


SHOW VARIABLES LIKE 'SQL_SELECT_LIMIT';

SELECT *
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM crime_data;

























































































