-- 6. What is the most common eye disease in people with diabetes?

SELECT 
    odk_diagnostic,
    count(*)
FROM 
    ocular,
    ocular_diagnostics,
    ocular_diagnostic_keywords
WHERE 
    o_diabetes = TRUE
    AND
    od_diag_id = o_id
    AND
    odk_id = od_diag_id
GROUP BY
    odk_diagnostic
ORDER BY
    COUNT(*) DESC
LIMIT 1
    ;

-- Using built-in mode without count 
-- 
-- SELECT 
--     mode() WITHIN GROUP (ORDER BY odk_diagnostic) AS diag,
--     COUT(diag)
-- FROM 
--     ocular,
--     ocular_diagnostics,
--     ocular_diagnostic_keywords
-- WHERE 
--     o_diabetes = TRUE
--     AND
--     od_diag_id = o_id
--     AND
--     odk_id = od_diag_id
--     ;