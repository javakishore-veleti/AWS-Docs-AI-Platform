# aws-docs-agentic-ai-platform

This project defines an agentic AI orchestration platform inspired by frameworks like CrewAI, LangGraph, and AutoGen. It enables modular, secure, and compliant multi-agent workflows, powered by LLMs trained from scratch using AWS documentation. This framework is the second core component of the overall `AWS-Docs-AI-Platform`.

## Purpose

To enable enterprise-grade automation of knowledge work, this platform builds structured agents around well-defined roles (e.g., Risk Advisor, Compliance Assistant, FinOps Analyst), each of which interacts with internal data, tools, and custom LLMs created in `aws-docs-llm-builder`.

These agents coordinate using a shared planner and communication protocol, enabling autonomous and semi-autonomous workflows that can span risk audits, architecture validation, compliance checks, and developer assistance.

## Architecture Overview

The platform includes the following key components:

### 1. Agents
Each agent has:
- A specific role and responsibility
- An associated LLM backend (unified or per-service model)
- Access to restricted tools (API calls, search, calculators, etc.)
- Short-term and optional long-term memory

### 2. Planner
A centralized or distributed orchestration module that:
- Accepts a high-level task prompt or API request
- Breaks it down into agent-invocable steps
- Routes decisions, outputs, and memory updates

### 3. Memory System
- Embedded memory store using FAISS, pgvector, or OpenSearch
- Optional scratchpad for contextual chaining
- Per-agent memory boundaries for modular design

### 4. Router & Dispatcher
- Identifies which LLM (e.g., unified vs. ec2-llm vs. s3-llm) should power a given task
- Balances load and ensures isolated evaluation and monitoring
- Respects policy boundaries (e.g., IAM agent can’t query S3 model)

### 5. Execution Environment
- Runs in a containerized AWS-native environment
- Hosted on ECS or EKS
- Access via secure API Gateway
- Event-driven or REST-triggered workflows

## Example Use Cases

- **Infrastructure Compliance Advisor**: Reads an IAM policy, validates compliance against company rules, and rewrites it securely
- **EC2 Cost Review Agent**: Analyzes EC2 billing metadata, retrieves best practices from `ec2-llm`, and generates cost reduction suggestions
- **Cross-Service Risk Summarizer**: Evaluates EC2, VPC, and IAM configurations together to produce a risk report and mitigation checklist

## How This Connects to `aws-docs-llm-builder`

- This framework imports LLMs trained and served via the `aws-docs-llm-builder` folder
- Each agent can bind to either the unified LLM or a per-service model (e.g., `ec2-llm`, `iam-llm`)
- Agent behavior is configured through environment variables or a declarative role definition file

## Deployment Stack

The platform is designed to run on AWS-native infrastructure:

- **API Gateway**: Entry point for tasks
- **Lambda or ECS**: Stateless planner/controller logic
- **ECS/EKS**: Agent execution environment (Python microservices)
- **S3**: Logs and artifact storage
- **FAISS / OpenSearch**: Memory store
- **CloudWatch**: Logs and metrics
- **KMS + IAM**: Secure communication and access isolation

## Security and Compliance

- Each agent has a scoped IAM role and tool access
- Inference results and logs are auditable
- Actions, model usage, and decision trees are logged and traceable
- Agent composition and dependencies are declared and versioned

## Roadmap

- [ ] Integrate secure tool calling (SQL, APIs, PDF parsers)
- [ ] Support multi-agent conversational loop
- [ ] Implement role isolation + evaluation triggers
- [ ] Add human-in-the-loop override interface
- [ ] Deploy and benchmark on synthetic and real financial tasks

## License

This project is released under the Apache 2.0 License.
