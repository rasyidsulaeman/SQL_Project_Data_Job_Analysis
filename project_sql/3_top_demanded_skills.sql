/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

-- using subqueries
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

-- rewriting the queries above
SELECT 
     skills.skills, 
     COUNT(skills.skill_id) AS skills_count
FROM skills_job_dim
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim AS skills ON skills.skill_id = skills_job_dim.skill_id
WHERE 
     job_postings.job_work_from_home = true 
     AND job_postings.job_title_short = 'Data Analyst'
GROUP BY skills.skill_id
ORDER BY skills_count DESC
LIMIT 5

/*

Results : 

[
  {
    "skills": "sql",
    "skills_count": "7291"
  },
  {
    "skills": "excel",
    "skills_count": "4611"
  },
  {
    "skills": "python",
    "skills_count": "4330"
  },
  {
    "skills": "tableau",
    "skills_count": "3745"
  },
  {
    "skills": "power bi",
    "skills_count": "2609"
  }
]

*/