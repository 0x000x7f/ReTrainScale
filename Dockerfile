FROM nvidia/cuda:12.2.0-base-ubuntu22.04

# システム依存パッケージ
RUN apt-get update && apt-get install -y \
    git \
    libgl1-mesa-glx \
    libglib2.0-0 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Python 環境セットアップ
RUN pip3 install --upgrade pip

# 作業ディレクトリ
WORKDIR /app

# モジュールコードをコピー
COPY realesrgan-core/ ./realesrgan-core/

# 依存ライブラリのインストール
COPY realesrgan-core/requirements.txt .
RUN pip install -r requirements.txt

# torchvision APIの変更に対応（必要に応じて）
RUN find /usr/local/lib -type f -name "degradations.py" -exec sed -i \
    's/from torchvision\.transforms\.functional_tensor /from torchvision.transforms.functional /' {} +

# 実行エントリポイント
ENTRYPOINT ["python3", "realesrgan-core/inference_realesrgan.py"]
