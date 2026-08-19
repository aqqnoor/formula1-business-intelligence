# Tableau Dashboard Specification

## 1. Executive Overview

**Purpose:** answer "How is Formula 1 performance changing?"

### KPI cards
- Number of races
- Unique winners
- Finish rate
- Total positive position gain

### Main views
- Season competitiveness trend
- Unique winners by season
- Top 10 Grand Prix by position gain
- DNF rate by season

### Filters
- Year
- Circuit
- Country

---

## 2. Driver Performance

**Purpose:** compare drivers.

### Views
- Top drivers by wins
- Top drivers by podiums
- Average finish vs. finish consistency
- Average position gain
- Top-10 rate

### Filters
- Season
- Driver
- Constructor

---

## 3. Constructor Performance

**Purpose:** evaluate constructor performance over time.

### Views
- Constructor points by season
- Wins and podiums
- Season-over-season growth
- Qualifying effectiveness

### Filters
- Season
- Constructor

---

## 4. Race & Circuit Analysis

**Purpose:** evaluate Grand Prix and circuit characteristics.

### Views
- Position gain by race
- DNF rate by circuit
- Predictability index
- Circuit competitiveness
- Circuit spectacle proxy

### Filters
- Season
- Circuit
- Country

---

## 5. Pit Stop Analysis

**Purpose:** provide a descriptive strategy view.

### Views
- Average pit-stop duration by constructor
- Stops per driver-race
- Average finish for races with pit stops
- Average points for races with pit stops

### Important note

The pit-stop view is descriptive. It must not claim that shorter pit stops cause better race results without additional causal analysis.
