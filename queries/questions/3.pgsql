-- 3. What is the mean arterial pressure of smokers?

SELECT 
    avg(c_ap_hi) AS systolic, 
    avg(c_ap_lo) AS diastolic
FROM 
    cardio
WHERE
    c_smoke = TRUE;