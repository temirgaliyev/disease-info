-- 8. What is the most concomitant disease of glaucoma?

SELECT
    COUNT(*) FILTER(WHERE o_glaucoma = o_hypertension)::NUMERIC/COUNT(*) AS hypertension,
    COUNT(*) FILTER(WHERE o_glaucoma = o_cataract)::NUMERIC/COUNT(*) AS cataract,
    COUNT(*) FILTER(WHERE o_glaucoma = o_myopia)::NUMERIC/COUNT(*) AS myopia,
    COUNT(*) FILTER(WHERE o_glaucoma = o_diabetes)::NUMERIC/COUNT(*) AS diabetes,
    COUNT(*) FILTER(WHERE o_glaucoma = o_other)::NUMERIC/COUNT(*) AS other    
FROM
    ocular
;