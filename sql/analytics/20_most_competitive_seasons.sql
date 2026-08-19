/* Rank seasons using unique winners and low championship points concentration. */
WITH winner_counts AS (
    SELECT
        r.year,
        COUNT(DISTINCT res.driver_id) FILTER (WHERE res.position_order = 1) AS unique_winners
    FROM races r
    JOIN results res ON res.race_id = r.race_id
    GROUP BY r.year
),
driver_points AS (
    SELECT r.year, res.driver_id, SUM(res.points) AS points
    FROM races r
    JOIN results res ON res.race_id = r.race_id
    GROUP BY r.year, res.driver_id
),
concentration AS (
    SELECT
        year,
        MAX(points) / NULLIF(SUM(points), 0) AS champion_point_share
    FROM driver_points
    GROUP BY year
)
SELECT
    w.year,
    w.unique_winners,
    ROUND(c.champion_point_share * 100, 1) AS champion_point_share_pct,
    ROUND(
        (PERCENT_RANK() OVER (ORDER BY w.unique_winners) * 0.6 +
         (1 - PERCENT_RANK() OVER (ORDER BY c.champion_point_share)) * 0.4) * 100,
        1
    ) AS competitiveness_index
FROM winner_counts w
JOIN concentration c ON c.year = w.year
ORDER BY competitiveness_index DESC;