/* Season competitiveness from winner concentration and points spread. */
WITH season_driver AS (
    SELECT
        r.year,
        res.driver_id,
        SUM(res.points) AS points,
        COUNT(*) FILTER (WHERE res.position_order = 1) AS wins
    FROM races r
    JOIN results res ON res.race_id = r.race_id
    GROUP BY r.year, res.driver_id
),
season AS (
    SELECT
        year,
        COUNT(DISTINCT driver_id) AS active_drivers,
        COUNT(*) FILTER (WHERE wins > 0) AS unique_winners,
        MAX(points) AS champion_points,
        MIN(points) AS min_points,
        STDDEV_POP(points) AS points_stddev
    FROM season_driver
    GROUP BY year
)
SELECT
    year,
    active_drivers,
    unique_winners,
    ROUND(champion_points, 1) AS champion_points,
    ROUND(points_stddev, 1) AS points_stddev,
    ROUND(
        unique_winners::numeric / NULLIF(active_drivers, 0) * 100,
        1
    ) AS winner_diversity_pct
FROM season
ORDER BY year;