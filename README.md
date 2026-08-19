# Formula 1 Business Intelligence

## Formula 1 Performance Analytics Platform

A portfolio Data Analytics / Business Intelligence project built on historical Formula 1 World Championship data from 1950–2024.

The project demonstrates a complete analytics workflow:

**Raw CSV → ETL → PostgreSQL → Data Quality → SQL Analytics → EDA → Tableau**

---

## Project Overview

The goal of the project is to analyze Formula 1 performance across drivers, constructors, races, circuits and seasons.

The analysis focuses on:

* driver performance and consistency;
* constructor performance and growth;
* qualifying effectiveness;
* race competitiveness;
* position movement;
* retirements and finish rates;
* circuit characteristics;
* pit-stop performance;
* season-over-season changes.

The project is structured as a simulated BI analytics platform that could support sports performance analysis and reporting.

---

## Business Questions

The project answers 21 analytical questions, including:

1. Which Grands Prix show the strongest overall performance?
2. Which circuits are the most competitive?
3. Which races have the highest position movement?
4. Which races have the highest retirement levels?
5. Which races are the most predictable?
6. Which drivers are the most consistent?
7. Which drivers win without starting from pole?
8. Which drivers improve their grid position the most?
9. Which drivers perform best at specific circuits?
10. Which constructors demonstrate the strongest dominance?
11. Which constructors show the strongest growth?
12. How effective are constructors in qualifying?
13. What can pit-stop and race-result data tell us about race strategy?
14. Which circuits show the highest level of competitive movement?
15. Which circuits have the highest retirement rates?
16. Which circuits appear hardest to overtake on?
17. Which circuits have the most stable finishing results?
18. How does competitiveness change by season?
19. How many unique winners are there in each season?
20. Which seasons are the most competitive?
21. Which seasons show significant changes in performance patterns?

---

## Data Pipeline

```text
Raw CSV files
      │
      ▼
   Extract
      │
      ▼
Transform
  ├── type conversion
  ├── date/time normalization
  ├── column normalization
  ├── duplicate detection
  └── data quality checks
      │
      ▼
 PostgreSQL
      │
      ├── validation SQL
      └── analytical SQL
      │
      ▼
    EDA
      │
      ▼
 Tableau-ready datasets
      │
      ▼
 Tableau Dashboard
```

---

## Tech Stack

* **Python**
* **Pandas**
* **NumPy**
* **SQLAlchemy**
* **PostgreSQL**
* **psycopg2**
* **Jupyter Notebook**
* **Matplotlib**
* **Seaborn**
* **SQL**
* **Tableau**
* **Git / GitHub**

---

## Database

The PostgreSQL database contains 14 analytical tables:

| Table                 |    Rows |
| --------------------- | ------: |
| seasons               |      75 |
| circuits              |      77 |
| drivers               |     861 |
| constructors          |     212 |
| status                |     139 |
| races                 |   1,125 |
| results               |  26,759 |
| qualifying            |  10,494 |
| pit_stops             |  11,371 |
| lap_times             | 589,081 |
| sprint_results        |     360 |
| driver_standings      |  34,863 |
| constructor_results   |  12,625 |
| constructor_standings |  13,391 |

The database was validated after ETL.

Foreign-key integrity checks returned **0 orphan records**, and duplicate checks for `lap_times` and `pit_stops` returned **0 duplicates**.

---

## Project Structure

```text
formula1-business-intelligence/
│
├── data/
│   └── raw/
│       └── Formula 1 CSV source data
│
├── dashboard/
│   ├── executive_season_kpis.csv
│   ├── driver_performance.csv
│   ├── constructor_performance.csv
│   ├── race_analysis.csv
│   ├── pit_stop_analysis.csv
│   └── tableau_dashboard_spec.md
│
├── docs/
│   ├── project_specification.md
│   ├── business_questions.md
│   ├── business_question_mapping.md
│   ├── kpi_definition.md
│   ├── data_inventory.md
│   ├── etl.md
│   ├── data_quality_report.md
│   └── data_dictionary.md
│
├── notebooks/
│   └── 01_eda.ipynb
│
├── sql/
│   ├── schema.sql
│   ├── indexes.sql
│   ├── validation.sql
│   └── analytics/
│       └── 21 analytical SQL queries
│
├── src/
│   └── etl/
│       ├── extract.py
│       ├── transform.py
│       ├── load.py
│       ├── logger.py
│       └── pipeline.py
│
├── tableau/
│   └── formula1_business_intelligence.twbx
│
├── requirements.txt
└── README.md
```

