CREATE TABLE countries(
    country_id SERIAL PRIMARY KEY,
    country_name TEXT,
    region_id INTEGER,
    population INTEGER
);
INSERT INTO countries(country_name, region_id, population)
VALUES ('Italy',11,24042005);

INSERT INTO countries(country_id,country_name)
VALUES (17,'Japan');

INSERT INTO countries (country_name, region_id, population)
VALUES ('France', NULL,19112021);

INSERT INTO countries(country_name, region_id, population)
VALUES
('Korea',22,10403013),
('Venezuela',19,10606205),
('Germany',26,23022004);

ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries (region_id, population)
VALUES (18, 10306013);

INSERT INTO countries DEFAULT VALUES;

CREATE TABLE countries_new(LIKE countries INCLUDING ALL );
INSERT INTO countries_new
SELECT *FROM countries;

UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

SELECT country_name,
       population * 1.10 AS "New Population"
FROM countries;

DELETE FROM countries
WHERE population < 100000;

DELETE FROM countries_new
USING countries
WHERE countries_new.country_id = countries.country_id
RETURNING countries_new.*;

DELETE FROM countries
RETURNING *;