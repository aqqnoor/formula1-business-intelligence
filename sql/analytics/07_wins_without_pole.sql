/* Wins achieved from a starting grid position other than P1. */
SELECT
    d.forename || ' ' || d.surname AS driver,
    COUNT(*) FILTER (WHERE res.position_order = 1 AND res.grid > 1) AS wins_without_pole,
    COUNT(*) FILTER (WHERE res.position_order = 1) AS total_wins,
    ROUND(
        COUNT(*) FILTER (WHERE res.position_order = 1 AND res.grid > 1)::numeric
        / NULLIF(COUNT(*) FILTER (WHERE res.position_order = 1), 0) * 100, 1
    ) AS pct_wins_without_pole
FROM drivers d
JOIN results res ON res.driver_id = d.driver_id
GROUP BY d.driver_id, d.forename, d.surname
HAVING COUNT(*) FILTER (WHERE res.position_order = 1) > 0
ORDER BY wins_without_pole DESC, total_wins DESC;