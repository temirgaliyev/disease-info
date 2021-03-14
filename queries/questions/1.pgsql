-- 1. What is the most common eye disease?

SELECT 
    count(*) 
        FILTER (WHERE o_glaucoma) 
        AS glaucoma,
    count(*) 
        FILTER (WHERE o_cataract) 
        AS cataract,
    count(*) 
        FILTER (WHERE o_myopia) 
        AS myopia,
    count(*) 
        FILTER (WHERE o_hypertension) 
        AS hypertension,
    count(*) 
        FILTER (WHERE o_diabetes) 
        AS diabetes,
    count(*) 
        FILTER (WHERE o_other) 
        AS other
FROM ocular;

-- -- My mode
-- SELECT odk_diagnostic
-- FROM ocular_diagnostic_keywords
-- WHERE odk_id = (
--     SELECT od_diag_id
--     FROM ocular_diagnostics
--     GROUP BY od_diag_id
--     ORDER BY COUNT(*) DESC
--     LIMIT 1
-- );

-- Built-in mode
-- https://wiki.postgresql.org/wiki/Aggregate_Mode
SELECT odk_diagnostic
FROM ocular_diagnostic_keywords
WHERE odk_id = (
    SELECT mode() 
        WITHIN GROUP (ORDER BY od_diag_id) 
    FROM ocular_diagnostics
);
