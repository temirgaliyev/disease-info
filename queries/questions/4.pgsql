-- 4. What is the percentage of people with myocardial ischemia among those with heart disease?

SELECT 
    COUNT(*) FILTER (WHERE h_cad)::NUMERIC / COUNT(*) * 100 AS percentage
FROM
    heart
WHERE
    h_heart_disease = TRUE;
