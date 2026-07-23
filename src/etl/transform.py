import pandas as pd

def convert_types(df):
    data_columns = ["date", "dob", "fp1_date", "fp2_date", "fp3_date", "quali_date", "sprint_date"]

    for col in data_columns:
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
    return df.drop_duplicates()



def transform(df):
    df = convert_types(df)
    df = remove_duplicates(df)


    return df