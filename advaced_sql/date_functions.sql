SELECT job_title_short, 
       job_location,
       job_posted_date::DATE as date,
       job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS job_timezone,
       EXTRACT (MONTH FROM job_posted_date) AS month
FROM job_postings_fact
LIMIT 10;


SELECT COUNT(job_id) as total_jobs,
	   EXTRACT (MONTH FROM job_posted_date) AS month
FROM job_postings_fact
GROUP BY month;

/* Practice problem 1 : Find an average salary both yearly and hourly for job postings
that were posted after June 1, 2023. Group the results by job_schedule_type */

SELECT job_posted_date::DATE AS date, 
	   AVG(salary_year_avg) as average_yearly,
	   AVG(salary_hour_avg) as average_hourly
FROM job_postings_fact
WHERE job_posted_date > '2023-07-01'
GROUP BY date;

/* Practice problem 2 : count the number of job postings for each month in 2023,
adjusting job_postings_date to be in 'America/NewYork' time zone before extracting month.
Assume the job_posted_date is stored in UTC, group by and order by the month
*/

SET TIME ZONE 'America/New_York';
SELECT TO_CHAR(job_posted_date::DATE, 'Month') AS month,
	   COUNT(job_id) AS number_of_job_posting
FROM job_postings_fact
GROUP BY month
ORDER BY month;

/*
Problem 3 : 
*/
SELECT company.name, 
	   EXTRACT(QUARTER FROM job_posted_date) AS quarter
FROM company_dim AS company
LEFT JOIN job_postings_fact AS job_postings
	ON company.company_id = job_postings.company_id
WHERE job_health_insurance = true AND
	  EXTRACT(QUARTER FROM job_posted_date) = 2;









