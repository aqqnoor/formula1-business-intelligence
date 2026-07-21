from pathlib import Path
import pandas as pd

tables = {}
for file in Path("data/raw").glob("*csv"):
    table_name = file.stem
    df = pd.read_csv(file)
    df.replace("\\N", pd.NA, inplace=True)
    tables[table_name] =df
# races = pd.read_csv("data/raw/races.csv")
# seasons = pd.read_csv("data/raw/seasons.csv")
# circuits = pd.read_csv("data/raw/circuits.csv")
# drivers = pd.read_csv("data/raw/drivers.csv")
# constructors = pd.read_csv("data/raw/constructors.csv")
# status = pd.read_csv("data/raw/status.csv")
# constructor_results = pd.read_csv("data/raw/constructor_results.csv")
# constructor_standings = pd.read_csv("data/raw/constructor_standings.csv")   
# driver_standings = pd.read_csv("data/raw/driver_standings.csv") 
# lap_times = pd.read_csv("data/raw/lap_times.csv")
# pit_stops = pd.read_csv("data/raw/pit_stops.csv")   
# qualifying = pd.read_csv("data/raw/qualifying.csv") 
# results = pd.read_csv("data/raw/results.csv")
# sprint_results = pd.read_csv("data/raw/sprint_results.csv") 


    
def print_df_info(df,name):
    print(df.head())
    print(f"\nname:{name}")

    print("\ninfo")
    df.info()

    print("\nshape")
    print(df.shape)

    print("\ncolumns")
    print(df.columns.tolist())

    print("\nMissing values")
    print(df.isnull().sum())


    print("\nduplicates")
    print(df.duplicated().sum())


    print("\ndescribe")
    print(df.describe(include="all"))

    missing = df.isnull().sum()
    missing_percent = (missing / len(df) *100).round(2)
    print("\nmissing values percentage")
    print(pd.DataFrame({"missing":missing, "missing_percent":missing_percent}))




for df in tables.values():
    df.replace("\\N", pd.NA, inplace=True)


for name, df in tables.items():
    print_df_info(df, name)
