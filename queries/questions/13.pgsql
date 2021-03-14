-- 13. Which gender is most likely to get sick with each of the diseases?

SELECT 
    cardio_gender.cat,
    cardio_count,
    heart_count,
    ocular_count
FROM 
(
    SELECT
        cat_gender.cat,
        COUNT(*) AS cardio_count
    FROM 
        cat_gender,
        cardio
    WHERE
        cardio.c_gender_id = cat_gender.id
    GROUP BY
        cat_gender.cat
) AS cardio_gender,
(
    SELECT
        cat_gender.cat,
        COUNT(*) AS heart_count
    FROM 
        cat_gender,
        heart
    WHERE
        heart.h_gender_id = cat_gender.id
    GROUP BY
        cat_gender.cat
) AS heart_gender,
(
    SELECT
        cat_gender.cat,
        COUNT(*) AS ocular_count
    FROM 
        cat_gender,
        ocular,
        ocular_diagnostics,
        ocular_diagnostic_keywords
    WHERE
        ocular.o_gender_id = cat_gender.id
        AND
        ocular.o_id = ocular_diagnostics.od_id
        AND
        ocular_diagnostics.od_diag_id = ocular_diagnostic_keywords.odk_id
        AND
        ocular_diagnostic_keywords.odk_diagnostic != 'normal fundus'
    GROUP BY
        cat_gender.cat
) AS ocular_gender
WHERE
    cardio_gender.cat = heart_gender.cat
    AND
    ocular_gender.cat = cardio_gender.cat
;
