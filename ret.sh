 #!/bin/bash

echo "🚀 Setting up GanjaGuru training suite..."

# Base directory
BASE_DIR="$HOME/ganjaguru/training"
mkdir -p "$BASE_DIR"

# File list
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

# Generate files
for FILE in "${FILES[@]}"; do
    touch "$BASE_DIR/$FILE"
    chmod 777 "$BASE_DIR/$FILE"
    echo "🌿 Created $FILE"
done

# Set environment variables
echo "📦 Exporting environment variables..."
echo "export GANJAGURU_HOME=$HOME/ganjaguru" >> ~/.bashrc
echo "export TRAINING_DIR=$BASE_DIR" >> ~/.bashrc
echo "export PATH=\$GANJAGURU_HOME/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

# Git init
cd "$HOME/ganjaguru"
git init
git add .
git commit -m "Initial commit of GanjaGuru training structure"

echo "✅ GanjaGuru training suite ready at: $BASE_DIR"