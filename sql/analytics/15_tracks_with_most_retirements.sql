/* Circuit DNF rate across all available races. */
SELECT
    c.name AS circuit,
    c.country,
    COUNT(*) FILTER (WHERE res.grid > 0) AS starts,
    COUNT(*) FILTER (WHERE res.grid > 0 AND res.position IS NULL) AS dnfs,
    ROUND(
        COUNT(*) FILTER (WHERE res.grid > 0 AND res.position IS NULL)::numeric
        / NULLIF(COUNT(*), 0) * 100, 1
    ) AS dnf_rate_pct
FROM circuits c
JOIN races r ON r.circuit_id = c.circuit_id
JOIN results res ON res.race_id = r.race_id
GROUP BY c.circuit_id, c.name, c.country
HAVING COUNT(*) >= 50
ORDER BY dnf_rate_pct DESC, dnfs DESC;
