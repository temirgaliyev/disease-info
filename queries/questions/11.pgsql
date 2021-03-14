-- 11. On what day was the highest number of cases in Italy?

SELECT 
    cit_date::date,
    SUM(cit_cases)
FROM 
    covid_italy
GROUP BY cit_date::date
ORDER BY sum DESC
LIMIT 1
;