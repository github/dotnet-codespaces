#!/bin/bash

set -e

# --- GanjaGuru Training Suite Setup ---
echo "🚀 Setting up GanjaGuru training suite..."

BASE_DIR="$HOME/ganjaguru/training"
mkdir -p "$BASE_DIR"

FILES=(
    "intents.json"
    "stories.md"
    "responses.yml"
    "domain.yml"
    "nlu.yml"
    "rules.yml"
    "forms.yml"
    "entities.json"
    "slots.json"
    "lookup_tables.json"
    "synonyms.json"
    "example_chats.md"
    "prompts.yml"
    "conversation_flows.md"
    "utterances.json"
    "training_data.md"
    "context_examples.json"
    "fallback_patterns.yml"
    "dialogue_patterns.md"
    "mood_templates.yml"
    "question_templates.yml"
    "story_graph.json"
    # --- More advanced files ---
    "weather_forecast_training.json"
    "cannabis_strain_training.json"
    "dispensary_training.json"
    "law_training.json"
    "product_suggestion_training.json"
    "grow_advice_training.json"
    "event_training.json"
    "wellness_training.json"
    "news_training.json"
    "recipe_training.json"
    "review_training.json"
    "history_training.json"
    "slang_training.json"
    "science_training.json"
    "faq_examples.md"
    "test_cases.yml"
    "README.md"
    "setup_instructions.md"
    "data_schema.json"
    "metrics.json"
    "changelog.md"
)

for FILE in "${FILES[@]}"; do
    if [ ! -f "$BASE_DIR/$FILE" ]; then
        touch "$BASE_DIR/$FILE"
        echo "🌿 Created $FILE"
    else
        echo "⚡ $FILE already exists"
    fi
    chmod 666 "$BASE_DIR/$FILE"
done

chmod 777 "$BASE_DIR"

# --- Install recommended tools ---
echo "🔧 Installing recommended tools (jq, yq, tree, python3-pip, virtualenv, git-lfs)..."
sudo apt-get update
sudo apt-get install -y jq tree python3-pip git-lfs
pip3 install --user yq virtualenv

git lfs install || true

echo "📦 Exporting environment variables..."

if ! grep -q "GANJAGURU_HOME" ~/.bashrc; then
    echo "export GANJAGURU_HOME=\$HOME/ganjaguru" >> ~/.bashrc
fi
if ! grep -q "TRAINING_DIR" ~/.bashrc; then
    echo "export TRAINING_DIR=\$HOME/ganjaguru/training" >> ~/.bashrc
fi
if ! grep -q "GANJAGURU_HOME/bin" ~/.bashrc; then
    echo "export PATH=\$GANJAGURU_HOME/bin:\$PATH" >> ~/.bashrc
fi

# Source the .bashrc in a subshell to avoid issues
bash -c 'source ~/.bashrc'

# --- Git repo setup ---
cd "$HOME/ganjaguru" || exit
if [ ! -d ".git" ]; then
    git init
    git add .
    git commit -m "Initial commit of GanjaGuru training structure"
    echo "🌀 Git repo initialized"
else
    echo "⚡ Git repo already initialized"
fi

echo "📊 Directory structure:"
tree "$HOME/ganjaguru" || ls -lR "$HOME/ganjaguru"

echo "✅ GanjaGuru training suite ready at: $BASE_DIR"