# Data Inventory

## Project

Grand Prix Performance Evaluation Platform

---

# Purpose

Данный документ содержит перечень всех источников данных, используемых в проекте, их описание, назначение и статус использования.

---

# Data Source

| Parameter | Value |
|-----------|-------|
| Source | Kaggle |
| Dataset | Formula 1 World Championship (1950–2024) |
| Format | CSV |
| License | Open Database License (ODbL) |
| Update Frequency | Historical Dataset |
| Storage | /data/raw |

---

# Dataset Inventory

| Dataset | Description | Primary Key | Rows (Approx.) | Status | Used |
|----------|-------------|-------------|---------------:|--------|------|
| circuits.csv | Information about Formula 1 circuits | circuitId | ~80 | Planned | ✅ |
| constructor_results.csv | Constructor race results | constructorResultsId | ~12,000 | Planned | ⏳ |
| constructor_standings.csv | Constructor championship standings | constructorStandingsId | ~13,000 | Planned | ✅ |
| constructors.csv | Constructor information | constructorId | ~220 | Planned | ✅ |
| driver_standings.csv | Driver championship standings | driverStandingsId | ~35,000 | Planned | ✅ |
| drivers.csv | Driver information | driverId | ~900 | Planned | ✅ |
| lap_times.csv | Lap-by-lap race data | raceId + driverId + lap | ~600,000 | Planned | ✅ |
| pit_stops.csv | Pit stop information | raceId + driverId + stop | ~10,000 | Planned | ⏳ |
| qualifying.csv | Qualifying session results | qualifyId | ~10,000 | Planned | ✅ |
| races.csv | Grand Prix information | raceId | ~1,100 | Planned | ✅ |
| results.csv | Race results | resultId | ~27,000 | Planned | ✅ |
| seasons.csv | Formula 1 seasons | year | ~75 | Planned | ✅ |
| sprint_results.csv | Sprint race results | resultId | ~600 | Optional | ⏳ |
| status.csv | Driver finish status (Finished, Accident, Engine, etc.) | statusId | ~140 | Planned | ✅ |

---

# Business Importance

| Dataset | Business Purpose |
|----------|-----------------|
| races | Analyze Grand Prix performance |
| circuits | Analyze circuit characteristics |
| drivers | Driver analytics |
| constructors | Team analytics |
| results | Race performance analysis |
| qualifying | Starting position analysis |
| lap_times | Pace and consistency analysis |
| pit_stops | Strategy analysis |
| standings | Championship analysis |
| status | Retirement analysis |

---

# Data Relationships

Main relationships between datasets:

```
Seasons
    │
    ▼
Races
    │
    ├──────────► Circuits
    │
    ├──────────► Results
    │               │
    │               ├────────► Drivers
    │               │
    │               └────────► Constructors
    │
    ├──────────► Qualifying
    │
    ├──────────► Lap Times
    │
    ├──────────► Pit Stops
    │
    └──────────► Standings
```

---

# Data Quality Checklist

| Check | Status |
|--------|--------|
| Missing values inspection | ☐ |
| Duplicate records inspection | ☐ |
| Data type validation | ☐ |
| Foreign key validation | ☐ |
| Null value analysis | ☐ |
| Outlier detection | ☐ |
| Primary key validation | ☐ |

---

# Data Storage

```
data/

├── raw/
│   ├── circuits.csv
│   ├── constructors.csv
│   ├── drivers.csv
│   ├── races.csv
│   ├── results.csv
│   ├── qualifying.csv
│   ├── lap_times.csv
│   ├── pit_stops.csv
│   ├── driver_standings.csv
│   ├── constructor_standings.csv
│   ├── seasons.csv
│   ├── status.csv
│   └── sprint_results.csv
│
├── processed/
│
└── external/
```
