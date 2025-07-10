#!/bin/bash

set -e

echo "🚀 Setting up GanjaGuru training suite..."

BASE_DIR="$HOME/ganjaguru/training"
mkdir -p "$BASE_DIR"

# Use two parallel arrays for compatibility (no associative arrays)
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

CONTENTS=(
    '{"intents": [{"name": "greet", "examples": ["Hi", "Hello", "Hey"]}]}'
    '## Greet path\n* greet\n  - utter_greet'
    'responses:\n  utter_greet:\n    - text: "Hey there, welcome to GanjaGuru!"'
    'intents:\n  - greet\nresponses:\n  utter_greet:\n    - text: "Welcome to the GanjaGuru metaverse!"'
    'version: "2.0"\nnlu:\n- intent: greet\n  examples: |\n    - hey\n    - hello\n    - hi'
    'rules:\n- rule: Say hi\n  steps:\n  - intent: greet\n  - action: utter_greet'
    'forms:\n  order_form:\n    required_slots:\n      strain_type:\n        - type: from_text'
    '{"entities": ["strain", "effect", "symptom"]}'
    '{"slots": {"strain_type": {"type": "text"}, "effect": {"type": "text"}}}'
    '{"lookup_tables": {"strain_names": ["OG Kush", "Sour Diesel", "Purple Haze"]}}'
    '{"synonyms": {"cbd": ["Cannabidiol"], "thc": ["Tetrahydrocannabinol"]}}'
    '* greet\n  - utter_greet\n* ask_strain\n  - action_recommend_strain'
    'prompts:\n  recommend_strain:\n    - What effects are you looking for?'
    'User greets > Bot greets > User asks for strain > Bot recommends > User confirms'
    '{"utterances": {"utter_greet": ["Hey!", "Hello there!"]}}'
    '### Training Samples\n* greet: Hello\n* ask_strain: Recommend me a relaxing strain'
    '{"contexts": {"relaxation": ["chill", "calm", "unwind"]}}'
    'nlu_fallback:\n  threshold: 0.4'
    'Greet → Strain Inquiry → Effects → Purchase'
    'moods:\n  - happy\n  - chill\n  - euphoric'
    'questions:\n  - What are you looking for?\n  - How do you want to feel?'
    '{"nodes": [{"id": "start"}, {"id": "greet"}, {"id": "recommend_strain"}]}'
)

for i in "${!FILES[@]}"; do
    echo -e "${CONTENTS[$i]}" > "$BASE_DIR/${FILES[$i]}"
    chmod 777 "$BASE_DIR/${FILES[$i]}"
    echo "🌿 Created ${FILES[$i]} with content"
done

if ! grep -q "GANJAGURU_HOME" ~/.bashrc; then
    echo "export GANJAGURU_HOME=$HOME/ganjaguru" >> ~/.bashrc
fi

if ! grep -q "TRAINING_DIR" ~/.bashrc; then
    echo "export TRAINING_DIR=$HOME/ganjaguru/training" >> ~/.bashrc
fi

if ! grep -q "GANJAGURU_HOME/bin" ~/.bashrc; then
    echo "export PATH=$GANJAGURU_HOME/bin:$PATH" >> ~/.bashrc
fi

source ~/.bashrc

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
