/* Stability proxy: standard deviation of finishing position by circuit. */
SELECT
    c.name AS circuit,
    c.country,
    COUNT(*) AS classified_starts,
    ROUND(AVG(res.position_order), 2) AS avg_finish,
    ROUND(STDDEV_POP(res.position_order), 2) AS finish_position_stddev,
    ROUND(
        COUNT(*) FILTER (WHERE res.position_order <= 3)::numeric
        / NULLIF(COUNT(*), 0) * 100, 1
    ) AS podium_rate_pct
FROM circuits c
JOIN races r ON r.circuit_id = c.circuit_id
JOIN results res ON res.race_id = r.race_id
WHERE res.position_order > 0
GROUP BY c.circuit_id, c.name, c.country
HAVING COUNT(*) >= 50
ORDER BY finish_position_stddev ASC, podium_rate_pct DESC;