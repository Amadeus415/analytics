
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ironman';

select top(10) *
from projects.dbo.ironman

-- Which country has the highest overall time and rank?
select
	Country,
	round(avg(Total_min), 0) as avg_time,
	avg(Overall_Rank) as avg_rank
from
	projects.dbo.ironman
group by
	Country
order by 
	avg_rank
	
--Average time by gender
select
	Gender,
	round(avg(Total_min), 0) as avg_time
from
	projects.dbo.ironman
where
	Gender IS NOT NULL
group by
	Gender;

--Top 10
select top(10)
	name,
	Gender,
	Division,
	round(Total_min, 0) as Total_Minutes,
	Overall_rank
from
	projects.dbo.ironman
order by
 Overall_Rank;

 --Country with most finishers
SELECT Country, COUNT(*) AS Finisher_Count
FROM projects.dbo.ironman
GROUP BY Country
ORDER BY Finisher_Count DESC;

--Average swim, bike, run times by division
SELECT Division,
       round(AVG(Swim_min), 0) AS Avg_Swim_Minutes,
       round(AVG(Bike_min), 0) AS Avg_Bike_Minutes,
       round(AVG(Run_min), 0) AS Avg_Run_Minutes
FROM projects.dbo.ironman
GROUP BY Division;

--Top perfomers in swim
SELECT TOP 5
    Name, 
    Swim_Time,  
    round(Swim_min, 2) as swim_min,
	Overall_Rank
FROM 
    projects.dbo.ironman
ORDER BY
	Swim_min

--Top Performers in Bike
SELECT TOP 5
    Name, 
    Bike_Time,  
    round(Bike_min, 2) as bike_min,
	Overall_Rank
FROM 
    projects.dbo.ironman
ORDER BY
	bike_min

--Top Performcers in Run
SELECT TOP 5
    Name, 
    Run_Time,  
    round(Run_min, 2) as Run_min,
	Overall_Rank
FROM 
    projects.dbo.ironman
ORDER BY
	Run_min

Select
	round(avg(Swim_min), 2) as avg_swim,
	round(avg(Bike_min), 2) as avg_bike,
	round(avg(Run_min), 2) as avg_run
from
	projects.dbo.ironman



-- particpants per country
select
	Country,
	count(bib) as participants
from
	projects.dbo.ironman
group by
	country
order by
	participants desc