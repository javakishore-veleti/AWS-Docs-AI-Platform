#!/bin/bash

set -e

ROOT_DIR="aws-docs-llm-builder"
FOLDERS=(
  "configs"
  "data_pipeline"
  "tokenizer"
  "model"
  "training"
  "evaluation"
  "inference"
  "compliance"
  "infra"
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
touch "$ROOT_DIR/configs/tokenizer_config.yaml"
touch "$ROOT_DIR/configs/model_config.json"
touch "$ROOT_DIR/configs/training_config.yaml"

touch "$ROOT_DIR/data_pipeline/scrape_aws_docs.py"
touch "$ROOT_DIR/data_pipeline/clean_and_chunk.py"
touch "$ROOT_DIR/data_pipeline/split_dataset.py"

touch "$ROOT_DIR/tokenizer/train_tokenizer.py"
touch "$ROOT_DIR/tokenizer/tokenizer_utils.py"

touch "$ROOT_DIR/model/gpt_model.py"
touch "$ROOT_DIR/model/config_loader.py"
touch "$ROOT_DIR/model/model_utils.py"

touch "$ROOT_DIR/training/train.py"
touch "$ROOT_DIR/training/dataset.py"
touch "$ROOT_DIR/training/deepspeed_config.json"

touch "$ROOT_DIR/evaluation/evaluate_perplexity.py"
touch "$ROOT_DIR/evaluation/generate_test_set.py"
touch "$ROOT_DIR/evaluation/eval_utils.py"

touch "$ROOT_DIR/inference/serve_vllm.py"
touch "$ROOT_DIR/inference/api.py"

touch "$ROOT_DIR/compliance/training_manifest.json"
touch "$ROOT_DIR/compliance/hash_dataset.py"
touch "$ROOT_DIR/compliance/audit_logger.py"

touch "$ROOT_DIR/infra/emr_bootstrap.sh"
touch "$ROOT_DIR/infra/sagemaker_launcher.py"
touch "$ROOT_DIR/infra/run_on_ecs.py"
touch "$ROOT_DIR/infra/iam_roles_policies.json"

touch "$ROOT_DIR/scripts/run_all_local.sh"
touch "$ROOT_DIR/scripts/trigger_pipeline_aws.sh"

touch "$ROOT_DIR/notebooks/exploratory_token_stats.ipynb"

touch "$ROOT_DIR/requirements.txt"
touch "$ROOT_DIR/setup.py"
touch "$ROOT_DIR/README.md"

echo "Project setup completed for $ROOT_DIR"
