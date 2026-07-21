import pandas as pd

def convert_types(df):
    if "date" in df.columns:
        df["date"] = pd.to_datetime(df["date"])
    if "dob" in df.columns:
        df["dob"] = pd.to_datetime(df["dob"])
    
    if "number" in df.columns:
        df["number"] = df["number"].astype("Int64")

    return df
    

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