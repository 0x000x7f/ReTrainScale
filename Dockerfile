FROM python:3.10-slim

# システム依存パッケージ
RUN apt-get update && apt-get install -y \
    git \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリ
WORKDIR /app

# ファイルコピー
COPY realesrgan-core/ ./realesrgan-core/

# パッケージインストール
COPY realesrgan-core/requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# torchvisionのAPI変更に対応（互換性維持）
RUN find /usr/local/lib -type f -name "degradations.py" -exec sed -i \
    's/from torchvision\.transforms\.functional_tensor /from torchvision.transforms.functional /' {} +

# エントリポイント（可変引数受け取り対応）
ENTRYPOINT ["python", "realesrgan-core/inference_realesrgan.py"]
