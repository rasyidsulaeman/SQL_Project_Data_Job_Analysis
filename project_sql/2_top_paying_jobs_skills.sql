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


/*

Results : 

[
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "sql",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "python",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "r",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "azure",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "databricks",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "aws",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "pandas",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "pyspark",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "jupyter",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "excel",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "tableau",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "power bi",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Associate Director- Data Insights",
    "company_name": "AT&T",
    "skills": "powerpoint",
    "salary_year_avg": "255829.5"
  },
  {
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "skills": "sql",
    "salary_year_avg": "232423.0"
  },
  {
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "skills": "python",
    "salary_year_avg": "232423.0"
  },
  {
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "skills": "r",
    "salary_year_avg": "232423.0"
  },
  {
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "skills": "hadoop",
    "salary_year_avg": "232423.0"
  },
  {
    "job_title": "Data Analyst, Marketing",
    "company_name": "Pinterest Job Advertisements",
    "skills": "tableau",
    "salary_year_avg": "232423.0"
  },
  {
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "skills": "sql",
    "salary_year_avg": "217000.0"
  },
  {
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "skills": "crystal",
    "salary_year_avg": "217000.0"
  },
  {
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "skills": "oracle",
    "salary_year_avg": "217000.0"
  },
  {
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "skills": "tableau",
    "salary_year_avg": "217000.0"
  },
  {
    "job_title": "Data Analyst (Hybrid/Remote)",
    "company_name": "Uclahealthcareers",
    "skills": "flow",
    "salary_year_avg": "217000.0"
  },
  {
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skills": "sql",
    "salary_year_avg": "205000.0"
  },
  {
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skills": "python",
    "salary_year_avg": "205000.0"
  },
  {
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skills": "go",
    "salary_year_avg": "205000.0"
  },
  {
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skills": "snowflake",
    "salary_year_avg": "205000.0"
  },
  {
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skills": "pandas",
    "salary_year_avg": "205000.0"
  },
  {
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skills": "numpy",
    "salary_year_avg": "205000.0"
  },
  {
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skills": "excel",
    "salary_year_avg": "205000.0"
  },
  {
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skills": "tableau",
    "salary_year_avg": "205000.0"
  },
  {
    "job_title": "Principal Data Analyst (Remote)",
    "company_name": "SmartAsset",
    "skills": "gitlab",
    "salary_year_avg": "205000.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "sql",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "python",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "azure",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "aws",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "oracle",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "snowflake",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "tableau",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "power bi",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "sap",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "jenkins",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "bitbucket",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "atlassian",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "jira",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Director, Data Analyst - HYBRID",
    "company_name": "Inclusively",
    "skills": "confluence",
    "salary_year_avg": "189309.0"
  },
  {
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skills": "sql",
    "salary_year_avg": "189000.0"
  },
  {
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skills": "python",
    "salary_year_avg": "189000.0"
  },
  {
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skills": "r",
    "salary_year_avg": "189000.0"
  },
  {
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skills": "git",
    "salary_year_avg": "189000.0"
  },
  {
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skills": "bitbucket",
    "salary_year_avg": "189000.0"
  },
  {
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skills": "atlassian",
    "salary_year_avg": "189000.0"
  },
  {
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skills": "jira",
    "salary_year_avg": "189000.0"
  },
  {
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "company_name": "Motional",
    "skills": "confluence",
    "salary_year_avg": "189000.0"
  },
  {
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skills": "sql",
    "salary_year_avg": "186000.0"
  },
  {
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skills": "python",
    "salary_year_avg": "186000.0"
  },
  {
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skills": "go",
    "salary_year_avg": "186000.0"
  },
  {
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skills": "snowflake",
    "salary_year_avg": "186000.0"
  },
  {
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skills": "pandas",
    "salary_year_avg": "186000.0"
  },
  {
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skills": "numpy",
    "salary_year_avg": "186000.0"
  },
  {
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skills": "excel",
    "salary_year_avg": "186000.0"
  },
  {
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skills": "tableau",
    "salary_year_avg": "186000.0"
  },
  {
    "job_title": "Principal Data Analyst",
    "company_name": "SmartAsset",
    "skills": "gitlab",
    "salary_year_avg": "186000.0"
  },
  {
    "job_title": "ERM Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "skills": "sql",
    "salary_year_avg": "184000.0"
  },
  {
    "job_title": "ERM Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "skills": "python",
    "salary_year_avg": "184000.0"
  },
  {
    "job_title": "ERM Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "skills": "r",
    "salary_year_avg": "184000.0"
  }
]
*/