import logging
from pathlib import Path

Path("logs").mkdir(exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format="%(message)s",
    handlers=[
        logging.FileHandler("logs/etl.log"),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)


def report(
    table_name,
    before,
    after,
    duplicates_removed,
    missing_values,
):

    logger.info("=" * 60)
    logger.info(f"TABLE: {table_name}\n")

    logger.info(f"Rows before:        {before}")
    logger.info(f"Rows after:         {after}")
    logger.info(f"Duplicates removed: {duplicates_removed}")

    logger.info("\nMissing values:")

    if missing_values.empty:
        logger.info("None")
    else:
        for column, value in missing_values.items():
            logger.info(f"{column:<20}{value}")

    logger.info("\nStatus: SUCCESS")
    logger.info("=" * 60)