/*
Overtaking difficulty proxy:
share of classified drivers who did not improve their grid position.
Higher value = fewer positive grid-to-finish gains.
*/
SELECT
    c.name AS circuit,
    c.country,
    COUNT(*) AS classified_starts,
    COUNT(*) FILTER (WHERE res.grid <= res.position_order) AS starts_without_gain,
    ROUND(
        COUNT(*) FILTER (WHERE res.grid <= res.position_order)::numeric
        / NULLIF(COUNT(*), 0) * 100, 1
    ) AS no_gain_rate_pct,
    ROUND(AVG(GREATEST(res.grid - res.position_order, 0)), 2) AS avg_positive_gain
FROM circuits c
JOIN races r ON r.circuit_id = c.circuit_id
JOIN results res ON res.race_id = r.race_id
WHERE res.grid > 0 AND res.position_order > 0
GROUP BY c.circuit_id, c.name, c.country
HAVING COUNT(*) >= 50
ORDER BY no_gain_rate_pct DESC, avg_positive_gain ASC;