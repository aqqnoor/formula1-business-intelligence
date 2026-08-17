-- ====================================
-- Formula 1 Analytics Database
-- Schema Definition
-- ====================================

-- сезоны
create table seasons(
    year int not null primary key,
    url text not null
);

-- трассы
create table circuits(
    circuit_id int not null primary key,
    circuit_ref varchar(50) not null unique,
    name varchar(100) not null,
    location varchar(255) not null,
    country varchar(100) not null,
    lat NUMERIC(9,6) not null,
    lng NUMERIC(9,6) not null,
    alt int,
    url text not null
);

-- гонщики
create table drivers(
    driver_id int not null primary key,
    driver_ref varchar(50) not null unique,
    number int,
    code varchar(3),
    forename varchar(100) not null,
    surname varchar(100) not null,
    dob date not null,
    nationality varchar(100) not null,
    url text not null

);

-- конструкторы
create table constructors(
    constructor_id int not null primary key,
    constructor_ref varchar(50) not null unique,
    name varchar(255) not null,
    nationality varchar(100) not null,
    url text not null
);

-- статусы гонщиков
create table status(
    status_id int not null primary key,
    status varchar(255) not null
);

-- гонки
create table races(
    race_id int not null primary key,
    year int references seasons(year),
    round int not null,
    circuit_id int references circuits(circuit_id),
    name varchar(255) not null,
    date date not null,
    url text not null,
    fp1_date date,
    fp1_time time,
    fp2_date date,
    fp2_time time,
    fp3_date date,
    fp3_time time,
    quali_date date,
    quali_time time,
    sprint_date date,
    sprint_time time
);

-- результаты гонок
create table results(
    result_id int not null primary key,
    race_id int  references races(race_id),
    driver_id int  references drivers(driver_id),
    constructor_id int  references constructors(constructor_id),
    status_id int  references status(status_id),
    number int not null,
    grid int not null,
    position int,
    position_text varchar(255),
    position_order int,
    points NUMERIC(5,1) not null,
    laps int not null,
    race_time varchar(255),
    milliseconds bigint,
    fastest_lap int,
    fastest_lap_rank int,
    fastest_lap_time varchar(255),
    fastest_lap_speed NUMERIC(6,3)
);

-- результаты кругов
create table lap_times(
    race_id int  references races(race_id),
    driver_id int  references drivers(driver_id),
    lap int not null,
    position int,
    race_time varchar(255),
    milliseconds bigint,

    PRIMARY KEY (race_id, driver_id, lap)

);

-- результаты пит-стопов
create table pit_stops(
    race_id int  references races(race_id),
    driver_id int  references drivers(driver_id),
    stop int not null,
    lap int not null,
    race_time varchar(255),
    duration varchar(255) not null,
    milliseconds bigint not null,
    PRIMARY KEY (race_id, driver_id, stop)
);

-- результаты квалификаций
create table qualifying(
    qualify_id int not null primary key,
    race_id int  references races(race_id),
    driver_id int  references drivers(driver_id),
    constructor_id int references constructors(constructor_id),
    number int not null,
    position int,
    q1 varchar(255),
    q2 varchar(255),
    q3 varchar(255)
);

-- результаты чемпионатов
create table driver_standings(
    driver_standings_id int not null primary key,
    race_id int  references races(race_id),
    driver_id int  references drivers(driver_id),
    points NUMERIC(5,1) not null,
    position int,
    position_text varchar(255),
    wins int not null

);

-- результаты командных чемпионатов
create table constructor_results(
    constructor_results_id int not null primary key,
    race_id int  references races(race_id),
    constructor_id int  references constructors(constructor_id),
    points NUMERIC(5,1) not null,
    status varchar(255) not null
);

-- рейтинги командных чемпионатов
create table constructor_standings(
    constructor_standings_id int not null primary key,
    race_id int  references races(race_id),
    constructor_id int  references constructors(constructor_id),
    points NUMERIC(5,1) not null,
    position int ,
    position_text varchar(255),
    wins int not null
);

-- результаты спринтов
create table sprint_results(
    result_id int not null primary key,
    race_id int  references races(race_id),
    driver_id int  references drivers(driver_id),
    constructor_id int  references constructors(constructor_id),
    status_id int  references status(status_id),
    number int not null,
    grid int not null,
    position int,
    position_text varchar(255),
    position_order int,
    points NUMERIC(5,1) not null,
    laps int not null,
    race_time varchar(255),
    milliseconds bigint,
    fastest_lap int,
    fastest_lap_rank int,
    fastest_lap_time varchar(255),
    fastest_lap_speed NUMERIC(6,3)
);

ALTER TABLE races
ADD COLUMN race_time time;