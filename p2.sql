USE pandemic;

DROP TABLE IF EXISTS cases;
DROP TABLE IF EXISTS country_codes;
CREATE TABLE country_codes (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    entity VARCHAR(255) NOT NULL,
    code VARCHAR(10) NOT NULL,
    UNIQUE(entity, code)
);

INSERT INTO country_codes (entity, code)
SELECT DISTINCT entity, code
FROM infectious_cases;

CREATE TABLE cases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT NOT NULL,
    year INT NOT NULL,
    number_yaws INT,
    polio_cases INT,
    cases_guinea_worm INT,
    number_rabies INT,
    number_malaria INT,
    number_hiv INT,
    number_tuberculosis INT,
    number_smallpox INT,
    number_cholera_cases INT,
    FOREIGN KEY (country_id)
        REFERENCES country_codes (country_id)
);

INSERT INTO cases (
    country_id,
    year,
    number_yaws,
    polio_cases,
    cases_guinea_worm,
    number_rabies,
    number_malaria,
    number_hiv,
    number_tuberculosis,
    number_smallpox,
    number_cholera_cases
)
SELECT 
    cc.country_id,
    ic.year,
    COALESCE(NULLIF(ic.number_yaws, ''), 0),
    COALESCE(NULLIF(ic.polio_cases, ''), 0),
    COALESCE(NULLIF(ic.cases_guinea_worm, ''), 0),
    COALESCE(NULLIF(ic.number_rabies, ''), 0),
    COALESCE(NULLIF(ic.number_malaria, ''), 0),
    COALESCE(NULLIF(ic.number_hiv, ''), 0),
    COALESCE(NULLIF(ic.number_tuberculosis, ''), 0),
    COALESCE(NULLIF(ic.number_smallpox, ''), 0),
    COALESCE(NULLIF(ic.number_cholera_cases, ''), 0)
FROM infectious_cases ic
JOIN country_codes cc ON ic.entity = cc.entity AND ic.code = cc.code;