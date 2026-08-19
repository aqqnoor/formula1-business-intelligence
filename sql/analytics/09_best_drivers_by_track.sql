/* Circuit performance: wins, podiums, points and average finish. */
SELECT
    c.name AS circuit,
    c.country,
    d.forename || ' ' || d.surname AS driver,
    COUNT(*) AS starts,
    COUNT(*) FILTER (WHERE res.position_order = 1) AS wins,
    COUNT(*) FILTER (WHERE res.position_order BETWEEN 1 AND 3) AS podiums,
    ROUND(SUM(res.points), 1) AS points,
    ROUND(AVG(res.position_order) FILTER (WHERE res.position_order > 0), 2) AS avg_finish
FROM circuits c
JOIN races r ON r.circuit_id = c.circuit_id
JOIN results res ON res.race_id = r.race_id
JOIN drivers d ON d.driver_id = res.driver_id
GROUP BY c.circuit_id, c.name, c.country, d.driver_id, d.forename, d.surname
HAVING COUNT(*) >= 3
ORDER BY c.name, points DESC, podiums DESC;
