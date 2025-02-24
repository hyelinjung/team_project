from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse
from io import BytesIO
from PIL import Image
import numpy as np
import tensorflow as tf
import pathlib

#FastAPI 생성
app=FastAPI()

#피부 질환 종류 정의
class_names=['Acne', 'Actinic_Keratosis', 'Benign_tumors','Bullous,Candidiasis,DrugEruption',
             'Eczema','Infestations_Bites', 'Lichen', 'Lupus', 'Moles','Psoriasis','Rosacea',
             'Seborrh_Keratoses', 'SkinCancer', 'Sun_Sunlight_Damage','Tinea','Unknown_Normal'
    ,'Vascular_Tumors', 'Vasculitis', 'Vitiligo', 'Warts']

#학습된 모델 로드
model=tf.keras.models.load_model("skin_disease_classification_model2.h5")
# 모델 컴파일
model.compile(
    optimizer='adam',
    loss=tf.keras.losses.SparseCategoricalCrossentropy(),
    metrics=['accuracy']
)

# 이미지 예측 함수

def predict_image(img):
    # 이미지는 PIL 이미지 객체로 넘어옴 (Gradio에서 전달된 이미지)
    img = img.resize((224, 224))  # 모델에 맞게 이미지 크기 변경
    
    # 이미지를 numpy 배열로 변환하고 정규화
    img_array = np.array(img) / 255.0  # 0~255 -> 0~1로 정규화
    img_array = np.expand_dims(img_array, axis=0)  # 배치 차원 추가 (모델에 맞게)

    # 예측
    predictions = model.predict(img_array)
    
    # 예측된 확률 값 얻기
    class_probabilities = predictions[0]  # 예측된 확률 값 (배열)

    # 상위 3개 클래스와 확률을 얻기 (내림차순 정렬)
    top_3_indices = np.argsort(class_probabilities)[-3:][::-1]  # 확률 내림차순으로 상위 3개 인덱스 얻기
    top_3_classes = [class_names[i] for i in top_3_indices]
    top_3_probabilities = [class_probabilities[i] for i in top_3_indices]
    
    return list(zip(top_3_classes, top_3_probabilities))


def predict_image_with_top_3_classes(img):
    top_3 = predict_image(img)
    result="\n의심되는 피부질환은 다음과 같습니다.\n"
    result += "\n".join([f" {cls}: {prob*100:.2f}%" for cls, prob in top_3])  # 확률을 퍼센트로 출력
    
    return result

@app.post("/imgPredict")
 # 'file' 변수는 클라이언트가 업로드한 파일을 받게 됩니다.
async def predict(file: UploadFile = File(...)):
    try:
        #파일을 바이트로 읽어 PIL 이미지로 변환
       
        img_bytes=await file.read()
        img=Image.open(BytesIO(img_bytes))
        #예측수행
        predictions=predict_image_with_top_3_classes(img)
        
        #예측한 결과 반환
        return JSONResponse(predictions)
    except Exception as e:
        return JSONResponse(status_code=400, content={"error":str(e)})