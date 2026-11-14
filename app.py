import streamlit as st
import pandas as pd
import psycopg2

st.title("Titanic Dataset Analysis")

conn = psycopg2.connect(
    host=st.secrets["db"]["host"],
    port=st.secrets["db"]["port"],
    database=st.secrets["db"]["dbname"],
    user=st.secrets["db"]["user"],
    password=st.secrets["db"]["password"]
)

query = "SELECT * FROM titanic_project.passengers"

df = pd.read_sql(query, conn)

st.subheader("Titanic Passenger Data")
st.write(df)

st.subheader("Total Passengers")
st.write(len(df))

st.subheader("Passenger Details")
st.write(df.head(10))

st.subheader("Survival Count")
st.bar_chart(df["survived"].value_counts())

st.subheader("Passengers by Gender")
st.bar_chart(df["sex"].value_counts())

st.subheader("Passengers by Class")
st.bar_chart(df["pclass"].value_counts())

conn.close()