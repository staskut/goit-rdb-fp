DELIMITER //

drop function if exists YearDifference;
CREATE FUNCTION YearDifference(year_input INT)
RETURNS INT
NO SQL
BEGIN
    DECLARE first_january_date DATE;
    DECLARE years_difference INT;

    -- Формуємо дату 1 січня на основі вхідного року
    SET first_january_date = DATE(CONCAT(year_input, '-01-01'));

    -- Обчислюємо різницю в роках між поточною датою та сформованою датою
    SET years_difference = TIMESTAMPDIFF(YEAR, first_january_date, CURRENT_DATE());

    -- Повертаємо результат
    RETURN years_difference;
END //

DELIMITER ;

SELECT
    year,
    TIMESTAMPDIFF(YEAR,
        DATE(CONCAT(Year, '-01-01')),
        CURRENT_DATE()) AS years_diff_prev_task,
    YearDifference(CAST(`year` AS UNSIGNED)) AS years_diff_func
FROM cases;
