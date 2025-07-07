# aws-docs-llm-builder

This project defines a complete, from-scratch Large Language Model (LLM) development pipeline, purpose-built using AWS service documentation as the training corpus. It is the foundational component of the overall `AWS-Docs-AI-Platform`, designed for organizations with strict compliance requirements that prohibit the use of public pretrained models.

All stages—from data ingestion to tokenizer training, model architecture design, distributed training, evaluation, and inference deployment—are built and managed within enterprise-grade, auditable AWS infrastructure.

## Purpose

To train custom LLMs using only trusted, fully auditable internal documentation, enabling use cases such as:

- AWS-aware DevOps copilots
- Internal FinOps advisors
- Cloud compliance assistants
- Secure, explainable AI deployments within regulated enterprises

This builder supports both:
- A **unified model** trained on the full AWS documentation corpus
- **Per-service micro-models** (e.g., EC2-only, S3-only), optimized for modular agentic architectures

## Key Components

### 1. Data Pipeline
- Scrapes and parses HTML, PDF, and Markdown from `https://docs.aws.amazon.com/`
- Cleans navigation, footers, and duplicate content
- Chunks by section headers or semantic boundaries
- Token count estimation using custom or Hugging Face tokenizers
- Outputs: plain text chunks, tokenized sequences, metadata per file

### 2. Tokenizer
- Trained from scratch using SentencePiece or Hugging Face Tokenizers
- Vocabulary size: 32,000–50,000
- Exported to version-controlled artifacts (`tokenizer.json`, vocab, merges)
- Used consistently across training and inference

### 3. Model Architecture
- GPT-style decoder-only transformer
- Parameter sizes supported:
  - 124M (demo/testing)
  - 355M (per-service micro-models)
  - 1.3B+ (unified full model)
- Configurable layers, hidden size, heads, and context length (2048+)
- Activation: GELU
- Positional encoding: rotary or learned

### 4. Training Pipeline
- DeepSpeed ZeRO-3 or PyTorch FSDP
- Mixed-precision training (fp16 or bf16)
- 3–5 epochs over a 1.5–2B token dataset
- Optimizer: AdamW + cosine decay with warmup
- Logging with Weights & Biases or CloudWatch
- Checkpoints stored in Amazon S3
- Trainable via:
  - Amazon SageMaker Training Jobs
  - EC2 (p4d, trn1) with containerized launcher

### 5. Evaluation & Compliance
- Prompts extracted from held-out docs for Q&A accuracy
- Metrics: perplexity, hallucination rate, token accuracy
- Evaluation reports stored alongside model version
- Compliance manifest tracks:
  - Input doc hashes
  - Tokenizer version
  - Training hyperparameters
  - Git commit hash for model code

### 6. Inference & Hosting
- Inference engines: vLLM or Triton Inference Server
- Deployment options:
  - Amazon SageMaker Endpoint
  - ECS + API Gateway for low-latency REST access
- Optionally fronted with a RAG layer (FAISS or OpenSearch)
- Output traces and latencies logged in CloudWatch

## Model Types Supported

| Model Type           | Purpose                                     |
|----------------------|---------------------------------------------|
| aws-unified-llm-1.3b | General-purpose AWS assistant               |
| ec2-llm-355m         | EC2 service-specific reasoning agent        |
| iam-llm-124m         | Fast IAM policy summarizer for compliance   |

## Training Cost and Resource Guidance

| Model Size | Est. Time | Est. Cost (On-demand) | Hardware         |
|------------|-----------|------------------------|------------------|
| 124M       | 6–8 hrs   | ~$15                   | 1x A100 (g5.12x) |
| 355M       | 12 hrs    | ~$30–40                | 1x A100 (g5.12x) |
| 1.3B       | 1–2 days  | ~$300–500              | 4x A100 (p4d)    |
| 2.7B       | 3–4 days  | ~$1000+                | 8x A100 (p4d)    |

Spot pricing and SageMaker savings plans can significantly reduce costs.

## Deployment Integration

Trained models from this builder are consumed directly by the agent orchestration platform (`aws-docs-agentic-ai-platform`). Models can be deployed as:

- API endpoints used by individual agents
- Task-specific completion backends (e.g., compliance-agent → iam-llm)
- Embedded vector search engines (for RAG workflows)

## Roadmap

- [ ] Add dataset diffing + deduplication log
- [ ] Integrate token packing + streaming dataset
- [ ] Extend evaluation set using domain-specific synthetic prompts
- [ ] Enable model distillation for smaller deployment variants
- [ ] Link to per-service model changelog and version diff viewer

## License

This project is released under the Apache 2.0 License.
