import pandas as pd

def convert_types(df):
    if "date" in df.columns:
        df["date"] = pd.to_datetime(df["date"], errors="coerce")
    if "dob" in df.columns:
        df["dob"] = pd.to_datetime(df["dob"], errors="coerce")
    if "fp1_date" in df.columns:
        df["fp1_date"] = df["fp1_date"].to_datetime("datetime64[ns]", errors="coerce")

    if "fp2_date" in df.columns:
        df["fp2_date"] = df["fp2_date"].to_datetime("datetime64[ns]", errors="coerce")
    if "fp3_date" in df.columns:
        df["fp3_date"] = df["fp3_date"].to_datetime("datetime64[ns]", errors="coerce")
    if "quali_date" in df.columns:
        df["quali_date"] = df["quali_date"].to_datetime("datetime64[ns]", errors="coerce")
    if "sprint_date" in df.columns:
        df["sprint_date"] = df["sprint_date"].to_datetime("datetime64[ns]", errors="coerce")

    return df
    

    if "number" in df.columns:
        df["number"] = df["number"].to_datetime("Int64", errors="coerce")

    if "points" in df.columns:
        df["points"] = df["points"].to_datetime(float, errors="coerce")


def handle_missing(df):
    df = df.dropna(subset=["date", "dob"])
    return df

def remove_duplicates(df):
    return df.drop_duplicates()

def clean_text(df):
    df["name"] = df["name"].str.strip().str.title()
    return df
def validate_date(df):
    df = df[df["date"] >= df["dob"]]
    
    return df

def transform(df):
    df = convert_types(df)
    df = handle_missing(df)
    df = remove_duplicates(df)
    df = clean_text(df)
    df = validate_date(df)
    return df