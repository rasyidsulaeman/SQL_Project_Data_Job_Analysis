/*
Questions : What are the top-paying jobs for my role?

- Identify the top highest-paying 'Data Tech' roles that are available remotely
- Focuses on job_postings with specified salaies (remove NULLS)
- Why? Highlight top paying opportunities for 'Data Tech' rols, offering insight into employment options and location flexibility.
*/

SELECT 
      job_title_short, 
      ROUND(AVG(salary_year_avg),0) AS average_salary
FROM job_postings_fact
WHERE job_work_from_home = true AND 
      salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY average_salary DESC


/*

Results :
[
  {
    "job_title_short": "Senior Data Scientist",
    "average_salary": "163798"
  },
  {
    "job_title_short": "Machine Learning Engineer",
    "average_salary": "148670"
  },
  {
    "job_title_short": "Senior Data Engineer",
    "average_salary": "148245"
  },
  {
    "job_title_short": "Cloud Engineer",
    "average_salary": "147111"
  },
  {
    "job_title_short": "Data Scientist",
    "average_salary": "144398"
  },
  {
    "job_title_short": "Data Engineer",
    "average_salary": "132364"
  },
  {
    "job_title_short": "Software Engineer",
    "average_salary": "122367"
  },
  {
    "job_title_short": "Senior Data Analyst",
    "average_salary": "113335"
  },
  {
    "job_title_short": "Business Analyst",
    "average_salary": "97114"
  },
  {
    "job_title_short": "Data Analyst",
    "average_salary": "94770"
  }
]
*/


