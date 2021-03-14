-- 14. Is there a correlation between diabetes and different diseases?

SELECT  
    *
FROM
(
    SELECT
        corr(c_diabetes::INTEGER, c_cardio_disease::INTEGER) AS cardio_diabet_corr
    FROM 
        cardio
) AS cardio_diabet,
(
    SELECT
        corr(h_diabetes::INTEGER, h_heart_disease::INTEGER) AS heart_diabet_corr
    FROM 
        heart
) AS heart_diabet,
(
    SELECT
        corr(k_diabetes::INTEGER, k_kidney_disease::INTEGER) AS kidney_diabet_corr
    FROM 
        kidney
) AS kidney_diabet,
(
    SELECT
        corr(o_diabetes::INTEGER, od_diag_id) AS ocular_diabet_corr
    FROM 
        ocular,
        ocular_diagnostics
    WHERE
        o_id = od_diag_id
) AS ocular_diabet
;
