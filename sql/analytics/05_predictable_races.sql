/*
KPI: Predictability Index.
Components: pole-to-win indicator + Top-3 stability from grid to finish.
*/
WITH race AS (
    SELECT
        r.race_id, r.year, r.name,
        MAX(res.position_order) FILTER (WHERE res.position_order = 1) IS NOT NULL AS has_winner,
        MAX(res.grid) FILTER (WHERE res.position_order = 1) AS winner_grid,
        AVG(ABS(res.grid - res.position_order))
            FILTER (WHERE res.position_order <= 3 AND res.grid > 0) AS top3_movement
    FROM races r
    JOIN results res ON res.race_id = r.race_id
    GROUP BY r.race_id, r.year, r.name
)
SELECT
    year,
    name AS grand_prix,
    winner_grid,
    ROUND(top3_movement, 2) AS avg_top3_position_movement,
    CASE WHEN winner_grid = 1 THEN 1 ELSE 0 END AS pole_to_win,
    ROUND(
        ((CASE WHEN winner_grid = 1 THEN 1 ELSE 0 END) * 0.6 +
         (1 - LEAST(COALESCE(top3_movement, 3), 3) / 3.0) * 0.4) * 100,
        1
    ) AS predictability_index
FROM race
ORDER BY predictability_index DESC, year DESC;