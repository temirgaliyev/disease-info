-- 12. Is there a correlation between the number of cases of covid per day in Italy and India?

SELECT 
    corr(cit_cases, cin_cases)
FROM 
(
    SELECT 
        cit_date::date,
        SUM(cit_cases) AS cit_cases
    FROM 
        covid_italy
    GROUP BY cit_date::date
) AS italy,
(
    SELECT 
        cin_date::date,
        SUM(cin_confirmed) AS cin_cases
    FROM 
        covid_india
    GROUP BY cin_date::date
) AS invia
WHERE
    cit_date = cin_date
;