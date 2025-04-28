import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
import joblib
from data_preprocessing import load_data, preprocess_data
from feature_engineering import engineer_features

def train_model(price_file):
    data = load_data(price_file)
    data = preprocess_data(data)
    data = engineer_features(data)

    X = data[['moving_average', 'volatility', 'liquidity_ratio']]  # Features
    y = data['liquidity']  # Target variable (ensure this column exists)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    model = RandomForestRegressor()
    model.fit(X_train, y_train)

    # Predictions
    y_pred = model.predict(X_test)

    # Evaluation metrics
    print("RMSE:", mean_squared_error(y_test, y_pred, squared=False))
    print("MAE:", mean_absolute_error(y_test, y_pred))
    print("R2 Score:", r2_score(y_test, y_pred))

    # Save the model
    joblib.dump(model, 'model.pkl')

if __name__ == "__main__":
    train_model('data/coin_gecko_2022-03-16.csv')