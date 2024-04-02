/* 
Label new columns as follows :
- Anywhere as Remote
- New York, NY as Local
- Otherwise Onsite
*/

SELECT job_title_short,
       CASE 
            WHEN job_location = 'Anywhere' THEN 'Remote'
            WHEN job_location = 'New York, NY' THEN 'Local'
            ELSE 'Onsite'
       END AS location_category,
       COUNT(job_id) as number_job_postings
FROM job_postings_fact
GROUP BY job_title_short, location_category
LIMIT 100;

/* 
Problem : Categorize the salaries from each job posting. To see if it fits in my desired salary range.
- Put salary into different buckets 
- Define high, standards, and low salary with your own conditions
     high > $ 150.000 yearly
     standards $80.000 - $150.000 yearly
     low < $80.0000 yearly
- Why? It's easy to determine which job postings are worth looking at based on salary
- I only looked at data analyst role
- Order from higher to lowest
*/

SELECT job_title_short,
       job_location,
       salary_year_avg,
       CASE 
          WHEN salary_year_avg >= 150000 THEN 'High salary'
          WHEN salary_year_avg BETWEEN 80000 AND 150000 THEN 'Standard Salary'
          ELSE 'Low Salary'
       END AS salary_range
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' AND 
      salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;

/* 
Problem 1 : Identify the top 5 skills that are most frequently mention in job postings. Use the subquery to find the skill ID
with the highest counts in the skills_job_dim table and then join this result with the skills_dim table to get the skills names
*/

-- Subqueries
SELECT skills.skills, skills_count
FROM (
     SELECT skill_id, 
          COUNT(skill_id) as skills_count
     FROM skills_job_dim
     INNER JOIN job_postings_fact as job_postings 
          ON job_postings.job_id = skills_job_dim.job_id
     GROUP BY skill_id
) AS total_skills
INNER JOIN skills_dim AS skills
     ON total_skills.skill_id = skills.skill_id
ORDER BY skills_count DESC
LIMIT 5;

-- CTE : temporary result s set
WITH total_skills AS (
     SELECT skill_id, 
          COUNT(skill_id) as total_skills_needed
     FROM skills_job_dim
     GROUP BY skill_id
)

SELECT skills.skills, total.total_skills_needed
FROM total_skills as total
LEFT JOIN skills_dim AS skills
     ON total.skill_id = skills.skill_id
ORDER BY total_skills_needed DESC
LIMIT 5;

/* 
Problem : Determine the size category ('Small', 'Medium', or 'Large') for each company by first identifying 
the number of job postings they have. Use a subquery to calculate the total job postings per company. A company is considered
'Small' if it less than 10 job postings, 'Medium' if the number of job postings is between 10 and 50, 'Large' if it has more 
than 50 job postings. Implement a subquery to aggregate job counts per company before classifying them based on class
*/

-- Subqueries
SELECT company.name, company_job_total.total_jobs,
       CASE
          WHEN total_jobs < 10 THEN 'Small'
          WHEN total_jobs BETWEEN 10 AND 50 THEN 'Medium'
          ELSE 'Large'
       END as company_size
FROM (
     SELECT company_id, COUNT(*) as total_jobs
     FROM job_postings_fact
     GROUP BY company_id
) AS company_job_total
RIGHT JOIN company_dim as company
     ON company.company_id = company_job_total.company_id;

-- CTE : temporary results set
WITH company_job_total AS (
     SELECT company_id, COUNT(*) as total_jobs
     FROM job_postings_fact
     GROUP BY company_id
)

SELECT company.name, company_job_total.total_jobs,
       CASE
          WHEN total_jobs < 10 THEN 'Small'
          WHEN total_jobs BETWEEN 10 AND 50 THEN 'Medium'
          ELSE 'Large'
       END as company_size
FROM company_job_total
RIGHT JOIN company_dim as company
     ON company.company_id = company_job_total.company_id; 


/* 
Find the count of the number of remote job postings per skills
     - Display the top 5 skills by their demand in demand in remote jobs and "Data Analyst"
     - Include skills name, count of postings requiring the skills
*/

-- Subqueries
SELECT skills.skills, skills_count
FROM (
     SELECT skill_id, 
          COUNT(skill_id) as skills_count
     FROM skills_job_dim
     INNER JOIN job_postings_fact as job_postings 
          ON job_postings.job_id = skills_job_dim.job_id
     WHERE job_postings.job_work_from_home = true AND
           job_postings.job_title_short = 'Data Analyst'
     GROUP BY skill_id
) AS total_skills
INNER JOIN skills_dim AS skills
     ON total_skills.skill_id = skills.skill_id
ORDER BY skills_count DESC
LIMIT 5;