/* Average grid-to-finish improvement by driver. */
SELECT
    d.forename || ' ' || d.surname AS driver,
    COUNT(*) FILTER (WHERE res.grid > 0 AND res.position_order > 0) AS classified_races,
    ROUND(AVG(res.grid - res.position_order)
          FILTER (WHERE res.grid > 0 AND res.position_order > 0), 2) AS avg_position_gain,
    SUM(GREATEST(res.grid - res.position_order, 0))
          FILTER (WHERE res.grid > 0 AND res.position_order > 0) AS total_positive_gain,
    COUNT(*) FILTER (WHERE res.grid > res.position_order) AS races_with_gain
FROM drivers d
JOIN results res ON res.driver_id = d.driver_id
GROUP BY d.driver_id, d.forename, d.surname
HAVING COUNT(*) FILTER (WHERE res.grid > 0 AND res.position_order > 0) >= 20
ORDER BY avg_position_gain DESC, total_positive_gain DESC;