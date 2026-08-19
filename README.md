# Formula 1 Business Intelligence

## Grand Prix Performance Evaluation Platform

A portfolio-grade BI / Data Analytics project built around the historical Formula 1 World Championship dataset (1950–2024).

The project simulates an internal analytics platform for **Formula One Management (FOM)** focused on:

- Grand Prix and circuit performance
- driver consistency and position movement
- constructor dominance and growth
- qualifying effectiveness
- pit-stop / race-strategy proxies
- championship competitiveness
- season-over-season change analysis

## Architecture

```text
CSV source data
      │
      ▼
   Extract
      │
      ▼
 Transform + quality checks
      │
      ▼
 PostgreSQL analytical database
      │
      ├── validation SQL
      ├── 21 analytical SQL queries
      │
      ▼
 Tableau-ready datasets
      │
      ▼
 Tableau Public dashboards
```

## Tech stack

- Python 3.13
- Pandas / NumPy
- PostgreSQL
- SQLAlchemy + psycopg2
- Jupyter
- Matplotlib / Seaborn
- Tableau Public
- Git / GitHub

## Project structure

```text
formula1-business-intelligence-main/
├── data/
│   └── raw/                     # source CSV files
├── dashboard/
│   ├── executive_season_kpis.csv
│   ├── driver_performance.csv
│   ├── constructor_performance.csv
│   ├── race_analysis.csv
│   ├── pit_stop_analysis.csv
│   └── tableau_dashboard_spec.md
├── docs/
│   ├── project_specification.md
│   ├── business_questions.md
│   ├── business_question_mapping.md
│   ├── kpi_definition.md
│   ├── data_inventory.md
│   ├── etl.md
│   ├── data_quality_report.md
│   └── data_dictionary.md
├── sql/
│   ├── schema.sql
│   ├── indexes.sql
│   ├── validation.sql
│   └── analytics/               # 21 business queries
├── src/
│   └── etl/
│       ├── extract.py
│       ├── transform.py
│       ├── load.py
│       ├── logger.py
│       └── pipeline.py
├── .env.example
└── requirements.txt
```

## Setup

### 1. Create the environment

```bash
python3.13 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### 2. Configure PostgreSQL

Create a database named `formula1`, then execute:

```bash
psql -h localhost -p 5433 -U postgres -d formula1 -f sql/schema.sql
psql -h localhost -p 5433 -U postgres -d formula1 -f sql/indexes.sql
```

Copy `.env.example` to `.env` and export the values before running the pipeline:

```bash
export F1_DB_HOST=localhost
export F1_DB_PORT=5433
export F1_DB_NAME=formula1
export F1_DB_USER=postgres
export F1_DB_PASSWORD='your_password'
```

### 3. Run ETL

From the project root:

```bash
python -m src.etl.pipeline
```

The pipeline:

1. reads all available raw CSV files;
2. converts `\N` to null;
3. normalizes column names to `snake_case`;
4. converts dates, times and numeric fields;
5. removes exact duplicate rows;
6. validates primary keys and non-negative metrics;
7. loads data into PostgreSQL;
8. writes execution details to `logs/etl.log`.

## Analytical layer

The project contains 21 SQL analyses covering:

1. Grand Prix performance
2. competitive circuits
3. position gain by race
4. retirements by race
5. predictable races
6. driver consistency
7. wins without pole
8. driver position improvement
9. best drivers by circuit
10. constructor dominance
11. constructor growth
12. qualifying performance
13. race-strategy efficiency proxy
14. most exciting circuits
15. circuit retirement rate
16. overtaking difficulty proxy
17. circuit result stability
18. competitiveness by season
19. unique winners by season
20. most competitive seasons
21. season-over-season change detection

## Important analytical limitation

The historical dataset does **not** contain audience/viewership, commercial revenue, telemetry, exact on-track overtake events, or a structured regulation-change table.

Therefore the project explicitly labels derived metrics such as:

- position gain;
- competitiveness;
- spectacle;
- strategy efficiency;
- overtaking difficulty;
- regulation-change signals

as **proxies**, not official Formula 1 metrics.

This distinction is intentional and is part of the analytical methodology.

## Dashboard

The `dashboard/` directory contains Tableau-ready CSV datasets.

The dashboard specification defines five views:

- Executive Overview
- Driver Performance
- Constructor Performance
- Race & Circuit Analysis
- Pit Stop Analysis

See `dashboard/tableau_dashboard_spec.md`.

## Data source

Historical Formula 1 data covering 1950–2024, stored in `data/raw/`.

See `docs/data_inventory.md` and `docs/data_quality_report.md` for source coverage and quality assessment.
