# AWS-Docs-AI-Platform

The AWS-Docs-AI-Platform is a secure, enterprise-grade framework for building and orchestrating domain-specific large language models (LLMs) using AWS documentation as the foundational training corpus. It is designed for highly regulated industries, such as banking, where pretrained models cannot be used due to compliance, auditability, and data traceability concerns.

This platform consists of two independently operable but tightly integrated subsystems:

1. **Custom LLM Builder (`aws-docs-llm-builder`)**  
   A fully auditable LLM development pipeline from tokenizer to model training and inference deployment.

2. **Agentic AI Orchestration Framework (`aws-docs-agentic-ai-platform`)**  
   A modular, CrewAI-style platform that enables multi-agent collaboration powered by the LLMs built in the first subsystem.

---

## Architecture Summary

### 1. aws-docs-llm-builder

This module is responsible for:

- Scraping and processing AWS documentation
- Training custom tokenizers
- Designing and training GPT-style models from scratch (e.g., 124M to 1.3B+ parameters)
- Supporting both unified and per-service micro-model variants
- Hosting models via vLLM or SageMaker endpoints
- Tracking compliance data, lineage manifests, and evaluation metrics

Use Cases:
- Standalone LLM APIs for AWS-aware internal tools
- Secure model infrastructure for internal research
- Model backends for downstream agentic systems

See `aws-docs-llm-builder/README.md` for implementation details.

---

### 2. aws-docs-agentic-ai-platform

This module is responsible for:

- Defining and managing specialized LLM agents (e.g., Risk Advisor, IAM Auditor)
- Routing tasks to the appropriate model (unified or service-specific)
- Orchestrating multi-agent workflows using planners and routers
- Deploying secure, traceable API-based agent endpoints
- Logging every interaction for traceability and control

Use Cases:
- FinOps assistant
- Cloud compliance bot
- Developer DevOps copilot
- Multi-agent collaborative cloud infrastructure reasoning

See `aws-docs-agentic-ai-platform/README.md` for implementation details.

---

## Why This Architecture

- **Compliance**: Models are trained entirely from known, auditable documentation sources
- **Modularity**: The agentic layer allows for role-based composition, isolation, and explainability
- **Scalability**: Unified models can support broad use cases; micro-models optimize specific domains
- **Security**: Deployed on VPC-bound AWS infrastructure with IAM-controlled tool access
- **Auditability**: Every dataset, token, parameter, and decision path can be traced and versioned

---

## Example Workflow

1. A developer submits a high-level task:  
   _“Generate a compliant IAM policy for multi-region S3 access.”_

2. The `planner` component in the agentic layer routes this to:
   - IAM Agent → backed by `iam-llm`
   - S3 Agent → backed by `s3-llm`
   - Compliance Agent → applies internal rules

3. The agents consult relevant AWS documentation-derived models, reason independently, and produce artifacts (policy code + commentary).

4. The planner returns a final, validated output to the user, with logs and evaluation traces.

---

## Roadmap

- Add CI/CD workflows for model training and agent updates
- Add LangGraph-based visual planner for agent interaction
- Add model version rollback and auto-eval feedback integration
- Extend training data to internal infrastructure and compliance docs

---

## License

This project is licensed under the Apache 2.0 License.

