SELECT 
    cc.entity,
    cc.code,
    AVG(cases.number_rabies) AS avg_rabies,
    MIN(cases.number_rabies) AS min_rabies,
    MAX(cases.number_rabies) AS max_rabies,
    SUM(cases.number_rabies) AS sum_rabies
FROM
    cases
        JOIN
    country_codes cc ON cases.country_id = cc.country_id
WHERE
    cases.number_rabies IS NOT NULL
GROUP BY cc.entity , cc.code
ORDER BY avg_rabies DESC
LIMIT 10;