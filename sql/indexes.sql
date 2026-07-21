CREATE INDEX idx_results_race
ON results(race_id);

CREATE INDEX idx_results_driver
ON results(driver_id);

CREATE INDEX idx_results_constructor
ON results(constructor_id);

CREATE INDEX idx_races_year
ON races(year);

CREATE INDEX idx_races_circuit
ON races(circuit_id);

CREATE INDEX idx_lap_times_driver
ON lap_times(driver_id);