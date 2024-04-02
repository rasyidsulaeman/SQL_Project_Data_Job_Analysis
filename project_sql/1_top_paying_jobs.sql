/*
Questions : What are the top-paying jobs for my role?

- Identify the top 10 highest-paying 'Data Analyst' roles that are available remotely
- Focuses on job_postings with specified salaies (remove NULLS)
- Why? Highlight top paying opportunities for 'Data Analyst', offering insight into employment options and location flexibility.
*/

SELECT job_id, job_title, 
       company_dim.name as company_name,
       job_location, 
       job_schedule_type,
       job_posted_date::DATE,
       salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE job_work_from_home = true AND 
      job_title_short = 'Data Analyst' AND
      salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10


