# CLAUDE.md — AI Customer Support Agent Developer Guide

## Project Overview
The **AI Customer Support Agent** is a multi-channel autonomous customer service platform orchestrated via **n8n**, connected to a **Supabase (PostgreSQL)** database backend, and powered by **Google Gemini 2.5 Flash**. The primary messaging interface is Telegram, with built-in multi-turn memory, RAG knowledge grounding, product catalog querying, lead capture, appointment booking via Google Calendar, and human escalation workflows.

---

## Directory Structure

```text
AI-Customer-Support-Agent/
├── CLAUDE.md                  # This file: Architecture, guidelines, and commands
├── README.md                  # Public overview, quickstart, and deployment
├── .gitignore                 # Secrets, cache, and OS ignore patterns
├── .env.example               # Template of all environment variables
├── docs/                      # Technical manuals
│   ├── architecture.md        # Full state machine & mermaid dataflow
│   ├── database.md            # Postgres ER diagram, schema details & indexes
│   ├── workflows.md           # Node-by-node guide for n8n workflows
│   ├── security.md            # Threat model, RLS & prompt injection guards
│   ├── testing.md             # 16-scenario test matrix & verification
│   ├── telegram_setup.md      # BotFather setup & chat ID discovery
│   └── supabase_setup.md      # Supabase project creation & DDL execution
├── workflows/                 # Exported, valid n8n workflows
│   ├── 00_Telegram_Echo_Test.json           # Phase 3 echo verification
│   ├── 01_Customer_Identification_Test.json # Phase 4 customer lookup/creation
│   ├── 01_Customer_Support_Main.json        # Production master agent workflow
│   └── 02_Error_Handler_Workflow.json       # Phase 15 global error handler
├── prompts/                   # Core LLM prompt templates & rules
│   ├── system_prompt.md       # Master assistant persona & anti-hallucination
│   ├── intent_classification.md# Zero-shot intent categorizer
│   ├── guardrails.md          # Input/output security rules
│   ├── lead_extraction.md     # Sales lead extraction prompt
│   └── appointment_extraction.md # Calendar slot parser
├── scripts/                   # Migration & execution utilities
│   ├── supabase_schema.sql    # DDL for all 9 tables, indexes, RLS & triggers
│   ├── seed_data.sql          # Seed records for products and knowledge base
│   ├── test_runner.py         # Automated test runner for 16 scenarios
│   └── simulate_telegram_webhook.py # Local mock Telegram event dispatcher
└── tests/                     # Test definitions & unit tests
    ├── test_scenarios.json    # 16 comprehensive test cases
    └── test_prompts.py        # Python unittest suite for prompts and JSON
```

---

## Common Development Commands

### 1. Run Automated Test Suite
```bash
# Verify all 16 scenarios (Intent detection, Guardrails, Mocking)
python scripts/test_runner.py
```

### 2. Run Prompts and JSON Schema Validation
```bash
python tests/test_prompts.py
```

### 3. Simulate Incoming Telegram Webhook
```bash
# Send test message to local or hosted n8n webhook
python scripts/simulate_telegram_webhook.py --url "http://localhost:5678/webhook/customer-support-main" --message "How much is your AI Automation package?"
```

---

## Architecture Conventions & Rules

1. **Strict Grounding (Anti-Hallucination)**:
   - The LLM must NEVER invent prices, discounts, or service commitments.
   - Any pricing or product data must originate directly from the `products` table.
   - General company information must come from the `knowledge_base` table.

2. **Security & Guardrail Invariants**:
   - Every incoming message passes through Node 3 (`Step 49-50: Guardrails Pre-Filter`) before touching the LLM or performing stateful mutations.
   - System prompts, API keys, and customer database records must NEVER be printed to end users.
   - All Supabase tables have Row Level Security (RLS) enabled. Only the `service_role` key from n8n backend is permitted to perform full CRUD operations.

3. **Workflow Resilience**:
   - Always keep `02_Error_Handler_Workflow.json` active in n8n. If any node in `01_Customer_Support_Main.json` fails, the error trigger records the stack trace in `system_logs` and sends an alert to `TELEGRAM_ADMIN_CHAT_ID`.

4. **Multi-Turn Memory**:
   - Up to 6 recent messages are fetched from the `messages` table for each active conversation and injected into the prompt context for fluid conversation memory.
