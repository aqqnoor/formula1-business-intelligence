/*
Regulation-change analysis.
Because the dataset does not contain a regulation-event table, the query
compares adjacent seasons and flags large year-over-year changes in core KPIs.
This is a statistical change detector, not causal attribution.
*/
WITH season_kpi AS (
    SELECT
        r.year,
        COUNT(DISTINCT r.race_id) AS races,
        AVG(ABS(res.grid - res.position_order))
            FILTER (WHERE res.grid > 0 AND res.position_order > 0) AS avg_position_movement,
        COUNT(*) FILTER (WHERE res.position_order <= 0 OR res.position IS NULL)::numeric
            / NULLIF(COUNT(*), 0) AS dnf_rate,
        COUNT(DISTINCT res.driver_id) FILTER (WHERE res.position_order = 1) AS unique_winners
    FROM races r
    JOIN results res ON res.race_id = r.race_id
    GROUP BY r.year
),
changes AS (
    SELECT *,
        avg_position_movement - LAG(avg_position_movement) OVER (ORDER BY year) AS movement_change,
        dnf_rate - LAG(dnf_rate) OVER (ORDER BY year) AS dnf_rate_change,
        unique_winners - LAG(unique_winners) OVER (ORDER BY year) AS winners_change
    FROM season_kpi
)
SELECT
    year,
    races,
    ROUND(avg_position_movement, 2) AS avg_position_movement,
    ROUND(dnf_rate * 100, 1) AS dnf_rate_pct,
    unique_winners,
    ROUND(movement_change, 2) AS movement_change,
    ROUND(dnf_rate_change * 100, 1) AS dnf_rate_change_pp,
    winners_change
FROM changes
ORDER BY year;