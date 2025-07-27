-- SELECT
--     companies.name AS name,
--     COUNT(job_postings_fact.job_title) AS count_jobs
-- FROM 
--     job_postings_fact
--     LEFT JOIN company_dim AS companies
--     ON job_postings_fact.company_id = companies.company_id
-- WHERE 
--     job_postings_fact.job_health_insurance IS TRUE
--     AND EXTRACT(MONTH FROM job_postings_fact.job_posted_date) > 3
--     AND EXTRACT(MONTH FROM job_postings_fact.job_posted_date) < 7 
-- GROUP BY
--     name
-- ORDER BY
--     count_jobs DESC
-- LIMIT 100



-- SELECT
--     COUNT(job_id),
--     CASE   
--         WHEN job_location = 'New York, NY' THEN 'Local'
--         WHEN job_location = 'Anywhere' THEN 'Remote'
--         ELSE 'Onsite'
--     END AS site
-- FROM
--     job_postings_fact
-- GROUP BY 
--     site



-- SELECT
--     COUNT(job_id),
--     CASE
--         WHEN salary_year_avg >= 100000 THEN 'High salary'
--         WHEN salary_year_avg >= 60000 AND salary_year_avg < 100000 THEN 'Standard Salary'
--         WHEN salary_year_avg < 60000 THEN 'Low salary'
--     END AS salary_bucket
-- FROM 
--     job_postings_fact
-- WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
-- GROUP BY
--     salary_bucket


-- SELECT
--     COUNT(DISTINCT company_id),
--     CASE
--         WHEN job_work_from_home = TRUE THEN 'Remote'
--         WHEN job_work_from_home = FALSE THEN 'On-Site'
--     END AS is_remote
-- FROM 
--     job_postings_fact
-- GROUP BY 
--     is_remote



-- SELECT 
--     job_id,
--     salary_year_avg,
--     CASE
--         WHEN job_title LIKE '%Senior%' THEN 'Senior'
--         WHEN job_title LIKE '%Manager%' OR job_title LIKE '%Lead%' THEN 'Lead/Manager'
--         WHEN job_title LIKE '%Junior%' OR job_title LIKE '%Entry%' THEN 'Junior/Entry'
--         ELSE 'Not Specified'
--     END AS experience_level,
--     CASE
--         WHEN job_work_from_home = TRUE THEN 'Yes'
--         ELSE 'No'
--     END AS remote_option
-- FROM
--     job_postings_fact
-- WHERE 
--     salary_year_avg IS NOT NULL
-- ORDER BY
--     job_id

-- SELECT 
--     skills_dim.skills,
--     skill_count.skill_freq
-- FROM
--     (
--         SELECT 
--             skill_id,
--             COUNT(*) AS skill_freq
--         FROM 
--             skills_job_dim
--         GROUP BY
--             skill_id
--     ) AS skill_count
--     LEFT JOIN skills_dim
--         ON skill_count.skill_id = skills_dim.skill_id
-- ORDER BY skill_freq DESC


-- SELECT
--     name AS company_name,
--     company_job_post_count.job_post_count as job_postings,
--     CASE
--         WHEN job_post_count < 10 THEN 'Small'
--         WHEN company_job_post_count.job_post_count >= 10 AND company_job_post_count.job_post_count <= 50 THEN 'Medium'
--         ELSE 'Large'
--         END AS company_size
-- FROM
--     (
--     SELECT
--         company_id,
--         COUNT(job_id) AS job_post_count
--     FROM 
--         job_postings_fact
--     GROUP BY 
--         company_id
--     ORDER BY
--         job_post_count DESC
--     ) as company_job_post_count
--     LEFT JOIN company_dim
--         ON company_job_post_count.company_id = company_dim.company_id

-- SELECT 
--     name AS company_name, 
--     Average
-- FROM
-- (
--     SELECT 
--         company_id,
--         AVG(salary_year_avg) AS Average
--     FROM 
--         job_postings_fact
--     GROUP BY company_id 
--     HAVING AVG(salary_year_avg) > (SELECT AVG(salary_year_avg) FROM job_postings_fact)
-- ) AS companies_higher_avg_salary
-- LEFT JOIN company_dim
--     ON companies_higher_avg_salary.company_id = company_dim.company_id
-- ORDER BY Average DESC


-- WITH uniq_titles AS 
-- (
-- SELECT
--     company_id,
--     COUNT(DISTINCT(job_title)) AS title_count
-- FROM
--     job_postings_fact
-- GROUP BY
--     company_id
-- )

-- SELECT 
--     name AS company_name,
--     title_count
-- FROM uniq_titles
-- LEFT JOIN company_dim
--     ON uniq_titles.company_id = company_dim.company_id
-- ORDER BY title_count DESC


-- WITH avg_country_salary AS 
-- (
-- SELECT 
--     job_country,
--     AVG(salary_year_avg) AS national_avg
-- FROM job_postings_fact
-- GROUP BY job_country
-- )

-- SELECT 
--     job_postings_fact.job_id,
--     job_postings_fact.job_title,
--     job_postings_fact.salary_year_avg,
--     avg_country_salary.national_avg
-- FROM job_postings_fact
-- LEFT JOIN avg_country_salary
--     ON job_postings_fact.job_country = avg_country_salary.job_country
-- WHERE job_id = 1246069
-- LIMIT 100


-- WITH company_skill_count AS 
-- (job_postings_fact
-- SELECT 
--     company_id,
--     COUNT(DISTINCT skills_job_dim.skill_id) AS skill_count
-- FROM 
--     job_postings_fact
--     LEFT JOIN skills_job_dim
--         ON job_postings_fact.job_id = skills_job_dim.job_id
-- GROUP BY company_id
-- ORDER BY skill_count DESC
-- ),

-- avg_company_salary AS
-- (
-- SELECT 
--     company_id,
--     AVG(salary_year_avg)
-- FROM job_postings_fact
-- GROUP BY company_id
-- )

-- SELECT *
-- FROM company_skill_count
-- LEFT JOIN avg_company_salary
--     ON company_skill_count.company_id = avg_company_salary.company_id

-- SELECT 
--     job_id,
--     job_title,
--     salary_year_avg,
--     salary_hour_avg,
--     CASE 
--         WHEN salary_year_avg IS NOT NULL THEN 'Has salary'
--         WHEN salary_hour_avg IS NOT NULL THEN 'Has salary'
--     END AS salary_info
-- FROM job_postings_fact
-- WHERE salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL

-- UNION ALL

-- SELECT 
--     job_id,
--     job_title,
--     salary_year_avg,
--     salary_hour_avg,
--     CASE 
--         WHEN salary_year_avg IS NULL THEN 'No salary'
--         WHEN salary_hour_avg IS NULL THEN 'No salary'
--     END AS salary_info
-- FROM job_postings_fact
-- WHERE salary_year_avg IS NULL AND salary_hour_avg IS NULL





