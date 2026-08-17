import re
import pandas as pd
from .logger import logger

PRIMARY_KEYS = {
    "drivers": "driver_id",
    "constructors": "constructor_id",
    "circuits": "circuit_id",
    "races": "race_id",
    "results": "result_id",
    "qualifying": "qualify_id",
    "status": "status_id",
    "driver_standings": "driver_standings_id",
    "constructor_results": "constructor_results_id",
    "constructor_standings": "constructor_standings_id",
    "sprint_results": "result_id",
}
def camel_to_snake(name):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()


def convert_types(df):

    date_columns = [
        "date",
        "dob",
        "fp1_date",
        "fp2_date",
        "fp3_date",
        "quali_date",
        "sprint_date"
    ]

    for col in date_columns:
        if col in df.columns:
            df[col] = pd.to_datetime(df[col], errors="coerce")

    if "number" in df.columns:
        df["number"] = pd.to_numeric(df["number"], errors="coerce").astype("Int64")

    if "points" in df.columns:
        df["points"] = pd.to_numeric(df["points"], errors="coerce").astype("Float64")

    if "position" in df.columns:
        df["position"] = pd.to_numeric(df["position"], errors="coerce").astype("Int64")

    if "rank" in df.columns:
        df["rank"] = pd.to_numeric(df["rank"], errors="coerce").astype("Int64")

    if "laps" in df.columns:
        df["laps"] = pd.to_numeric(df["laps"], errors="coerce").astype("Int64")




    return df


def remove_duplicates(df):

    before = len(df)

    df = df.drop_duplicates()

    duplicates_removed = before - len(df)

    return df, duplicates_removed


def check_missing(df):

    missing = df.isnull().sum()

    return missing[missing > 0]


def validate_primary_key(df, key):

    if key in df.columns:

        duplicates = df[key].duplicated().sum()

        if duplicates > 0:
            logger.warning(f"{key}: найдено {duplicates} дубликатов")
        else:
            logger.info(f"{key}: дубликатов не найдено")

    return df


def validate_positive(df, columns):

    for col in columns:

        if col in df.columns:

            errors = (df[col] < 0).sum()

            if errors > 0:
                logger.warning(f"{col}: найдено {errors} отрицательных значений")

    return df


def transform(df, table_name):

    df = convert_types(df)

    df, duplicates_removed = remove_duplicates(df)

    # Преобразование названий столбцов в snake_case
    df.columns = [camel_to_snake(col) for col in df.columns]

    # Переименование столбцов, которые отличаются от схемы БД
    df.rename(columns={
        "time": "race_time",
        "rank": "fastest_lap_rank"
    }, inplace=True)

    missing = check_missing(df)

    pk = PRIMARY_KEYS.get(table_name)

    if pk and pk in df.columns:
        validate_primary_key(df, pk)

    validate_positive(
        df,
        ["points", "laps"]
    )

    return df, duplicates_removed, missing