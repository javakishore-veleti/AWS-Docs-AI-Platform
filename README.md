# AWS-Docs-AI-Platform

The AWS-Docs-AI-Platform is a custom-built Large Language Model (LLM) stack developed entirely from scratch using documentation sourced from AWS public technical resources. It is designed for regulated industries such as banking and insurance, where pretrained external models cannot be used due to data compliance and security restrictions.

This project demonstrates the creation of a secure, auditable, and domain-specific LLM pipeline that spans document ingestion, tokenizer training, transformer model implementation, distributed training, and production-grade inference deployment using native AWS infrastructure.

## Project Objectives

- Build a domain-specific LLM from scratch without using any third-party pretrained models
- Train on AWS documentation to create an internal assistant for AWS infrastructure, security, and DevOps queries
- Fully control tokenizer, architecture, and training process for auditability
- Deploy the model using secure, scalable, and observable AWS-native services
- Ensure compliance with internal enterprise standards on traceability, model lineage, and explainability

## Dataset Pipeline

The training dataset is constructed from publicly available AWS documentation covering services such as EC2, S3, IAM, Lambda, and more.

Steps include:

- Document scraping from `https://docs.aws.amazon.com/`
- Cleaning and normalization (HTML → plain text)
- Section-based chunking (context windows of 512 to 2048 tokens)
- Deduplication and token counting for training data sizing

The estimated training corpus contains over 1.5 billion tokens after processing.

## Tokenizer and Model Design

- Custom tokenizer trained using SentencePiece or Hugging Face Tokenizers
- Vocabulary size: 32,000 tokens
- Architecture: GPT-style causal decoder-only transformer
- Model size: 1.3 billion parameters
- Configuration: 24 transformer layers, 2048 hidden size, 32 attention heads
- Context length: 2048 tokens
- Activation function: GELU

## Training Strategy

- Training framework: PyTorch with DeepSpeed ZeRO-3 or Fully Sharded Data Parallel (FSDP)
- Optimizer: AdamW with weight decay and cosine decay learning rate schedule
- Mixed-precision (fp16 or bf16) for improved performance
- Epochs: 3 to 5 passes over the full dataset
- Checkpointing and resume capability for fault tolerance

Training is executed on AWS infrastructure using:

- Amazon SageMaker Training Jobs with p4d or Trn1 instances
- Model checkpoints saved to Amazon S3

## Inference and Serving

The trained model is served through a high-performance inference stack with secure access and observability.

- Inference Engine: vLLM or Triton Inference Server
- Deployment target: AWS ECS or EKS
- API access via Amazon API Gateway with Cognito-based authentication
- Monitoring and logging with Amazon CloudWatch
- Optional: retrieval augmentation via OpenSearch or pgvector

## Evaluation and Monitoring

Evaluation includes:

- Held-out test questions based on AWS service documentation
- Perplexity measurement and prompt-based accuracy checks
- Evaluation metrics logged and visualized through Weights & Biases or custom dashboards

## Compliance and Auditability

This platform is designed for environments where explainability and traceability are mandatory:

- Model lineage tracked via signed metadata and training manifests
- Tokenizer, training data, model weights, and configs are version-controlled
- IAM-based access restrictions applied to all training and inference workflows
- All data encrypted in transit and at rest using AWS KMS
- CloudTrail and CloudWatch used for activity logging and audit trails

## Roadmap

- Add Retrieval-Augmented Generation (RAG) support with AWS-hosted vector store
- Deploy fine-tuned micro-models for IAM, EC2, and networking
- Integrate agentic architecture using LangGraph or CrewAI-style multi-agent orchestration
- Extend dataset to include internal technical manuals and compliance documentation

## License

This project is licensed under the Apache 2.0 License.
