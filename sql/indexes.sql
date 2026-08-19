CREATE INDEX IF NOT EXISTS idx_races_year ON races(year);
CREATE INDEX IF NOT EXISTS idx_races_circuit ON races(circuit_id);

CREATE INDEX IF NOT EXISTS idx_results_race ON results(race_id);
CREATE INDEX IF NOT EXISTS idx_results_driver ON results(driver_id);
CREATE INDEX IF NOT EXISTS idx_results_constructor ON results(constructor_id);
CREATE INDEX IF NOT EXISTS idx_results_position_order ON results(position_order);

CREATE INDEX IF NOT EXISTS idx_qualifying_race ON qualifying(race_id);
CREATE INDEX IF NOT EXISTS idx_qualifying_constructor ON qualifying(constructor_id);

CREATE INDEX IF NOT EXISTS idx_lap_times_driver ON lap_times(driver_id);
CREATE INDEX IF NOT EXISTS idx_lap_times_race ON lap_times(race_id);

CREATE INDEX IF NOT EXISTS idx_pit_stops_driver ON pit_stops(driver_id);
CREATE INDEX IF NOT EXISTS idx_pit_stops_race ON pit_stops(race_id);

CREATE INDEX IF NOT EXISTS idx_driver_standings_race_driver
    ON driver_standings(race_id, driver_id);

CREATE INDEX IF NOT EXISTS idx_constructor_standings_race_constructor
    ON constructor_standings(race_id, constructor_id);
