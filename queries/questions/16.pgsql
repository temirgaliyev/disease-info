-- 16. How likely to get age-related disease on each eye?

SELECT
    cat_eye,
    cat_gender,
    count,
    count / SUM(count) OVER ()
FROM
(
    SELECT 
        cat_eye.cat AS cat_eye,
        cat_gender.cat AS cat_gender,
        COUNT(*)
    FROM 
        cat_gender,
        ocular,
        ocular_diagnostics,
        ocular_diagnostic_keywords,
        cat_eye
    WHERE
        ocular.o_gender_id = cat_gender.id
        AND
        ocular.o_id = ocular_diagnostics.od_id
        AND
        ocular_diagnostics.od_diag_id = ocular_diagnostic_keywords.odk_id
        AND
        ocular_diagnostic_keywords.odk_diagnostic LIKE '%age-related%'
    GROUP BY
        cat_eye.cat,
        cat_gender.cat
) AS ocular_age_related
;