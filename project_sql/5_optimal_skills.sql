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
    skills_count DESC,
    average_salary DESC
LIMIT 25;


/* 

Results : 

[
  {
    "skills": "go",
    "skills_count": "27",
    "average_salary": "115320"
  },
  {
    "skills": "confluence",
    "skills_count": "11",
    "average_salary": "114210"
  },
  {
    "skills": "hadoop",
    "skills_count": "22",
    "average_salary": "113193"
  },
  {
    "skills": "snowflake",
    "skills_count": "37",
    "average_salary": "112948"
  },
  {
    "skills": "azure",
    "skills_count": "34",
    "average_salary": "111225"
  },
  {
    "skills": "bigquery",
    "skills_count": "13",
    "average_salary": "109654"
  },
  {
    "skills": "aws",
    "skills_count": "32",
    "average_salary": "108317"
  },
  {
    "skills": "java",
    "skills_count": "17",
    "average_salary": "106906"
  },
  {
    "skills": "ssis",
    "skills_count": "12",
    "average_salary": "106683"
  },
  {
    "skills": "jira",
    "skills_count": "20",
    "average_salary": "104918"
  },
  {
    "skills": "oracle",
    "skills_count": "37",
    "average_salary": "104534"
  },
  {
    "skills": "looker",
    "skills_count": "49",
    "average_salary": "103795"
  },
  {
    "skills": "nosql",
    "skills_count": "13",
    "average_salary": "101414"
  },
  {
    "skills": "python",
    "skills_count": "236",
    "average_salary": "101397"
  },
  {
    "skills": "r",
    "skills_count": "148",
    "average_salary": "100499"
  },
  {
    "skills": "redshift",
    "skills_count": "16",
    "average_salary": "99936"
  },
  {
    "skills": "qlik",
    "skills_count": "13",
    "average_salary": "99631"
  },
  {
    "skills": "tableau",
    "skills_count": "230",
    "average_salary": "99288"
  },
  {
    "skills": "ssrs",
    "skills_count": "14",
    "average_salary": "99171"
  },
  {
    "skills": "spark",
    "skills_count": "13",
    "average_salary": "99077"
  },
  {
    "skills": "c++",
    "skills_count": "11",
    "average_salary": "98958"
  },
  {
    "skills": "sas",
    "skills_count": "126",
    "average_salary": "98902"
  },
  {
    "skills": "sql server",
    "skills_count": "35",
    "average_salary": "97786"
  },
  {
    "skills": "javascript",
    "skills_count": "20",
    "average_salary": "97587"
  },
  {
    "skills": "power bi",
    "skills_count": "110",
    "average_salary": "97431"
  }
]
*/