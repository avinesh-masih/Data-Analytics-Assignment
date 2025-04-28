def engineer_features(data):
    # Feature Engineering
    data['moving_average'] = data['price'].rolling(window=5).mean()
    data['volatility'] = data['price'].rolling(window=5).std()
    data['liquidity_ratio'] = data['volume'] / data['market_cap']  # Assuming 'market_cap' is a column
    return data