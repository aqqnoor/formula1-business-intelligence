
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError

from .logger import logger

# Подключение к PostgreSQL

engine = create_engine(
    "postgresql+psycopg2://aqqnoor@localhost:5432/formula1"
)

def load(df, table_name):

    try:

        with engine.begin() as conn:

            conn.execute(
                text(f"TRUNCATE TABLE {table_name} RESTART IDENTITY CASCADE")
            )

        df.to_sql(
            table_name,
            engine,
            index=False,
            if_exists="append",
            chunksize=1,
            method=None
        )

    except SQLAlchemyError as error:
        logger.error(f"Ошибка при загрузке таблицы '{table_name}'")

        if hasattr(error, "orig"):
            logger.error(error.orig)
        else:
            logger.error(error)

        raise