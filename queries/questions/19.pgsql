-- 19. what is the distribution of diseases of each eye in different genders? 

SELECT 
    cat_gender.cat,
    cat_eye.cat,
    count(*)
FROM 
    cat_gender,
    cat_eye,
    ocular,
    ocular_diagnostics,
    ocular_diagnostic_keywords
WHERE
    cat_gender.id = ocular.o_gender_id
    AND
    ocular_diagnostics.od_case_id = ocular.o_id
    AND
    ocular_diagnostics.od_eye_id = cat_eye.id
    AND
    ocular_diagnostics.od_diag_id = ocular_diagnostic_keywords.odk_id    
    AND
    ocular_diagnostic_keywords.odk_diagnostic != 'normal fundus'
GROUP BY
    cat_gender.cat,
    cat_eye.cat
;
