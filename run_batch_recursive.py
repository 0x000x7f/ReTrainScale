import os
import glob

# 入力と出力のルートディレクトリ
input_root = 'inputs'
output_root = 'results'
model_name = 'RealESRGAN_x4plus'

# 対象画像の拡張子（必要に応じて追加）
exts = ('*.jpg', '*.png', '*.jpeg', '*.JPG', '*.JPEG', '*.PNG')
image_paths = []
for ext in exts:
    image_paths.extend(glob.glob(f'{input_root}/**/{ext}', recursive=True))

# 各画像を処理
for input_path in image_paths:
    rel_path = os.path.relpath(input_path, input_root)
    output_path = os.path.join(output_root, rel_path)

    # 出力先のフォルダを作成
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    # Real-ESRGANコマンドの実行
    cmd = f'python inference_realesrgan.py -n {model_name} -i "{input_path}" -o "{output_path}"'
    print(f'[INFO] Processing: {rel_path}')
    os.system(cmd)
