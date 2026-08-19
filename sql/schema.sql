-- Formula 1 Business Intelligence database schema.
-- Source: Formula 1 World Championship historical CSV dataset (1950-2024).

DROP TABLE IF EXISTS
    pit_stops,
    lap_times,
    sprint_results,
    results,
    qualifying,
    driver_standings,
    constructor_standings,
    constructor_results,
    races,
    status,
    constructors,
    drivers,
    circuits,
    seasons
CASCADE;

CREATE TABLE seasons (
    year INT PRIMARY KEY,
    url TEXT NOT NULL
);

CREATE TABLE circuits (
    circuit_id INT PRIMARY KEY,
    circuit_ref VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    country VARCHAR(100) NOT NULL,
    lat NUMERIC(9,6) NOT NULL,
    lng NUMERIC(9,6) NOT NULL,
    alt INT,
    url TEXT NOT NULL
);

CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    driver_ref VARCHAR(50) NOT NULL UNIQUE,
    number INT,
    code VARCHAR(3),
    forename VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    nationality VARCHAR(100) NOT NULL,
    url TEXT NOT NULL
);

CREATE TABLE constructors (
    constructor_id INT PRIMARY KEY,
    constructor_ref VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    nationality VARCHAR(100) NOT NULL,
    url TEXT NOT NULL
);

CREATE TABLE status (
    status_id INT PRIMARY KEY,
    status VARCHAR(255) NOT NULL
);

CREATE TABLE races (
    race_id INT PRIMARY KEY,
    year INT REFERENCES seasons(year),
    round INT NOT NULL,
    circuit_id INT REFERENCES circuits(circuit_id),
    name VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    race_time TIME,
    url TEXT NOT NULL,
    fp1_date DATE,
    fp1_time TIME,
    fp2_date DATE,
    fp2_time TIME,
    fp3_date DATE,
    fp3_time TIME,
    quali_date DATE,
    quali_time TIME,
    sprint_date DATE,
    sprint_time TIME
);

CREATE TABLE results (
    result_id INT PRIMARY KEY,
    race_id INT REFERENCES races(race_id),
    driver_id INT REFERENCES drivers(driver_id),
    constructor_id INT REFERENCES constructors(constructor_id),
    status_id INT REFERENCES status(status_id),
    number INT,
    grid INT NOT NULL,
    position INT,
    position_text VARCHAR(255),
    position_order INT,
    points NUMERIC(5,1) NOT NULL,
    laps INT NOT NULL,
    race_time VARCHAR(255),
    milliseconds BIGINT,
    fastest_lap INT,
    fastest_lap_rank INT,
    fastest_lap_time VARCHAR(255),
    fastest_lap_speed NUMERIC(6,3)
);

CREATE TABLE lap_times (
    race_id INT REFERENCES races(race_id),
    driver_id INT REFERENCES drivers(driver_id),
    lap INT NOT NULL,
    position INT,
    race_time VARCHAR(255),
    milliseconds BIGINT,
    PRIMARY KEY (race_id, driver_id, lap)
);

CREATE TABLE pit_stops (
    race_id INT REFERENCES races(race_id),
    driver_id INT REFERENCES drivers(driver_id),
    stop INT NOT NULL,
    lap INT NOT NULL,
    race_time VARCHAR(255),
    duration VARCHAR(255) NOT NULL,
    milliseconds BIGINT NOT NULL,
    PRIMARY KEY (race_id, driver_id, stop)
);

CREATE TABLE qualifying (
    qualify_id INT PRIMARY KEY,
    race_id INT REFERENCES races(race_id),
    driver_id INT REFERENCES drivers(driver_id),
    constructor_id INT REFERENCES constructors(constructor_id),
    number INT NOT NULL,
    position INT,
    q1 VARCHAR(255),
    q2 VARCHAR(255),
    q3 VARCHAR(255)
);

CREATE TABLE driver_standings (
    driver_standings_id INT PRIMARY KEY,
    race_id INT REFERENCES races(race_id),
    driver_id INT REFERENCES drivers(driver_id),
    points NUMERIC(5,1) NOT NULL,
    position INT,
    position_text VARCHAR(255),
    wins INT NOT NULL
);

CREATE TABLE constructor_results (
    constructor_results_id INT PRIMARY KEY,
    race_id INT REFERENCES races(race_id),
    constructor_id INT REFERENCES constructors(constructor_id),
    points NUMERIC(5,1) NOT NULL,
    status VARCHAR(255)
);

CREATE TABLE constructor_standings (
    constructor_standings_id INT PRIMARY KEY,
    race_id INT REFERENCES races(race_id),
    constructor_id INT REFERENCES constructors(constructor_id),
    points NUMERIC(5,1) NOT NULL,
    position INT,
    position_text VARCHAR(255),
    wins INT NOT NULL
);

CREATE TABLE sprint_results (
    result_id INT PRIMARY KEY,
    race_id INT REFERENCES races(race_id),
    driver_id INT REFERENCES drivers(driver_id),
    constructor_id INT REFERENCES constructors(constructor_id),
    status_id INT REFERENCES status(status_id),
    number INT NOT NULL,
    grid INT NOT NULL,
    position INT,
    position_text VARCHAR(255),
    position_order INT,
    points NUMERIC(5,1) NOT NULL,
    laps INT NOT NULL,
    race_time VARCHAR(255),
    milliseconds BIGINT,
    fastest_lap INT,
    fastest_lap_rank INT,
    fastest_lap_time VARCHAR(255),
    fastest_lap_speed NUMERIC(6,3)
);
