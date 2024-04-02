/*
Question: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

-- Identifies skills in high demand for Data Analyst roles
WITH skill_demand AS (
    SELECT 
        skills.skill_id,
        skills.skills,
        COUNT(skills.skill_id) AS skills_count
    FROM skills_job_dim
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim AS skills ON skills.skill_id = skills_job_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND job_work_from_home = true 
        AND salary_year_avg IS NOT NULL
    GROUP BY skills.skill_id
), average_salary_by_skills AS (
    SELECT 
        skills.skill_id,
        ROUND(AVG(salary_year_avg),0) as average_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim AS skills ON skills.skill_id = skills_job_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND job_work_from_home = true 
        AND salary_year_avg IS NOT NULL
    GROUP BY skills.skill_id
)

SELECT 
    skill_demand.skills,
    skills_count, 
    average_salary
FROM skill_demand
INNER JOIN average_salary_by_skills ON average_salary_by_skills.skill_id = skill_demand.skill_id
WHERE skills_count > 10
ORDER BY 
    average_salary DESC,
    skills_count DESC
LIMIT 25;

-- rewriting the queries to be more simpler
SELECT 
    skills, 
    COUNT(skills_dim.skill_id) AS skills_count,
    ROUND(AVG(salary_year_avg),0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = true 
    AND salary_year_avg IS NOT NULL
GROUP BY skills
HAVING COUNT(skills_dim.skill_id) > 10
ORDER BY 
    average_salary DESC,
    skills_count DESC
LIMIT 25;
