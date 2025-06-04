from flask import Flask,request,jsonify
from flask_cors import CORS
import numpy as np
import joblib

app=Flask(__name__)
CORS(app)

model=joblib.load('model_toyota.pkl')
scaler=joblib.load('scaler_toyota.pkl')
encoder=joblib.load('encoder_toyota.pkl')

@app.route('/predict',methods=['POST'])
def predict():
    try:
        data=request.json
        input_user=np.array(data['input']).reshape(1,-1)
        input_user_scaled=scaler.transform(input_user)
        predict=model.predict(input_user_scaled)

        return jsonify({
            'Prediction':predict[0]
        })
    except Exception as e:
        return jsonify({
            'msg':str(e)
        }),400
    
if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000,debug=True)
