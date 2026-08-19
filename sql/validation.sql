-- Row-count validation
SELECT 'seasons' AS table_name, COUNT(*) FROM seasons
UNION ALL SELECT 'circuits', COUNT(*) FROM circuits
UNION ALL SELECT 'drivers', COUNT(*) FROM drivers
UNION ALL SELECT 'constructors', COUNT(*) FROM constructors
UNION ALL SELECT 'status', COUNT(*) FROM status
UNION ALL SELECT 'races', COUNT(*) FROM races
UNION ALL SELECT 'results', COUNT(*) FROM results
UNION ALL SELECT 'qualifying', COUNT(*) FROM qualifying
UNION ALL SELECT 'lap_times', COUNT(*) FROM lap_times
UNION ALL SELECT 'pit_stops', COUNT(*) FROM pit_stops
UNION ALL SELECT 'driver_standings', COUNT(*) FROM driver_standings
UNION ALL SELECT 'constructor_standings', COUNT(*) FROM constructor_standings
UNION ALL SELECT 'constructor_results', COUNT(*) FROM constructor_results
UNION ALL SELECT 'sprint_results', COUNT(*) FROM sprint_results
ORDER BY table_name;

-- Foreign-key orphan checks. Every query should return zero rows.
SELECT res.race_id
FROM results res LEFT JOIN races r ON r.race_id = res.race_id
WHERE r.race_id IS NULL;

SELECT res.driver_id
FROM results res LEFT JOIN drivers d ON d.driver_id = res.driver_id
WHERE d.driver_id IS NULL;

SELECT res.constructor_id
FROM results res LEFT JOIN constructors c ON c.constructor_id = res.constructor_id
WHERE c.constructor_id IS NULL;

SELECT res.status_id
FROM results res LEFT JOIN status s ON s.status_id = res.status_id
WHERE s.status_id IS NULL;

-- Duplicate business keys.
SELECT race_id, driver_id, lap, COUNT(*)
FROM lap_times
GROUP BY race_id, driver_id, lap
HAVING COUNT(*) > 1;

SELECT race_id, driver_id, stop, COUNT(*)
FROM pit_stops
GROUP BY race_id, driver_id, stop
HAVING COUNT(*) > 1;
