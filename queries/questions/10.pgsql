-- 10. In which region of Italy the least people got sick with covid?

SELECT 
    itr_region,
    SUM(cit_cases)
FROM 
    covid_italy,
    italy_provinces,
    italy_regions
WHERE
    cit_province = itp_id
    AND
    itr_id = itp_region_id
GROUP BY itr_region
ORDER BY SUM(cit_cases) ASC
LIMIT 1
;