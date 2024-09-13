SELECT TOP 10 *
FROM projects.dbo.ultra_cleaned_data

-- How many states are represented in the race
SELECT count(Distinct state) as distinct_states
from projects.dbo.ultra_cleaned_data

--How many competitors in each state
select
	state,
	count(state) as competitors
from projects.dbo.ultra_cleaned_data
group by
	state
order by competitors desc

--What was the average time of Men vs Women
SELECT 
    Gender,
    AVG(CASE WHEN Gender = 'M' THEN Total_minutes ELSE NULL END) AS avg_minutes_male,
    AVG(CASE WHEN Gender = 'F' THEN Total_minutes ELSE NULL END) AS avg_minutes_female
FROM
    projects.dbo.ultra_cleaned_data
GROUP BY 
    Gender;

	--better way
select
	Gender,
	AVG(Total_minutes) as avg_minutes
from
	projects.dbo.ultra_cleaned_data
group by
	Gender

--What were the oldest and youngest ages in the race
select
	gender,
	min(Age) as youngest,
	max(Age) as oldest
from
	projects.dbo.ultra_cleaned_data
group by
	gender

--What is the average time for each age group

with age_buckets as (
	select total_minutes,
		case 
			when age < 30 then 'age_20-29'
			when age < 40 then 'age_30-39'
			when age < 50 then 'age_40-49'
			when age < 60 then 'age_50-59'
		else 'age_60+' end as age_group
	from 
		projects.dbo.ultra_cleaned_data
)

select 
	age_group, 
	avg(total_minutes) as avg_race_time
from age_buckets
group by
	age_group

--top 3 males and females
with gender_rank as (
	select 
		rank() over (partition by Gender order by total_minutes asc) as gender_rank, 
		fullname,
		gender,
		total_minutes
	from projects.dbo.ultra_cleaned_data
)

select *
from gender_rank
where gender_rank <= 3
order by total_minutes

