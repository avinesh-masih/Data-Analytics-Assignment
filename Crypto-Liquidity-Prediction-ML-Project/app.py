import streamlit as st
import joblib
import numpy as np

# Load model
model_path = r"C:\Users\ACER\OneDrive\Documents\my codess\Data-Analytics-Assignment\Crypto-Liquidity-Prediction-ML-Project\outputs\models\crypto_liquidity_rf_model.pkl"
model = joblib.load(model_path)

# Page configuration
st.set_page_config(page_title="Cryptocurrency Liquidity Prediction for Market Stability", page_icon="💧", layout="centered")

# ==============================
# Author Info & Social Links
# ==============================
with st.container():
    col1, col2 = st.columns([1, 5])
    with col1:
        st.image("https://avatars.githubusercontent.com/u/82111001?v=4", width=80)
    with col2:
        st.markdown("""
        ### 👨‍💻 Developed by AVINESH MASIH
        **Data Analyst & ML Enthusiast**

       [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/avineshlko/)  [![Portfolio](https://img.shields.io/badge/Portfolio-000000?style=for-the-badge&logo=githubpages&logoColor=white)](https://avinesh-masih.github.io/)  [![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:skmasih11@gmail.com)  [![PayPal](https://img.shields.io/badge/PayPal-009CDE?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/AVINESHMASIH)  [![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/avineshlko)
        """, unsafe_allow_html=True)

# =====================
# App Title & Intro
# =====================
st.markdown("---")
st.markdown("""
<div style="text-align: center;">
    <h1 style="color: #2e7bcf;">💧 Crypto Liquidity Predictor</h1>
    <p style="font-size: 1.1rem;">Predict the liquidity ratio of a cryptocurrency using market metrics</p>
</div>
""", unsafe_allow_html=True)

# ===================
# Input Form
# ===================
st.markdown("### 📥 Enter Market Data")

col1, col2 = st.columns(2)

with col1:
    price = st.number_input('💰 Price (USD)', min_value=0.0, value=50000.0, step=100.0)
    market_cap = st.number_input('🏦 Market Cap (USD)', min_value=0.0, value=1_000_000_000.0, step=1000000.0)

with col2:
    volume_24h = st.number_input('📈 24h Volume (USD)', min_value=0.0, value=100_000_000.0, step=100000.0)
    returns = st.number_input('📊 Returns (%)', value=0.5, step=0.1)

# ==================
# Prediction
# ==================
st.markdown("---")
volatility = abs(returns)

if st.button("🚀 Predict Liquidity Ratio"):
    try:
        input_data = np.array([[price, volume_24h, market_cap, volatility]])
        prediction = model.predict(input_data)[0]
        st.success(f"✅ Predicted Liquidity Ratio: **{prediction:.6f}**")
    except Exception as e:
        st.error(f"❌ Error occurred during prediction: {str(e)}")

# ======================
# Footer / Credits
# ======================
st.markdown("---")
st.markdown(
    """
   <div style='text-align: center; color: gray; font-size: 0.9rem;'>
        Built by <a href="https://github.com/avinesh-masih" target="_blank" style="color: #2e7bcf; text-decoration: none;">Avinesh</a> ❤️ using Streamlit | © 2025 AVINESH MASIH
    </div>
    """,
    unsafe_allow_html=True
)
