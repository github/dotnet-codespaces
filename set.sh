#!/bin/bash

set -e

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

echo "📦 Exporting environment variables..."

# Check if env vars already set in .bashrc before appending
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

cd "$HOME/ganjaguru" || exit
if [ ! -d ".git" ]; then
    git init
    git add .
    git commit -m "Initial commit of GanjaGuru training structure"
    echo "🌀 Git repo initialized"
else
    echo "⚡ Git repo already initialized"
fi

echo "✅ GanjaGuru training suite ready at: $BASE_DIR"