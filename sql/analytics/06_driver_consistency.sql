/* KPI: mean finish, standard deviation, and Top-10 rate. */
SELECT
    d.driver_id,
    d.forename || ' ' || d.surname AS driver,
    COUNT(*) AS races,
    ROUND(AVG(res.position_order) FILTER (WHERE res.position_order > 0), 2) AS avg_finish,
    ROUND(STDDEV_POP(res.position_order) FILTER (WHERE res.position_order > 0), 2) AS finish_stddev,
    ROUND(
        COUNT(*) FILTER (WHERE res.position_order BETWEEN 1 AND 10)::numeric
        / NULLIF(COUNT(*) FILTER (WHERE res.position_order > 0), 0) * 100, 1
    ) AS top10_rate_pct
FROM drivers d
JOIN results res ON res.driver_id = d.driver_id
GROUP BY d.driver_id, d.forename, d.surname
HAVING COUNT(*) FILTER (WHERE res.position_order > 0) >= 20
ORDER BY top10_rate_pct DESC, finish_stddev ASC, avg_finish ASC;