/*
Spectacle Score proxy:
positive position movement + DNF activity + lap-time participation.
Weights are transparent and intended for dashboard ranking, not an official FOM metric.
*/
WITH circuit_metrics AS (
    SELECT
        c.circuit_id, c.name AS circuit, c.country,
        COUNT(DISTINCT r.race_id) AS races,
        SUM(GREATEST(res.grid - res.position_order, 0)) AS positive_gain,
        AVG(ABS(res.grid - res.position_order))
            FILTER (WHERE res.grid > 0 AND res.position_order > 0) AS avg_movement,
        COUNT(*) FILTER (WHERE res.position_order <= 0 OR res.position IS NULL) AS dnfs
    FROM circuits c
    JOIN races r ON r.circuit_id = c.circuit_id
    JOIN results res ON res.race_id = r.race_id
    GROUP BY c.circuit_id, c.name, c.country
)
SELECT *,
       ROUND(
         PERCENT_RANK() OVER (ORDER BY positive_gain) * 50 +
         PERCENT_RANK() OVER (ORDER BY avg_movement) * 30 +
         PERCENT_RANK() OVER (ORDER BY dnfs) * 20,
         1
       ) AS spectacle_score
FROM circuit_metrics
WHERE races >= 5
ORDER BY spectacle_score DESC;