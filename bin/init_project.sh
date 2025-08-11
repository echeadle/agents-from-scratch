#!/bin/bash
# Agents from Scratch - Project Bootstrap Script
# Creates the recommended folder/file structure for the guide.
# Designed to be safe to re-run: will never overwrite existing work.

PROJECT_NAME="agents-from-scratch"

# === Function to safely create a directory ===
make_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "📂 Created: $1"
    fi
}

# === Function to safely create a file ===
make_file() {
    if [ ! -f "$1" ]; then
        touch "$1"
        echo "📝 Created: $1"
    fi
}

# === 0. Create project root ===
if [ ! -d "$PROJECT_NAME" ]; then
    echo "📦 Creating project directory: $PROJECT_NAME"
    mkdir -p "$PROJECT_NAME"
fi
cd $PROJECT_NAME

# === 1. Top-level files (every project should have these) ===
# - README.md: project overview
# - requirements.txt: Python dependencies
# - .env.example: template for API keys / environment variables
# - .gitignore: files/folders to exclude from Git
for file in README.md requirements.txt .env.example .gitignore; do
    make_file "$file"
done

# === 2. bin/ (utility scripts for setup & automation) ===
make_dir bin
[ ! -f bin/init_project.sh ] && cp ../init_project.sh bin/ 2>/dev/null || true

# === 3. utils/ (helper functions and reusable modules) ===
# Code here will be imported by multiple parts of the project.
make_dir utils
for file in llm_wrapper.py schema_utils.py tools.py memory.py logging_utils.py; do
    make_file utils/$file
done

# === 4. Part 1: LLM Basics ===
# Introductory scripts showing basic API calls, structured output, tools, and retrieval.
make_dir part1_llm_basics/data
for file in 01_basic_llm_call.py 02_structured_output.py 03_tool_use.py 04_rag_intro.py; do
    make_file part1_llm_basics/$file
done
make_file part1_llm_basics/data/sample_docs.txt

# === 5. Part 2: Workflow Patterns ===
# Examples of prompt chaining, routing, parallel validation, orchestrator pattern.
make_dir part2_workflow_patterns/diagrams
for file in 05_prompt_chaining.py 06_routing.py 07_parallel_validation.py 08_orchestrator_pattern.py; do
    make_file part2_workflow_patterns/$file
done

# === 6. Part 3: Agents ===
# Building agents from scratch — simple agents, task loop agents, multi-agent systems.
make_dir part3_agents/agents
for file in 09_simple_agent.py 10_task_loop_agent.py 11_multi_agent_chat.py; do
    make_file part3_agents/$file
done
for file in planner.py coder.py reviewer.py memory.py; do
    make_file part3_agents/agents/$file
done

# === 7. Part 4: Testing & Deployment ===
# How to test and deploy LLM/agent systems, including FastAPI demo.
make_dir part4_testing_deploy/test_cases
for file in 12_eval_framework.py 13_llm_deployment.py 14_fastapi_demo.py; do
    make_file part4_testing_deploy/$file
done
make_file part4_testing_deploy/test_cases/eval_inputs.json

# === 8. projects/ (real-world agent projects) ===
# Full working examples: calendar assistant, blog writer, code assistant.
for dir in calendar_assistant blog_writer code_assistant; do
    make_dir projects/$dir
done
make_file projects/calendar_assistant/main.py
make_file projects/calendar_assistant/prompts.py
make_file projects/calendar_assistant/routes.py
make_file projects/blog_writer/orchestrator.py
make_file projects/blog_writer/workers.py
make_file projects/blog_writer/planner.py
make_file projects/code_assistant/agent_controller.py
make_file projects/code_assistant/planner.py
make_file projects/code_assistant/coder.py
make_file projects/code_assistant/tests.py
make_file projects/code_assistant/reviewer.py

# === 9. notebooks/ (exploratory work in Jupyter) ===
make_dir notebooks
make_file notebooks/RAG_Demo.ipynb
make_file notebooks/Agent_Orchestration.ipynb

# === 10. Book/ (markdown chapters for the guide) ===
# This is where the main written content lives.
make_dir Book
for file in chapter_01_intro.md chapter_02_llm_basics.md chapter_03_prompt_patterns.md chapter_04_agents.md; do
    make_file Book/$file
done

# === 11. documents/ (supporting docs, checklists, troubleshooting) ===
make_dir documents
for file in terminology_glossary.md troubleshooting_tips.md design_checklists.md; do
    make_file documents/$file
done

# === 12. resources/ (links & curated external materials) ===
make_dir resources
make_file resources/resource_list.md

# === 13. Update .gitignore if missing entries ===
for entry in ".env" "__pycache__/" ".ipynb_checkpoints/" "*.pyc" ".vscode/"; do
    grep -qxF "$entry" .gitignore || echo "$entry" >> .gitignore
done

# === 14. Initialize Git if needed ===
if [ ! -d .git ]; then
    git init
    echo "✅ Git repository initialized."
    git add .
    git commit -m "Initial commit: project scaffolding for Agents from Scratch"
else
    echo "ℹ️ Git repo already exists — skipping init."
fi

echo "✅ Project structure ensured. Safe to re-run."
