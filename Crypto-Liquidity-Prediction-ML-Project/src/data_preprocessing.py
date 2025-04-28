import pandas as pd
from sklearn.preprocessing import MinMaxScaler

def load_data(price_file):
    # Load the dataset
    data = pd.read_csv(price_file)
    return data

def preprocess_data(data):
    # Handle missing values
    data.fillna(method='ffill', inplace=True)

    # Normalize numerical features
    scaler = MinMaxScaler()
    numerical_features = ['price', 'volume']  # Replace with actual column names
    data[numerical_features] = scaler.fit_transform(data[numerical_features])
    
    return data