/*
**Question: What are the top-paying data analyst jobs, and what skills are required?** 

- Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are remote
*/

WITH top_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name AS company_name
    FROM 
        job_postings_fact
        LEFT JOIN company_dim
            ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_location LIKE '%FL%'
        AND salary_year_avg IS NOT NULL
        AND job_title_short = 'Data Analyst'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_jobs.*,
    skills_dim.skills
FROM top_jobs
INNER JOIN skills_job_dim
    ON top_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id=skills_dim.skill_id
ORDER BY 
    top_jobs.salary_year_avg DESC