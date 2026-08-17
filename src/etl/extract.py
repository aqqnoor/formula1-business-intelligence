from pathlib import Path
import pandas as pd

from .logger import logger
def extract(path):

    load_order = [
        "seasons",
        "circuits",
        "drivers",
        "constructors",
        "status",
        "races",
        "constructor_results",
        "constructor_standings",
        "driver_standings",
        "qualifying",
        "results",
        "sprint_results",
        "lap_times",
        "pit_stops"
    ]

    tables = {}

    for table_name in load_order:

        file = Path(path) / f"{table_name}.csv"

        if file.exists():

            df = pd.read_csv(file)

            df.replace("\\N", pd.NA, inplace=True)

            tables[table_name] = df

    return tables