/* Constructor dominance by season. */
WITH season_team AS (
    SELECT
        r.year,
        c.name AS constructor,
        SUM(res.points) AS points,
        COUNT(*) FILTER (WHERE res.position_order = 1) AS wins,
        COUNT(*) FILTER (WHERE res.position_order BETWEEN 1 AND 3) AS podiums
    FROM races r
    JOIN results res ON res.race_id = r.race_id
    JOIN constructors c ON c.constructor_id = res.constructor_id
    GROUP BY r.year, c.constructor_id, c.name
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY year ORDER BY points DESC) AS season_rank,
           MAX(points) OVER (PARTITION BY year) AS leader_points
    FROM season_team
)
SELECT
    year,
    constructor,
    ROUND(points, 1) AS points,
    wins,
    podiums,
    season_rank,
    ROUND(points / NULLIF(leader_points, 0) * 100, 1) AS dominance_vs_leader_pct
FROM ranked
WHERE season_rank <= 5
ORDER BY year DESC, season_rank;
