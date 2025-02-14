import pandas as pd
import torch
import os
from transformers import AutoModelForCausalLM, AutoTokenizer
from datasets import Dataset
from torch.utils.data import DataLoader
from huggingface_hub import login
from tqdm import tqdm

# ✅ Hugging Face 로그인
huggingface_token = os.getenv("HUGGINGFACE_TOKEN")
login(token=huggingface_token)

# ✅ 모델 및 토크나이저 로드
model_name = "google/gemma-2b"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name)

# ✅ Mac OS에서 적절한 디바이스 선택
device = torch.device("mps") if torch.backends.mps.is_available() else (
    torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")
)
print(f"🔹 Using device: {device}")
model.to(device)

# ✅ CSV 데이터 로드
try:
    df = pd.read_csv("guideChatbot.csv")
    print("🔹 CSV 데이터 로드 완료!")
    print(df.head())

    # ✅ 질문-답변 포맷팅
    df["formatted_text"] = df.apply(lambda row: f"[Q] {row['inputs']} [A] {row['response']}", axis=1)

    # ✅ Dataset 변환
    dataset = Dataset.from_pandas(df[["formatted_text"]])

    # ✅ 토크나이징 함수 (개선됨)
    def tokenize_function(examples):
        tokenized = tokenizer(
            examples["formatted_text"],
            padding="max_length",
            truncation=True,
            max_length=128  # ✅ max_length 줄임
        )
        tokenized["labels"] = tokenized["input_ids"].copy()
        return tokenized

    # ✅ 데이터 토크나이징 적용
    tokenized_datasets = dataset.map(tokenize_function, batched=True, remove_columns=["formatted_text"])

    # ✅ 데이터셋을 학습용(train)과 검증용(eval)으로 분리
    split_data = tokenized_datasets.train_test_split(test_size=0.2)
    train_dataset = split_data["train"]
    eval_dataset = split_data["test"]

    print(f"🔹 학습 데이터셋 크기: {len(train_dataset)}")
    print(f"🔹 검증 데이터셋 크기: {len(eval_dataset)}")

    # ✅ PyTorch DataLoader 생성
    def collate_fn(batch):
        collated_batch = {key: torch.tensor([b[key] for b in batch], dtype=torch.long) for key in batch[0]}
        return collated_batch

    train_dataloader = DataLoader(train_dataset, batch_size=8, shuffle=True, collate_fn=collate_fn)  # ✅ batch_size 증가
    eval_dataloader = DataLoader(eval_dataset, batch_size=8, collate_fn=collate_fn)

    # ✅ 옵티마이저 설정 (학습률 감소)
    optimizer = torch.optim.AdamW(model.parameters(), lr=2e-5)  # ✅ lr=2e-5 로 조정

    # ✅ 학습 루프
    num_epochs = 1
    model.train()
    for epoch in range(num_epochs):
        print(f"\n🔹 Epoch {epoch+1}/{num_epochs} 시작...")
        total_loss = 0
        progress_bar = tqdm(train_dataloader, desc=f"Epoch {epoch+1}", leave=False)

        for batch in progress_bar:
            inputs = {k: v.to(device) for k, v in batch.items()}
            outputs = model(**inputs)
            loss = outputs.loss
            loss.backward()
            optimizer.step()
            optimizer.zero_grad()
            total_loss += loss.item()
            progress_bar.set_postfix({"Batch Loss": loss.item()})

        avg_loss = total_loss / len(train_dataloader)
        print(f"✅ Epoch {epoch+1}/{num_epochs} 완료, 평균 손실(loss): {avg_loss:.4f}")

    print("\n✅ Fine-Tuning 완료!")

    # ✅ 모델 저장
    model.save_pretrained("./gemma-finetuned")
    tokenizer.save_pretrained("./gemma-finetuned")
    print("✅ 모델 저장 완료!")

    # ✅ 모델 테스트
    model.eval()
    test_input = "회원가입 어디서 해?"
    inputs = tokenizer(test_input, return_tensors="pt").to(device)
    with torch.no_grad():
        outputs = model.generate(**inputs, max_length=50)
        generated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)
    print("🔹 모델 출력:", generated_text)

except Exception as e:
    print(f"❌ 학습 오류 발생: {e}")