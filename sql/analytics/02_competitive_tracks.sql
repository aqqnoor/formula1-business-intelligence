/*
Business question: Which circuits are the most competitive?
KPI: Average Position Gain (proxy for on-track competitiveness).
Higher movement means more positions changed between grid and finish.
*/
SELECT
    c.name AS circuit,
    c.country,
    COUNT(DISTINCT r.race_id) AS number_of_races,
    ROUND(AVG(GREATEST(res.grid - res.position_order, 0)), 2) AS avg_positive_position_gain,
    ROUND(AVG(ABS(res.grid - res.position_order)), 2) AS avg_position_movement,
    COUNT(*) FILTER (WHERE res.grid > 0 AND res.position_order > 0
                     AND res.grid <> res.position_order) AS changed_positions
FROM circuits c
JOIN races r ON r.circuit_id = c.circuit_id
JOIN results res ON res.race_id = r.race_id
WHERE res.grid > 0 AND res.position_order > 0
GROUP BY c.circuit_id, c.name, c.country
HAVING COUNT(DISTINCT r.race_id) >= 5
ORDER BY avg_position_movement DESC, number_of_races DESC;
