#!/bin/bash

# Set project root name
PROJECT_NAME="agents-from-scratch"
echo "Creating project directory: $PROJECT_NAME"
mkdir -p $PROJECT_NAME

cd $PROJECT_NAME

# Create top-level files
touch README.md requirements.txt .env.example .gitignore

# Create utility folder and common utils
mkdir -p utils
touch utils/{llm_wrapper.py,schema_utils.py,tools.py,memory.py,logging_utils.py}

# Part 1: LLM Basics
mkdir -p part1_llm_basics/data
touch part1_llm_basics/{01_basic_llm_call.py,02_structured_output.py,03_tool_use.py,04_rag_intro.py}
touch part1_llm_basics/data/sample_docs.txt

# Part 2: Workflow Patterns
mkdir -p part2_workflow_patterns/diagrams
touch part2_workflow_patterns/{05_prompt_chaining.py,06_routing.py,07_parallel_validation.py,08_orchestrator_pattern.py}

# Part 3: Agents
mkdir -p part3_agents/agents
touch part3_agents/{09_simple_agent.py,10_task_loop_agent.py,11_multi_agent_chat.py}
touch part3_agents/agents/{planner.py,coder.py,reviewer.py,memory.py}

# Part 4: Testing and Deployment
mkdir -p part4_testing_deploy/test_cases
touch part4_testing_deploy/{12_eval_framework.py,13_llm_deployment.py,14_fastapi_demo.py}
touch part4_testing_deploy/test_cases/eval_inputs.json

# Projects
mkdir -p projects/calendar_assistant
touch projects/calendar_assistant/{main.py,prompts.py,routes.py}

mkdir -p projects/blog_writer
touch projects/blog_writer/{orchestrator.py,workers.py,planner.py}

mkdir -p projects/code_assistant
touch projects/code_assistant/{agent_controller.py,planner.py,coder.py,tests.py,reviewer.py}

# Jupyter Notebooks
mkdir -p notebooks
touch notebooks/{RAG_Demo.ipynb,Agent_Orchestration.ipynb}

# Add basic .gitignore
cat <<EOL > .gitignore
.env
__pycache__/
.ipynb_checkpoints/
*.pyc
.vscode/
EOL

echo "✅ Directory structure created."

# Initialize Git repo
git init
echo "✅ Git repository initialized."

# First commit
git add .
git commit -m "Initial commit: project scaffolding for Agents from Scratch"

echo "✅ Initial commit complete."

# Suggest GitHub remote add
echo ""
echo "👉 Next step:"
echo "1. Create a new GitHub repository named '$PROJECT_NAME'"
echo "2. Run the following command to push your code:"
echo "   git remote add origin git@github.com:YOUR_USERNAME/$PROJECT_NAME.git"
echo "   git push -u origin main"

