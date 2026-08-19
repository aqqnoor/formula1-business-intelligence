/* Number of unique race winners in each season. */
SELECT
    r.year,
    COUNT(DISTINCT res.driver_id) FILTER (WHERE res.position_order = 1) AS unique_winners,
    COUNT(*) FILTER (WHERE res.position_order = 1) AS races_with_winner,
    ROUND(
        COUNT(DISTINCT res.driver_id) FILTER (WHERE res.position_order = 1)::numeric
        / NULLIF(COUNT(*) FILTER (WHERE res.position_order = 1), 0) * 100,
        1
    ) AS winner_diversity_vs_races_pct
FROM races r
JOIN results res ON res.race_id = r.race_id
GROUP BY r.year
ORDER BY r.year;
