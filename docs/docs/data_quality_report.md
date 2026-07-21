## Data Quality Assessment

All datasets were analyzed before transformation.

### General findings

- No duplicate rows were found.
- Missing values represented as `\N` were converted to `NULL` (`pd.NA`).
- Most missing values are expected because of historical Formula 1 data.

### Results table

| Column | Missing % | Notes |
|--------|----------:|------|
| number | 0.02% | Very few missing values. |
| position | 40.93% | Drivers who did not finish the race. |
| time | 71.30% | Available only for some race results. |
| milliseconds | 71.30% | Same as time. |
| fastestLap | 69.16% | Not available for many historical races. |
| rank | 68.20% | Depends on fastest lap data. |
| fastestLapTime | 69.16% | Historical missing values. |
| fastestLapSpeed | 69.16% | Historical missing values. |

No missing values were artificially filled. All meaningful missing values were preserved as NULL.
The results table contains no duplicate rows. Most missing values are expected and reflect the historical nature of the Formula 1 dataset rather than data quality issues. For example, time, milliseconds, fastestLap, fastestLapTime, and fastestLapSpeed are unavailable for many older races or for drivers who did not finish. The position column is also missing for drivers with non-finishing race statuses, while positionText preserves the official race outcome.