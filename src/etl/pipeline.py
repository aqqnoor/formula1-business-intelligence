from src.etl.extract import extract
from src.etl.transform import transform
from src.etl.logger import report
from src.etl.load import load
tables = extract("data/raw")

for name, df in tables.items():

    before = len(df)

    df, duplicates_removed, missing = transform(df)

    after = len(df)

    report(
        table_name=name,
        before=before,
        after=after,
        duplicates_removed=duplicates_removed,
        missing_values=missing
    )
    load(df, name)