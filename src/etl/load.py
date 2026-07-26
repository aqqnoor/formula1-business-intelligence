import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError
from .logger import logger

# Подключение к PostgreSQL
engine = create_engine(
    "postgresql+psycopg2://postgres:aqqnoor2005@localhost:5433/formula1"
)


def load(df, table_name):
    """
    Загружает DataFrame в PostgreSQL.
    """

    try:

        logger.info(f"Loading table: {table_name}")

        df.to_sql(
            name=table_name,
            con=engine,
            if_exists="append",
            index=False,
            chunksize=1000,
            method="multi"
        )

        

        logger.info(f"{table_name} loaded successfully")

    except SQLAlchemyError as error:

        logger.error(f"Error while loading {table_name}")
        logger.error(error)

        raise