from pathlib import Path

from .extract import extract
from .transform import transform
from .load import load
from .logger import logger, report


def main():
    try:
        base_dir = Path(__file__).resolve().parents[2]
        data_path = base_dir / "data" / "raw"

        tables = extract(data_path)

        for table_name, df in tables.items():
            try:
                logger.info(f"Processing {table_name}")

                before = len(df)

                df, duplicates_removed, missing = transform(df, table_name)

                after = len(df)

                report(
                    table_name,
                    before,
                    after,
                    duplicates_removed,
                    missing
                )

                load(df, table_name)

                logger.info(f"{table_name} completed")

            except Exception:
                logger.exception(
                    f"Failed while processing table '{table_name}'"
                )

        logger.info("ETL finished.")

    except Exception:
        logger.exception("Pipeline failed completely")


if __name__ == "__main__":
    main()