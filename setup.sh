 #!/bin/bash

# GanjaGuru Setup Script - Oracle Ready

# ---- Setup Variables ----
PROJECT_NAME="GanjaGuru"
BASE_DIR="$HOME/$PROJECT_NAME"
ENV_FILE="$BASE_DIR/.env"
BASHRC_FILE="$HOME/.bashrc"

echo "🚀 Starting GanjaGuru setup..."

# ---- Create Folder Structure ----
mkdir -p "$BASE_DIR"/{src,models,config,data,public,logs,temp,bin,assets/fonts,assets/images,assets/audio,docs,tests,build,ai,vr,nlp,voice,ecommerce}

# ---- Create Root Files with Actual Content ----
echo "# $PROJECT_NAME" > "$BASE_DIR/README.md"
echo "node_modules/" > "$BASE_DIR/.gitignore"
echo "VIRTUAL_ENV=.venv" >> "$BASE_DIR/.gitignore"

cat <<EOF > "$BASE_DIR/.env"
# 🌿 GanjaGuru .env file
PROJECT_NAME=$PROJECT_NAME
ENV=development
PORT=8080
AI_MODE=true
VR_ENABLED=true
NLP_ENABLED=true
VOICE_ENABLED=true
DATA_TRACKING=true
EOF

cat <<EOF > "$BASE_DIR/config/settings.json"
{
  "app": "GanjaGuru",
  "version": "1.0.0",
  "features": {
    "ai": true,
    "ml": true,
    "llm": true,
    "nlp": true,
    "vr": true,
    "ar": true,
    "voice": true,
    "ecommerce": true,
    "behaviorTracking": true
  }
}
EOF

echo "console.log('🔥 Welcome to GanjaGuru');" > "$BASE_DIR/src/index.js"
echo "print('🌿 GanjaGuru Python module')" > "$BASE_DIR/src/main.py"

# ---- Add Environment Variables to .bashrc ----
if ! grep -q "GANJAGURU_HOME=" "$BASHRC_FILE"; then
  echo "export GANJAGURU_HOME=$BASE_DIR" >> "$BASHRC_FILE"
  echo "export PATH=\$GANJAGURU_HOME/bin:\$PATH" >> "$BASHRC_FILE"
  echo "export PYTHONPATH=\$GANJAGURU_HOME/src" >> "$BASHRC_FILE"
fi

# ---- Install Developer Tools ----
sudo apt update && sudo apt upgrade -y

# Core tools
sudo apt install -y git curl wget build-essential unzip zip

# Node.js & npm
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Python & pip & venv
sudo apt install -y python3 python3-pip python3-venv python3-dev

# ML/AI tools
pip3 install --upgrade pip
pip3 install numpy pandas scikit-learn flask fastapi uvicorn jupyter

# NLP/LLM tools
pip3 install nltk spacy transformers openai

# AR/VR/Voice tools
sudo apt install -y ffmpeg libsm6 libxext6
pip3 install opencv-python pyttsx3 speechrecognition

# E-Commerce / Web / Analytics
npm install express body-parser dotenv mongoose axios cors

# Git init
cd "$BASE_DIR" && git init

# ---- Set Full Permissions ----
chmod -R 777 "$BASE_DIR"

# ---- Done ----
echo "✅ GanjaGuru project structure created at $BASE_DIR"
echo "✅ Dev tools installed: Git, Node.js, Python, AI/ML/NLP, AR/VR, Voice"
echo "✅ Permissions granted (777)"
echo "✅ .env and environment paths configured"

# Load the env
source "$BASHRC_FILE"
