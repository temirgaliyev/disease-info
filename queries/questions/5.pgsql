-- 5. What is the susceptibility of myocardial ischemia by age?

SELECT 
    corr(h_cad::INTEGER, h_age)
FROM 
    heart;