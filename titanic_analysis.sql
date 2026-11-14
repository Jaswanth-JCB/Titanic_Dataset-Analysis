CREATE SCHEMA titanic_project;

CREATE TABLE titanic_project.titanic_staging (
    name TEXT,
    sex VARCHAR(10),
    age DOUBLE PRECISION,
    sibsp INTEGER,
    parch INTEGER,
    embarked VARCHAR(5),
    ticket TEXT,
    fare DOUBLE PRECISION,
    cabin TEXT,
    passengerid INTEGER,
    pclass INTEGER,
    survived INTEGER
);

SELECT * FROM titanic_project.titanic_staging;

CREATE TABLE titanic_project.passengers (
    passengerid INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    sex VARCHAR(10),
    age DOUBLE PRECISION,
    sibsp INTEGER,
    parch INTEGER,
    embarked VARCHAR(5),
    ticket TEXT,
    fare DOUBLE PRECISION,
    cabin TEXT,
    pclass INTEGER,
    survived INTEGER
);


INSERT INTO titanic_project.passengers (
    passengerid, name, sex, age, sibsp, parch,
    embarked, ticket, fare, cabin, pclass, survived
)
SELECT
    passengerid, name, sex, age, sibsp, parch,
    embarked, ticket, fare, cabin, pclass, survived
FROM titanic_project.titanic_staging;


SELECT COUNT(*) AS total_passengers
FROM titanic_project.passengers;

SELECT *
FROM titanic_project.passengers
LIMIT 10;

SELECT
    COUNT(*) AS total_records,
    COUNT(age) AS available_age,
    COUNT(*) - COUNT(age) AS missing_age,
    COUNT(embarked) AS available_embarked,
    COUNT(*) - COUNT(embarked) AS missing_embarked,
    COUNT(cabin) AS available_cabin,
    COUNT(*) - COUNT(cabin) AS missing_cabin
FROM titanic_project.passengers;

SELECT
    sex,
    COUNT(*) AS passenger_count
FROM titanic_project.passengers
GROUP BY sex
ORDER BY passenger_count DESC;

SELECT
    pclass,
    COUNT(*) AS passenger_count
FROM titanic_project.passengers
GROUP BY pclass
ORDER BY pclass;

SELECT
    pclass,
    ROUND(AVG(age)::numeric, 2) AS average_age
FROM titanic_project.passengers
GROUP BY pclass
ORDER BY pclass;


SELECT
    sex,
    COUNT(*) AS total_passengers,
    SUM(survived) AS survivors,
    ROUND(100.0 * SUM(survived) / COUNT(*), 2) AS survival_percentage
FROM titanic_project.passengers
GROUP BY sex
ORDER BY survival_percentage DESC;

SELECT
    passengerid,
    name,
    sex,
    pclass
FROM titanic_project.passengers
WHERE age IS NULL
ORDER BY passengerid
LIMIT 20;

SELECT
    passengerid,
    name,
    pclass,
    fare
FROM titanic_project.passengers
WHERE fare > (
    SELECT AVG(fare)
    FROM titanic_project.passengers
)
ORDER BY fare DESC
LIMIT 20;

SELECT
    pclass,
    COUNT(*) AS passenger_count,
    ROUND(AVG(fare)::numeric, 2) AS average_fare,
    ROUND(MIN(fare)::numeric, 2) AS minimum_fare,
    ROUND(MAX(fare)::numeric, 2) AS maximum_fare
FROM titanic_project.passengers
GROUP BY pclass
ORDER BY pclass;
