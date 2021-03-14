-- Problem: unctions called in WHERE clause re-called for each row
-- Solutions: 
--     1. Use IMMUTABLE function
--     2. Call function in SELECT clause inside WHERE clause
-- Results:
--     1. MUTABLE function w/o SELECT inside WHERE clause - 5076.378 ms
--     2. MUTABLE function w/ SELECT inside WHERE clause - 16.424 ms
--     3. IMMUTABLE function w/o SELECT inside WHERE clause -  0.100 ms
--     4. IMMUTABLE function w/ SELECT inside WHERE clause - 0.167 ms
-- Conclusion: It's always better to use IMMUTABLE if possible
--             but difference between using IMMUTABLE w/ SELECT  
--             inside WHERE clause and not differs from time to time  
--             on some tables first is better, on others - second
-- Related to: Q2

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

-- I tried to declare variables in DO block, but that doesn't WORK
-- So I decided to create function that calculates median age each time
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

CREATE OR REPLACE FUNCTION _get_median_age_mutable()
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
LANGUAGE 'sql';


EXPLAIN ANALYZE SELECT 
    'Diabetes: ' || mode() WITHIN GROUP (ORDER BY h_diabetes),
    'Hypertension: ' || mode() WITHIN GROUP (ORDER BY h_hypertension),
    'Heart disease: ' || mode() WITHIN GROUP (ORDER BY h_heart_disease)
FROM (
    SELECT 
        h_diabetes,
        h_hypertension,
        h_heart_disease
    FROM heart
    WHERE
    h_age = _get_median_age_mutable()
) AS median_cardio_diseases
;

EXPLAIN ANALYZE SELECT 
    'Diabetes: ' || mode() WITHIN GROUP (ORDER BY h_diabetes),
    'Hypertension: ' || mode() WITHIN GROUP (ORDER BY h_hypertension),
    'Heart disease: ' || mode() WITHIN GROUP (ORDER BY h_heart_disease)
FROM (
    SELECT 
        h_diabetes,
        h_hypertension,
        h_heart_disease
    FROM heart
    WHERE
    h_age = (SELECT _get_median_age_mutable())
) AS median_cardio_diseases
;



EXPLAIN ANALYZE SELECT 
    'Diabetes: ' || mode() WITHIN GROUP (ORDER BY h_diabetes),
    'Hypertension: ' || mode() WITHIN GROUP (ORDER BY h_hypertension),
    'Heart disease: ' || mode() WITHIN GROUP (ORDER BY h_heart_disease)
FROM (
    SELECT 
        h_diabetes,
        h_hypertension,
        h_heart_disease
    FROM heart
    WHERE
    h_age = _get_median_age()
) AS median_cardio_diseases
;

EXPLAIN ANALYZE SELECT 
    'Diabetes: ' || mode() WITHIN GROUP (ORDER BY h_diabetes),
    'Hypertension: ' || mode() WITHIN GROUP (ORDER BY h_hypertension),
    'Heart disease: ' || mode() WITHIN GROUP (ORDER BY h_heart_disease)
FROM (
    SELECT 
        h_diabetes,
        h_hypertension,
        h_heart_disease
    FROM heart
    WHERE
    h_age = (SELECT _get_median_age())
) AS median_cardio_diseases
;
