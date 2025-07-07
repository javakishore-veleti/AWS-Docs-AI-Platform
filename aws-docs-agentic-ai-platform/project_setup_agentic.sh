#!/bin/bash

set -e

ROOT_DIR="aws-docs-agentic-ai-platform"
FOLDERS=(
  "agents"
  "planner"
  "router"
  "memory"
  "tools"
  "execution_server"
  "infra"
  "config"
  "scripts"
  "notebooks"
)

echo "Creating base project directory: $ROOT_DIR"
mkdir -p "$ROOT_DIR"

for folder in "${FOLDERS[@]}"; do
  echo "Creating folder: $ROOT_DIR/$folder"
  mkdir -p "$ROOT_DIR/$folder"
done

# Add placeholder files
touch "$ROOT_DIR/agents/iam_agent.py"
touch "$ROOT_DIR/agents/ec2_agent.py"

touch "$ROOT_DIR/planner/planner.py"
touch "$ROOT_DIR/planner/task_templates.yaml"

touch "$ROOT_DIR/router/route_request.py"
touch "$ROOT_DIR/router/model_selector.py"

touch "$ROOT_DIR/memory/vector_store.py"
touch "$ROOT_DIR/memory/memory_utils.py"

touch "$ROOT_DIR/tools/sql_tool.py"
touch "$ROOT_DIR/tools/rest_api_tool.py"

touch "$ROOT_DIR/execution_server/main.py"
touch "$ROOT_DIR/execution_server/agent_executor.py"

touch "$ROOT_DIR/infra/launch_ecs_agents.py"
touch "$ROOT_DIR/infra/iam_roles.json"

touch "$ROOT_DIR/config/agent_roles.yaml"
touch "$ROOT_DIR/config/system_config.yaml"

touch "$ROOT_DIR/scripts/run_all_agents.sh"
touch "$ROOT_DIR/scripts/deploy_to_aws.sh"

touch "$ROOT_DIR/notebooks/agent_flow_diagram.ipynb"

touch "$ROOT_DIR/requirements.txt"
touch "$ROOT_DIR/setup.py"
touch "$ROOT_DIR/README.md"

echo "Project setup completed for $ROOT_DIR"
