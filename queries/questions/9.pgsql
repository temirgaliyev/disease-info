-- 9. Is there a correlation between cardiovascular diseases and alcohol, smoking, physical activity?

SELECT
    corr(c_cardio_disease::INTEGER, c_alcohol::INTEGER),
    corr(c_cardio_disease::INTEGER, c_smoke::INTEGER),
    corr(c_cardio_disease::INTEGER, c_active::INTEGER)
FROM
    cardio
;