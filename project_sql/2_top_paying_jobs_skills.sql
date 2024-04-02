/*
Questions : What skills are required for the top-paying 'Data Analyst' job?

- Use the top 10 highest-paying 'Data Analyst' job from the first query
- Add specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
  helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title, 
        company_dim.name as company_name,
        salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE job_work_from_home = true AND 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    job_title,
    company_name,
    skills_dim.skills,
    salary_year_avg
FROM top_paying_jobs
INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC
