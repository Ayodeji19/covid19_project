ALTER TABLE covid_19_data
ALTER COLUMN Observation_Date SET DATA TYPE DATE
USING Observation_Date::DATE

SELECT * FROM covid_19_data
SELECT SUM(confirmed) FROM covid_19_data as cumm_confirmed,

SELECT SUM(deaths) FROM covid_19_data as cumm_death,

SELECT SUM(recovered) FROM covid_19_data as new_recovered;

select current_date

SELECT extract (YEAR FROM Observation_date) FROM covid_19_data

Select extract(YEAR FROM observation_date) as observationYear,
Count(confirmed) as confirmed, 
Count(deaths) as deaths,
Count(recovered) as recovered
From Covid_19_data Where Extract(QUARTER FROM observation_date) = 1
Group By Extract(YEAR FROM observation_date) Order By observationYear

WITH yearly_counts as (
Select extract(YEAR FROM observation_date) as observationYear,
Count(deaths) as deaths From Covid_19_data 
Group By Extract(YEAR FROM observation_date) Order By observationYear
) 
ALTER TABLE covid_19_data
ALTER COLUMN Observation_Date SET DATA TYPE DATE
USING Observation_Date::DATE

SELECT * FROM covid_19_data
SELECT SUM(confirmed) as cum_confirmed, SUM (deaths) as cum_deaths, SUM (recovered) as cum_recovered  FROM covid_19_data ,

select current_date

SELECT extract (YEAR FROM Observation_date) FROM covid_19_data

Select extract(YEAR FROM observation_date) as observationYear,
Count(confirmed) as confirmed, 
Count(deaths) as deaths,
Count(recovered) as recovered
From Covid_19_data Where Extract(QUARTER FROM observation_date) = 1
Group By Extract(YEAR FROM observation_date) Order By observationYear

WITH yearly_counts as (
Select extract(YEAR FROM observation_date) as observationYear,
Count(deaths) as deaths, LEAD (count(deaths)) OVER () as lag_death From Covid_19_data 
Group By Extract(YEAR FROM observation_date) Order By observationYear
) 
SELECT *, 
       100 * (((YC.lag_death)-deaths::decimal) / deaths::decimal) AS percentage_diff 
	   FROM yearly_counts AS YC
ORDER BY YC.observationYear


SELECT country, count(confirmed) as new_confirmed FROM covid_19_data GROUP BY country order by new_confirmed DESC limit 5

WITH monthly_confirmed as (
SELECT extract (MONTH FROM Observation_date) as monthly, 
extract (year from Observation_date) as yearly, count(confirmed) as confirmed from covid_19_data
group by extract (year from Observation_date), extract(month from observation_date) order by yearly, monthly
)
SELECT *,
LEAD (confirmed) OVER (ORDER BY yearly, monthly) as lag_confirmed, 
100 * ((LEAD (confirmed) over (ORDER BY yearly, monthly) - confirmed::decimal ) / confirmed::decimal) as net_change
FROM monthly_confirmed

	
