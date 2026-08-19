/*
Proxy for race-strategy efficiency:
average pit-stop duration and finish position for races with at least one stop.
A lower pit duration and stronger finish are preferable, but correlation is not causation.
*/
WITH pit AS (
    SELECT
        race_id,
        driver_id,
        COUNT(*) AS stops,
        AVG(milliseconds) AS avg_stop_ms,
        SUM(milliseconds) AS total_stop_ms
    FROM pit_stops
    GROUP BY race_id, driver_id
)
SELECT
    c.name AS constructor,
    COUNT(*) AS driver_races_with_stops,
    ROUND(AVG(p.stops), 2) AS avg_stops,
    ROUND(AVG(p.avg_stop_ms), 0) AS avg_stop_duration_ms,
    ROUND(AVG(res.position_order) FILTER (WHERE res.position_order > 0), 2) AS avg_finish,
    ROUND(AVG(res.points), 2) AS avg_points
FROM pit p
JOIN results res ON res.race_id = p.race_id AND res.driver_id = p.driver_id
JOIN constructors c ON c.constructor_id = res.constructor_id
GROUP BY c.constructor_id, c.name
HAVING COUNT(*) >= 20
ORDER BY avg_points DESC, avg_stop_duration_ms ASC;
