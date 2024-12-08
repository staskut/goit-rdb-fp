SELECT 
    `year`,
    DATE(CONCAT(Year, '-01-01')) AS first_january_date,
    CURRENT_DATE() AS 'current_date',
    TIMESTAMPDIFF(YEAR,
        DATE(CONCAT(Year, '-01-01')),
        CURRENT_DATE()) AS years_diff
FROM
    cases;