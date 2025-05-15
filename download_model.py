import urllib.request

url = "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.3.0/RealESRGAN_x4plus.pth"
save_path = "realesrgan-core/weights/RealESRGAN_x4plus.pth"

print("🔽 モデルをダウンロード中...")
urllib.request.urlretrieve(url, save_path)
print("✅ モデルダウンロード完了: " + save_path)
