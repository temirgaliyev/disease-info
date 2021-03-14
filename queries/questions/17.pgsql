-- 17. How many males has white vessels on their left eye?

SELECT 
    COUNT(*)
FROM
    cat_gender,
    ocular,
    ocular_diagnostics,
    ocular_diagnostic_keywords,
    cat_eye
WHERE
    cat_gender.cat = 'male'
    AND
    ocular.o_gender_id = cat_gender.id
    AND
    ocular_diagnostics.od_case_id = ocular.o_id
    AND
    ocular_diagnostics.od_eye_id = cat_eye.id
    AND
    ocular_diagnostics.od_diag_id = ocular_diagnostic_keywords.odk_id    
    AND
    ocular_diagnostic_keywords.odk_diagnostic = 'white vessel'
    AND
    cat_eye.cat = 'left'
    ;
