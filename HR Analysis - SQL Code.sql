-- Create a Join Table 

SELECT 
	* 
FROM 
	Absenteeism_at_work AB
LEFT JOIN
	compensation C 
	ON 
	AB.ID = C.ID
LEFT JOIN
	Reasons R 
	ON 
	AB.Reason_for_absence = R.Number; 

--------------------------------------------------------------------------

-- Find the Healthiest For 1000$ Bouns 

SELECT 
	* 
FROM 
	Absenteeism_at_work
WHERE 
	Social_drinker = 0 AND
	Social_smoker = 0 AND
	Body_mass_index < 25 AND 
	(Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work));

--------------------------------------------------------------------------

-- Compensation Rate Increase for Non-Smokers

SELECT 
	COUNT(*) NonSmokers
FROM 
	Absenteeism_at_work
WHERE 
	Social_smoker = 0;

-- Bouns Budget 983,221  ||  686 Employees 
-- Total Amount of Hours They're Working per Year 
-- = 5 (days a week) * 8 (hours) * 52 (weeks a year) 
-- = 2080 hours a year 
-- Total Yearly Work Hours Per Employee = 2080 * 686 = 1,426,880
-- Bouns Per Hour = 983,221 / 1,426,880 = 0.68 cent 
-- $1,414.4 Per Year if the Employee is Non-Smoker

--------------------------------------------------------------------------

-- Optimizing the Query 

SELECT 
	AB.ID,
	R.Reason,
	Month_of_absence,
CASE 
	WHEN Month_of_absence IN (12,1,2) THEN 'Winter'
	WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
	WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
	WHEN Month_of_absence IN (9,10,11) THEN 'Auntmn'
	ELSE 'Unknown'
	END Seasons, 
	Body_mass_index,
CASE 
	WHEN Body_mass_index < 18.5 THEN 'Underwieght'
	WHEN Body_mass_index < 24.9 THEN 'Healthy'
	WHEN Body_mass_index < 29.9 THEN 'Overwieght'
	WHEN Body_mass_index >= 30 THEN 'Obese'
	ELSE 'Unknown'
	END BMI_State,
	Month_of_absence, Day_of_the_week, Transportation_expense, 
	Education, Son, Social_drinker, Social_smoker, Pet, Disciplinary_failure,
	Age,
	CASE 
	WHEN Age BETWEEN 26 AND 40 THEN 'Adult'
	WHEN Age BETWEEN 41 AND 50 THEN 'Middle-Age'
	WHEN Age BETWEEN 51 AND 66 THEN 'Old'
	ELSE 'Unknown'
	END AgeGroup,
	Work_load_Average_day, Absenteeism_time_in_hours
FROM 
	Absenteeism_at_work AB
LEFT JOIN
	compensation C 
	ON 
	AB.ID = C.ID
LEFT JOIN
	Reasons R 
	ON 
	AB.Reason_for_absence = R.Number; 