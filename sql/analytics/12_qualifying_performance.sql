/* Constructor qualifying effectiveness. */
SELECT
    c.name AS constructor,
    COUNT(*) AS qualifying_starts,
    ROUND(AVG(q.position) FILTER (WHERE q.position > 0), 2) AS avg_qualifying_position,
    COUNT(*) FILTER (WHERE q.position = 1) AS poles,
    ROUND(
        COUNT(*) FILTER (WHERE q.position <= 3)::numeric
        / NULLIF(COUNT(*) FILTER (WHERE q.position > 0), 0) * 100, 1
    ) AS top3_qualifying_rate_pct
FROM qualifying q
JOIN constructors c ON c.constructor_id = q.constructor_id
WHERE q.position > 0
GROUP BY c.constructor_id, c.name
HAVING COUNT(*) >= 20
ORDER BY avg_qualifying_position ASC, poles DESC;
