 #!/bin/bash

echo "🚀 Setting up GanjaGuru training suite..."

BASE_DIR="$HOME/ganjaguru/training"
mkdir -p "$BASE_DIR"

declare -A FILES_CONTENT
FILES_CONTENT["intents.json"]="{\"intents\": [{\"name\": \"greet\", \"examples\": [\"Hi\", \"Hello\", \"Hey\"]}]}"
FILES_CONTENT["stories.md"]="## Greet path
* greet
  - utter_greet"
FILES_CONTENT["responses.yml"]="responses:
  utter_greet:
    - text: \"Hey there, welcome to GanjaGuru!\""
FILES_CONTENT["domain.yml"]="intents:
  - greet
responses:
  utter_greet:
    - text: \"Welcome to the GanjaGuru metaverse!\""
FILES_CONTENT["nlu.yml"]="version: \"2.0\"
nlu:
- intent: greet
  examples: |
    - hey
    - hello
    - hi"
FILES_CONTENT["rules.yml"]="rules:
- rule: Say hi
  steps:
  - intent: greet
  - action: utter_greet"
FILES_CONTENT["forms.yml"]="forms:
  order_form:
    required_slots:
      strain_type:
        - type: from_text"
FILES_CONTENT["entities.json"]="{\"entities\": [\"strain\", \"effect\", \"symptom\"]}"
FILES_CONTENT["slots.json"]="{\"slots\": {\"strain_type\": {\"type\": \"text\"}, \"effect\": {\"type\": \"text\"}}}"
FILES_CONTENT["lookup_tables.json"]="{\"lookup_tables\": {\"strain_names\": [\"OG Kush\", \"Sour Diesel\", \"Purple Haze\"]}}"
FILES_CONTENT["synonyms.json"]="{\"synonyms\": {\"cbd\": [\"Cannabidiol\"], \"thc\": [\"Tetrahydrocannabinol\"]}}"
FILES_CONTENT["example_chats.md"]="* greet
  - utter_greet
* ask_strain
  - action_recommend_strain"
FILES_CONTENT["prompts.yml"]="prompts:
  recommend_strain:
    - What effects are you looking for?"
FILES_CONTENT["conversation_flows.md"]="User greets > Bot greets > User asks for strain > Bot recommends > User confirms"
FILES_CONTENT["utterances.json"]="{\"utterances\": {\"utter_greet\": [\"Hey!\", \"Hello there!\"]}}"
FILES_CONTENT["training_data.md"]="### Training Samples
* greet: Hello
* ask_strain: Recommend me a relaxing strain"
FILES_CONTENT["context_examples.json"]="{\"contexts\": {\"relaxation\": [\"chill\", \"calm\", \"unwind\"]}}"
FILES_CONTENT["fallback_patterns.yml"]="nlu_fallback:
  threshold: 0.4"
FILES_CONTENT["dialogue_patterns.md"]="Greet → Strain Inquiry → Effects → Purchase"
FILES_CONTENT["mood_templates.yml"]="moods:
  - happy
  - chill
  - euphoric"
FILES_CONTENT["question_templates.yml"]="questions:
  - What are you looking for?
  - How do you want to feel?"
FILES_CONTENT["story_graph.json"]="{\"nodes\": [{\"id\": \"start\"}, {\"id\": \"greet\"}, {\"id\": \"recommend_strain\"}]}"

for FILE in "${!FILES_CONTENT[@]}"; do
    echo "${FILES_CONTENT[$FILE]}" > "$BASE_DIR/$FILE"
    chmod 777 "$BASE_DIR/$FILE"
    echo "🌿 Created $FILE with content"
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