---

## Setup

### 1. Clone the repository

```bash
git clone <your-repository-url>
cd formula1-business-intelligence
```

### 2. Create a virtual environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Create PostgreSQL database

Create a database named:

```text
formula1
```

Then create the schema:

```bash
psql -h localhost -p 5432 -U <your_postgres_user> -d formula1 -f sql/schema.sql
```

Optional indexes:

```bash
psql -h localhost -p 5432 -U <your_postgres_user> -d formula1 -f sql/indexes.sql
```

### 5. Configure database variables

Set the environment variables:

```bash
export F1_DB_HOST=localhost
export F1_DB_PORT=5432
export F1_DB_NAME=formula1
export F1_DB_USER=<your_postgres_user>
export F1_DB_PASSWORD=<your_password>
```

For local PostgreSQL installations using passwordless local authentication, `F1_DB_PASSWORD` can be empty.

### 6. Run the ETL pipeline

From the project root:

```bash
python -m src.etl.pipeline
```

The pipeline:

1. reads the raw CSV files;
2. extracts the datasets;
3. converts missing values;
4. normalizes data types;
5. transforms the data;
6. checks data quality;
7. removes exact duplicates;
8. loads the data into PostgreSQL;
9. writes execution information to the ETL log.

---

## Data Validation

Run:

```bash
psql -h localhost -p 5432 -U <your_postgres_user> -d formula1 -f sql/validation.sql
```

The validation layer checks:

* table row counts;
* foreign-key integrity;
* duplicate records;
* primary-key consistency;
* data quality conditions.

The completed project passed the implemented validation checks.

---

## SQL Analytics

The project contains 21 analytical SQL queries in:

```text
sql/analytics/
```

Each query is linked to a specific business question and uses the PostgreSQL analytical layer.

The queries cover:

* driver consistency;
* race performance;
* constructor dominance;
* constructor growth;
* qualifying performance;
* position improvement;
* circuit competitiveness;
* retirement patterns;
* season competitiveness;
* pit-stop strategy proxies;
* season-over-season analysis.

---

## Exploratory Data Analysis

The EDA notebook is located at:

```text
notebooks/01_eda.ipynb
```

It uses Python, Pandas and Matplotlib/Seaborn to explore:

* season-level trends;
* driver performance;
* constructor performance;
* race characteristics;
* recent constructor performance;
* competitive movement.

Run Jupyter with:

```bash
jupyter notebook
```

Then open:

```text
notebooks/01_eda.ipynb
```

---

## Tableau Dashboard

Tableau-ready datasets are available in:

```text
dashboard/
```

The workbook contains analytical views including:

### Executive Overview

* races by season;
* finish rate by season;
* positive position gain;
* unique winners by season.

### Driver Performance

* drivers by points;
* drivers by wins;
* average finishing position.

The Tableau workbook is stored in:

```text
tableau/formula1_business_intelligence.twbx
```

---

## Analytical Limitations

The historical dataset does not contain:

* audience/viewership data;
* commercial revenue;
* telemetry;
* a complete structured record of individual on-track overtakes;
* detailed causal race-strategy information;
* a structured regulation-change dataset.

Therefore, metrics such as:

* position gain;
* competitiveness;
* spectacle;
* overtaking difficulty;
* strategy efficiency;
* regulation-change signals

are treated as **analytical proxies**, not official Formula 1 metrics.

This distinction is important when interpreting the results.

---

## Key Skills Demonstrated

This project demonstrates the ability to:

* build an ETL pipeline in Python;
* work with large relational datasets;
* design a PostgreSQL analytical schema;
* perform data cleaning and validation;
* write analytical SQL;
* translate business questions into KPIs;
* perform exploratory data analysis;
* prepare data for BI tools;
* build Tableau dashboards;
* document analytical methodology and limitations.

---

## Author

**Aknur Orazbai**

Data Analytics / Backend Development

Tools: Python · SQL · PostgreSQL · Pandas · Tableau · Git

