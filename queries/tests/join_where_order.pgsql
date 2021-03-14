-- Assumption: execution time should mainly depend on order of conditions in WHERE clause
-- Results: no significant difference
--          it might be due to small table size (6392)
--          postgresql may have some inner optimizations to faster execution and user's order doesn't matter
-- Related to: Q17

EXPLAIN ANALYZE SELECT 
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
    ocular_diagnostics.od_case_id = ocular.o_id
    AND
    ocular_diagnostics.od_eye_id = cat_eye.id
    AND
    ocular_diagnostics.od_diag_id = ocular_diagnostic_keywords.odk_id    
    AND
    cat_gender.cat = 'male'
    AND
    ocular_diagnostic_keywords.odk_diagnostic = 'white vessel'
    AND
    cat_eye.cat = 'left'
    ;

EXPLAIN ANALYZE SELECT 
    COUNT(*)
FROM
    cat_gender,
    ocular,
    ocular_diagnostics,
    ocular_diagnostic_keywords,
    cat_eye
WHERE
    ocular_diagnostic_keywords.odk_diagnostic = 'white vessel'
    AND
    cat_gender.cat = 'male'
    AND
    cat_eye.cat = 'left'
    AND
    ocular.o_gender_id = cat_gender.id
    AND
    ocular_diagnostics.od_case_id = ocular.o_id
    AND
    ocular_diagnostics.od_eye_id = cat_eye.id
    AND
    ocular_diagnostics.od_diag_id = ocular_diagnostic_keywords.odk_id    
    ;

EXPLAIN ANALYZE SELECT 
    COUNT(*)
FROM
    cat_gender,
    ocular,
    ocular_diagnostics,
    ocular_diagnostic_keywords,
    cat_eye
WHERE
    ocular_diagnostic_keywords.odk_diagnostic = 'white vessel'
    AND
    cat_eye.cat = 'left'
    AND
    cat_gender.cat = 'male'
    AND
    ocular.o_gender_id = cat_gender.id
    AND
    ocular_diagnostics.od_case_id = ocular.o_id
    AND
    ocular_diagnostics.od_eye_id = cat_eye.id
    AND
    ocular_diagnostics.od_diag_id = ocular_diagnostic_keywords.odk_id    
    ;