-- 7. What percentage of diabetics by gender?

SELECT
    cat_gender.cat,
    count
FROM (
    SELECT
    gender_id,
    COUNT(*)
    FROM (
        SELECT c_gender_id AS gender_id 
        FROM cardio 
        WHERE c_diabetes = TRUE
        UNION ALL
        SELECT h_gender_id AS gender_id 
        FROM heart
        WHERE h_diabetes = TRUE
        UNION ALL
        SELECT o_gender_id AS gender_id 
        FROM ocular
        WHERE o_diabetes = TRUE
    ) AS gender_ids
    GROUP BY gender_id
) AS gender_ids
INNER JOIN cat_gender
    ON gender_id = cat_gender.id
;
