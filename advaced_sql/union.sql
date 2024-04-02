/*
Get the corresponding skills and skills type for each job postings in Q1 and has the salary average > $70000
*/

WITH quarter_jobs AS (
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
)

SELECT quarter_jobs.job_title_short,
       quarter_jobs.job_location,
       quarter_jobs.job_via,
       quarter_jobs.job_posted_date::DATE,
       skills.skills,
       skills.type,
       quarter_jobs.salary_year_avg
FROM quarter_jobs
INNER JOIN skills_job_dim AS skills_job ON skills_job.job_id = quarter_jobs.job_id
INNER JOIN skills_dim as skills ON skills.skill_id = skills_job.skill_id
WHERE quarter_jobs.salary_year_avg > 70000 AND 
      quarter_jobs.job_title_short = 'Data Analyst'
ORDER BY quarter_jobs.salary_year_avg DESC;

