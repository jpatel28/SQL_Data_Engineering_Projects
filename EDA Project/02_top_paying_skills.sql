/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries in Canada
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND jpf.search_location = 'Canada'
    AND jpf.job_work_from_home = TRUE
GROUP BY 
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY 
    MEDIAN(jpf.salary_year_avg) DESC
LIMIT 25;

/*
Here is the breakdown of top 10 skills by median salary, with demand counts included for comparison.
Key takeaways:
- Go ranks first at $188,000 median salary, with a demand count of 111.
- Redshift ranks second at $158,750, with a demand count of 221.
- Snowflake and Tableau are tied at $155,000.
- PySpark and Terraform are tied at $153,900.
- Among these top 10, Snowflake has the highest demand count (300).

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ go         │      188000.0 │          111 │
│ redshift   │      158750.0 │          221 │
│ snowflake  │      155000.0 │          300 │
│ tableau    │      155000.0 │          160 │
│ terraform  │      153900.0 │          126 │
│ pyspark    │      153900.0 │          153 │
│ kafka      │      140650.0 │          236 │
│ databricks │      139600.0 │          297 │
│ postgresql │      135000.0 │          116 │
│ gcp        │      129750.0 │          207 │
│ airflow    │      126750.0 │          290 │
│ scala      │      125300.0 │          210 │
│ aws        │      125300.0 │          527 │
│ hadoop     │      125300.0 │          200 │
│ spark      │      124650.0 │          460 │
│ azure      │      124500.0 │          479 │
│ sql        │      124500.0 │          919 │
│ bigquery   │      124000.0 │          129 │
│ python     │      124000.0 │          888 │
│ mysql      │      122250.0 │          120 │
│ kubernetes │      120000.0 │          110 │
│ sql server │      120000.0 │          118 │
│ flow       │      118500.0 │          140 │
│ git        │      108750.0 │          129 │
│ java       │      107500.0 │          277 │
└────────────┴───────────────┴──────────────┘

*/