# Introduction

📊 Breaking down into data job market! The project explores 💰 top paying jobs on Data Tech roles and 🔥 top in demand skills and 💰 salary specifically on Data Analyst roles. 

🔍 Check the complete SQL queries on this folder : [project_sql folder](/project_sql/)

# Background

Unlock the power of data with my SQL project, I delve deep into datasets to reveal hidden correlations, actionable insights, and driving informed decision-making in the realm of data analysis. The project emerged from a quest to identify high-paying and sought-after skills, optimizing job searches for others.

Referencing the project from [Luke Barousse](https://www.linkedin.com/in/luke-b/). Credit to him, and Thanks to him to teach me an end-to-end projects. 

Data hails from [SQL Course](https://www.lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were :

1. What are the top-paying data tech roles jobs?
2. Breaking down into data analyst, What skills are required for the data analyst top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL queries.
- **Python & Jupyter Notebook**: The best programming language to visualize the results to be more readable. Jupyter Notebook was chose as it is more convenient to visualize the code.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# Analysis

Each query for this project aimed at investigating specific aspects of the data tech specifically data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Tech Jobs

To identify the highest-paying roles, I selected all data tech roles positions by average yearly salary, focusing on remote jobs. This query highlights the high paying opportunities in the data field roles.

```sql
SELECT 
      job_title_short, 
      ROUND(AVG(salary_year_avg),0) AS average_salary
FROM job_postings_fact
WHERE job_work_from_home = true AND 
      salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY average_salary DESC
```

Here's is the breakdown of the lowest-highest paying based on data tech roles in 2023:

- Average salary for all the tech roles ranging from  $94,000 -  $160,000, with Data Analyst becomes the lowest paid salary in a year, and the highest paid is Senior Data Scientist.
- Senior tech has more experienced than the entry level job, therefore it's quite understandable the position has the higher salary. For example: Data Analyst obtained $94,770, however Senior Data Analyst got $113,335

![top paying data tech roles](/assets/1_top_paying_jobs.png)

(*Horizontal barplot showing data tech job title vs average salary yearly. The plot generated using python in jupyter notebook*)

Further analysis would be restricted to Data Analyst job, since it's my interest role at the moment.

### 2. Top Skills for Top Paying Data Analyst Job

To understand what skills are required for the data analyst top-paying jobs, using CTE (temporary result set), I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
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
```

Here are the breakdown of the total skills mention in the job postings for the top 10 Data Analyst job in 2023:

- **SQL**, **Python**, and **Tableau** becomes the most mentioned skills in the job postings in the top 10 data analyst job, it appears more than 5 times in the job requirements. Indicating the obligatory skill to master for data analyst role.
- The other skills like **R**, **snowflake**, **pandas**, **excel**, etc. show varying degrees of demand.

![top skills for data analyst job](/assets/2_top_paying_jobs_skills.png)

(*Horizontal barplot visualizing count of skills for the top data analyst job. The plot generated using python in jupyter notebook*)

### 3. In-Demand Skills for Data Analyst

To extract the top 5 demanded skills in the realm of data analyst role, I joined the job postings with skills table, returning skills and count the skills.

```sql
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
```

Here are the breakdown of the top 5 demanded skills for Data Analyst job in 2023:

- **SQL** is the most in-demand skill for data analysis. Indicating a strong foundation skill in data processing, manipulating, managing relational databases.
- **Excel** and **Python** becomes the two most  in-demand skill after **SQL**. Since they are versatile tool for data analysis and visualization. Commonly used for the task such as data cleaning, analysis, and reporting.
- Followed by the last two most in-demand skills for data analysis, **Tableau** and **Power BI**. Both Tableau and Power BI are powerful data visualization tools, allowing users to create interactive and insightful visualizations from various data sources.


![in demand skills](/assets/3_top_demanded_skills.png)

(*Barplot visualizing the top 5 in-demand skills for data analyst. The plot generated using python in jupyter notebook*)

### 4. Top Paying Skills

Exploring top paying skills for data analyst in 2023. I joined the job postings and skills table and returning skills name associated with average salary.

```sql
SELECT 
    skills, 
    ROUND(AVG(salary_year_avg),0) as average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND 
      job_work_from_home = true AND 
      salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY average_salary DESC
LIMIT 25
```

Here's a breakdown of the results for top paying skills for Data Analysts:

- **High Demand for Big Data**: big data technologies such as PySpark and Couchbase command the highest average salaries. These skills are essential in handling and analyzing large volumes of data efficiently, which likely contributes to their higher salary levels.
- **Data Science & Machine Learning**: Watson and DataRobot reflects the growing demand for professionals with expertise in advanced analytics and AI-driven solutions. Additionally, Python (Pandas and Jupyter) are fundamental in exploratory data analysis and building data-driven solutions, indicating a continued demand for professionals proficient in data science and analytics.
- **Software Development**: The development tools such as Swift, Golang, Bitbucket, and GitLab, suggests a strong demand for individuals skilled in software development and version control systems, which are crucial in modern software engineering workflows.

| skills | average salary ($) |
| ------ | -------------- |
| pyspark | 208172 |
| bitbucket	| 189155 |
| couchbase	| 160515 |
| watson | 160515 |
| datarobot | 155486 |
| gitlab | 154500 |
| swift | 153750 |
| jupyter | 152777 |
| pandas | 151821 |
| elasticsearch | 145000 |
| golang | 145000 |

(*Table of the average salary for the top 10 paying skills for data analysts*)


### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
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
```

Here's a breakdown of the results for most optimal skills to learn for Data Analysts based on skill count sorted:

- **Database Management**: SQL stands out as the most prevalent skill, indicating its widespread use in database management and querying.
- **High Demand Programming Languages**: Python and R emerges with the higher skill counts with the average salary at $101,397 and $100,499, indicating its premium value in the job market for data analysis.
- **Visualization Tools**: Tableau and Power BI, despite slightly lower skill counts, boast competitive average salaries, reflecting the significance of data visualization skills in modern analytics roles.


| skills | skills count | average salary ($) |
| - | - | - |
| sql | 398 | 97237 |
| excel | 256 | 87288 |
| python | 236 | 101397 |
| tableau | 230 | 99288 |
| r | 148 | 100499 |
| sas | 126 | 98902 | 
| power bi | 110 | 97431 |
| powerpoint | 58 | 88701 |
| looker | 49 | 103795 |
| word | 48 | 82576 |

(*Table of the top 10 optimal skills to learn for data analysts depicted from highest average salary sorted by salaries*)

Here's a breakdown of the results for most optimal skills to learn for Data Analysts based on average salary sorted:

- **Cloud Tools and Technologies**: Azure and AWS, both cloud computing platforms, also exhibit high skill counts, indicating significant demand for professionals with expertise in these platforms.
- **Project Management Tools**: Confluence and Jira, both collaboration and project management tools. While their average salaries are not the highest in the dataset, they still offer competitive compensation, indicating the importance of these tools in various industries for team collaboration and project tracking.
- Overall, the data underscores the significance of cloud computing platforms like Azure and AWS, as well as emerging technologies like Snowflake, in today's job market. Additionally, it highlights the enduring relevance of foundational skills such as collaboration and project management tools.

| skills | skills count | average salary ($) |
| ------ | ------------ | -------------- |
| go | 27 | 115320 |
| confluence | 11 | 114210 |
| hadoop | 22 | 113193 |
| snowflake | 37 | 112948 | 
| azure | 34 | 111225 |
| bigquery | 13 | 109654 |
| aws | 32 | 108317 |
| java | 17 | 106906 |
| ssis | 12 | 106683 |
| jira | 20 | 104918 |

(*Table of the top 10 optimal skills to learn for data analysts depicted from highest average salary sorted by salaries*)

# What I Learned

Throughout this adventure, I've boosted my SQL skills from the basic structure of SQL, to database loaded, and build some advanced syntax to process and manipulate the data. Some of them are listed below:

- 🧩 **Complex Query Crafting**: Mastered the art of advanced SQL syntax. Merging tables using JOIN, and manipulating the data using subqueries and CTE (temporary results set).
- 📊 **Data Aggregation**: Got familiarize with aggregation techniques with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing.
- 💡 **Analytical Wizardry**: Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries. 

# Conclusion

### Insights
From the analysis, several general insights emerged:

1. **Top Paying Data Tech Roles**: Data Analysts as an entry role is the lowest paid role in the data tech realm, obtained $94,770 in average yearly.
2. **Skills for Top Paying Data Analyst Jobs**: Highest top paying skills for data analyst are SQL, Python, and Tableau, suggesting they're a critical skill for earning a top salary.
3. **Most In-Demand Skills**:  SQL, Excel, Python, Tableau, and Power BI are highly sought-after skills in the data analysis job market, with SQL being the most dominant skill.
4. **Skill with Higher Salary**: Big data technologies like PySpark and Couchbase lead in commanding top salaries, while the surge in demand for Data Science and Machine Learning experts, highlights the dynamic landscape of today's job market.
5. **Most Optimal Skills**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project improved my proficiency in SQL and offered valuable insights into the data analyst job market. The results of the analysis can help prioritize skill development and job search strategies. Aspiring data analysts can boost their chances in a competitive job market by concentrating on skills that are in high demand and command higher salaries. This exploration underscores the significance of continually learning and adapting to new trends in the data analytics field.