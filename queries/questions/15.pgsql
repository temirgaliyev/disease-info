-- 15. Does a person lose appetite with kidney disease?

SELECT
    (COUNT(*) FILTER(WHERE k_kidney_disease = k_appetite)::NUMERIC)/COUNT(*)
FROM kidney
;
