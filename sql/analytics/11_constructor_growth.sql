/* Season-over-season constructor points growth. */
WITH season_points AS (
    SELECT r.year, c.constructor_id, c.name AS constructor, SUM(res.points) AS points
    FROM races r
    JOIN results res ON res.race_id = r.race_id
    JOIN constructors c ON c.constructor_id = res.constructor_id
    GROUP BY r.year, c.constructor_id, c.name
)
SELECT
    year,
    constructor,
    ROUND(points, 1) AS points,
    ROUND(points - LAG(points) OVER (PARTITION BY constructor_id ORDER BY year), 1) AS points_change,
    ROUND(
        (points - LAG(points) OVER (PARTITION BY constructor_id ORDER BY year))
        / NULLIF(LAG(points) OVER (PARTITION BY constructor_id ORDER BY year), 0) * 100,
        1
    ) AS growth_pct
FROM season_points
ORDER BY constructor, year;