-- 2. What diseases does a middle-aged man suffer from?

-- https://wiki.postgresql.org/wiki/Aggregate_Median
CREATE OR REPLACE FUNCTION _final_median(numeric[])
   RETURNS numeric AS
$$
   SELECT AVG(val)
   FROM (
     SELECT val
     FROM unnest($1) val
     ORDER BY 1
     LIMIT  2 - MOD(array_upper($1, 1), 2)
     OFFSET CEIL(array_upper($1, 1) / 2.0) - 1
   ) sub;
$$
LANGUAGE 'sql' IMMUTABLE;

CREATE OR REPLACE AGGREGATE median(numeric) (
  SFUNC=array_append,
  STYPE=numeric[],
  FINALFUNC=_final_median,
  INITCOND='{}'
);

CREATE OR REPLACE FUNCTION _get_median_age()
    RETURNS NUMERIC AS
$$
    SELECT median(age)
    FROM (
        SELECT h_age AS age FROM heart 
        UNION 
        SELECT c_age AS age FROM cardio
        UNION 
        SELECT k_age AS age FROM kidney
        UNION 
        SELECT o_age AS age FROM ocular 
    ) AS ages_union
$$
LANGUAGE 'sql' IMMUTABLE;

-- SELECT 
--     mode() WITHIN GROUP (ORDER BY c_diabetes) AS diabetes,
--     mode() WITHIN GROUP (ORDER BY c_hypertension) AS hypertension,
--     mode() WITHIN GROUP (ORDER BY c_cardio_disease) AS cardio_disease,
--     mode() WITHIN GROUP (ORDER BY h_heart_disease) AS heart_disease
-- FROM (
--     SELECT 
--         c_diabetes,
--         c_hypertension,
--         c_cardio_disease,
--         h_heart_disease
--     FROM 
--         cardio,
--         heart,
--         kidney,
--         ocular,
--         cat_gender
--     WHERE
--         c_age = _get_median_age()
--         AND
--         h_age = _get_median_age()
--         AND
--         k_age = _get_median_age()
--         AND
--         o_age = _get_median_age()
--         AND
--         c_gender_id = cat_gender.id
--         AND
--         h_gender_id = cat_gender.id
--         AND
--         o_gender_id = cat_gender.id
--         AND
--         cat_gender.cat = 'male'
-- ) AS median_cardio_diseases
-- ;


SELECT
    cat,
    mode() WITHIN GROUP (ORDER BY odk_diagnostic) AS ocular_disease
FROM (
    SELECT 
        odk_diagnostic,
        cat_eye.cat
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
        ocular_diagnostic_keywords.odk_diagnostic != 'normal fundus'
) AS ocular_median
GROUP BY 
    cat
;
