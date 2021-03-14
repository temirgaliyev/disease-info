-- What blood pressure, cholesterol examination, glucose examination and gender in average has oldest people with cardio disease?

SELECT
    mode() WITHIN GROUP (ORDER BY cat_bp.cat) AS blood_pressure,
    mode() WITHIN GROUP (ORDER BY cat_chol_exam.cat) AS cholesterol_exam,
    mode() WITHIN GROUP (ORDER BY cat_gluc_exam.cat) AS glucose_exam,
    mode() WITHIN GROUP (ORDER BY cat_gender.cat) AS gender
FROM
    cardio,
    cat_bp,
    cat_chol_exam,
    cat_gluc_exam,
    cat_gender
WHERE
    cardio.c_cardio_disease = TRUE
    AND
    cardio.c_age = (
        SELECT MAX(c_age) FROM cardio
    )
    AND
    cat_bp.id = cardio.c_blood_pressure_id
    AND
    cat_chol_exam.id = cardio.c_cholesterol_id
    AND
    cat_gluc_exam.id = cardio.c_glucose_id
    AND
    cat_gender.id = cardio.c_gender_id
    ;