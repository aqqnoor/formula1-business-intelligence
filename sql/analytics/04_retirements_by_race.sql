/* KPI: DNF count and DNF rate by Grand Prix. */
SELECT
    r.year,
    r.name AS grand_prix,
    COUNT(*) FILTER (WHERE res.grid > 0) AS starters,
    COUNT(*) FILTER (WHERE res.grid > 0 AND res.position IS NULL) AS dnf_count,
    ROUND(
        COUNT(*) FILTER (WHERE res.grid > 0 AND res.position IS NULL)::numeric
        / NULLIF(COUNT(*), 0) * 100, 1
    ) AS dnf_rate_pct
FROM races r
JOIN results res ON res.race_id = r.race_id
GROUP BY r.race_id, r.year, r.name
ORDER BY dnf_rate_pct DESC, dnf_count DESC;