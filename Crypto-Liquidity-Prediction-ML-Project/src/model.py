import joblib

def load_model():
    model = joblib.load('model.pkl')
    return model

def predict(features):
    model = load_model()
    prediction = model.predict([features])
    return