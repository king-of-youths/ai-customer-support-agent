# AI Customer Support Agent — Autonomous Multi-Channel Support Platform

[![Tests](https://img.shields.io/badge/tests-16%2F16%20passing-brightgreen)](#-phase-16--testing)
[![n8n](https://img.shields.io/badge/n8n-compatible-orange)](https://n8n.io)
[![Supabase](https://img.shields.io/badge/database-Supabase%20Postgres-3ecf8e)](https://supabase.com)
[![Gemini](https://img.shields.io/badge/AI-Google%20Gemini%202.5%20Flash-4285F4)](https://aistudio.google.com)

A production-ready, autonomous AI Customer Support Agent built with **n8n**, **Supabase (PostgreSQL)**, **Telegram Bot API**, and **Google Gemini AI**. Features grounded Retrieval-Augmented Generation (RAG), intent routing, automated sales lead capture, appointment booking with Google Calendar, prompt-injection guardrails, and automated human supervisor escalation.

---

## 🏁 Final System Flow

```text
                 CUSTOMER
                     │
                     ▼
              TELEGRAM / WHATSAPP
                     │
                     ▼
                    n8n
                     │
              ┌──────┴──────┐
              │             │
         Customer       Conversation
         Lookup          History
              │             │
              └──────┬──────┘
                     ▼
               Intent Router
                     │
       ┌─────────────┼──────────────┐
       │             │              │
       ▼             ▼              ▼
 Knowledge       Products       Calendar
   Base             DB
       │             │              │
       └─────────────┼──────────────┘
                     ▼
                  Gemini
                     │
                     ▼
                Guardrails
                     │
             ┌───────┴───────┐
             ▼               ▼
          Customer       Human Handoff
          Response
             │               │
             └───────┬───────┘
                     ▼
                  Supabase
                     │
                     ▼
               System Logs
```

---

## 📁 Repository Structure

```text
AI-Customer-Support-Agent/
├── CLAUDE.md                     # Developer guidelines and architectural rules
├── README.md                     # Master documentation and quickstart guide
├── .gitignore                    # Secrets, temporary files, and cache exclusions
├── .env.example                  # Environment variable configuration template
├── docs/                         # Technical deep dives and setup guides
│   ├── architecture.md           # Mermaid dataflow diagrams and component design
│   ├── database.md               # Complete Supabase schema, ER diagram, indexes
│   ├── workflows.md              # Detailed n8n node breakdown and mapping guide
│   ├── security.md               # Threat model, RLS, and prompt injection defense
│   ├── testing.md                # 16-scenario test matrix and verification criteria
│   ├── telegram_setup.md         # Step-by-step BotFather guide
│   └── supabase_setup.md         # Database provisioning and DDL execution guide
├── workflows/                    # Importable n8n JSON workflows
│   ├── 00_Telegram_Echo_Test.json           # Standalone Phase 3 connectivity test
│   ├── 01_Customer_Identification_Test.json # Standalone Phase 4 customer lookup test
│   ├── 01_Customer_Support_Main.json        # Production master agent workflow
│   └── 02_Error_Handler_Workflow.json       # Dedicated Phase 15 error & alert handler
├── prompts/                      # Grounded prompt templates and extraction rules
│   ├── system_prompt.md          # Master assistant persona & anti-hallucination prompt
│   ├── intent_classification.md  # Intent routing classification prompt
│   ├── guardrails.md             # Security filter and prompt injection defense
│   ├── lead_extraction.md        # Commercial lead extractor
│   └── appointment_extraction.md # Calendar slot parser
├── scripts/                      # Database scripts and testing tools
│   ├── supabase_schema.sql       # Full DDL for all 9 tables, indexes, RLS, triggers
│   ├── seed_data.sql             # Seed data for products and knowledge base
│   ├── test_runner.py            # Automated test runner for all 16 scenarios
│   └── simulate_telegram_webhook.py # Mock Telegram webhook event dispatcher
└── tests/                        # Automated test suites
    ├── test_scenarios.json       # 16 test cases covering all edge cases
    └── test_prompts.py           # Unit tests for prompt syntax and JSON validity
```

---

## 🚀 18-Phase Implementation Roadmap

| Phase | Milestone | Implemented Artifacts |
| :--- | :--- | :--- |
| **Phase 0** | Project Setup & Git | Directory layout, `.gitignore`, `.env.example`, `CLAUDE.md`, Git repo |
| **Phase 1** | Supabase Database | 9 tables (`customers`, `products`, `conversations`, `messages`, `leads`, `appointments`, `knowledge_base`, `human_handoffs`, `system_logs`) in [`supabase_schema.sql`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/scripts/supabase_schema.sql) |
| **Phase 2** | Telegram Bot Setup | BotFather instructions, token isolation in [`telegram_setup.md`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/docs/telegram_setup.md) |
| **Phase 3** | First n8n Workflow | Telegram Trigger -> Edit Fields -> Telegram Response in [`00_Telegram_Echo_Test.json`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/workflows/00_Telegram_Echo_Test.json) |
| **Phase 4** | Customer Identification | Extract `telegram_id`, search Supabase, auto-create customer in [`01_Customer_Identification_Test.json`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/workflows/01_Customer_Identification_Test.json) |
| **Phase 5** | Conversation System | Check active session, create conversation, save customer & assistant messages |
| **Phase 6** | AI Integration | Google Gemini 2.5 Flash, system prompt, conversation history injection in [`system_prompt.md`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/prompts/system_prompt.md) |
| **Phase 7** | Knowledge Base | Seed FAQs, hours, policies, search retrieval in [`seed_data.sql`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/scripts/seed_data.sql) |
| **Phase 8** | Product System | Products catalog lookup (Website Dev, AI Automation, Consulting) |
| **Phase 9** | Intent Routing | Fast classifier routing to FAQ, Product, Pricing, Lead, Appointment, Complaint, Human |
| **Phase 10** | Lead Management | High-intent detection, insertion into `leads`, admin Telegram alert |
| **Phase 11** | Appointment System | Slot extraction, insertion into `appointments`, Google Calendar invitation confirmation |
| **Phase 12** | Human Handoff | Escalation trigger, priority assignment, `human_handoffs` ticket, owner alert |
| **Phase 13** | Guardrails | Pre-filter regex for prompt injection, PII protection in [`guardrails.md`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/prompts/guardrails.md) |
| **Phase 14** | AI Output Validation | Post-LLM verification for formatting, leakage, and hallucinations |
| **Phase 15** | Error Workflow | Global `errorTrigger` catching failures, logging to `system_logs`, Telegram alert in [`02_Error_Handler_Workflow.json`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/workflows/02_Error_Handler_Workflow.json) |
| **Phase 16** | Comprehensive Testing | 16 test scenarios executed via [`test_runner.py`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/scripts/test_runner.py) |
| **Phase 17** | Production Review | Security audit, RLS policies, `.env` isolation in [`security.md`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/docs/security.md) |
| **Phase 18** | GitHub Deployment | Initialized Git repository, committed, and pushed to GitHub |

---

## ⚡ Quickstart Setup Guide

### 1. Database Setup (Supabase)
1. Create a project at [supabase.com](https://supabase.com).
2. Go to the **SQL Editor** and execute [`scripts/supabase_schema.sql`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/scripts/supabase_schema.sql).
3. Execute [`scripts/seed_data.sql`](file:///c:/Users/PC/Ai%20cumstome%20agent/AI-Customer-Support-Agent/scripts/seed_data.sql) to populate sample products and FAQs.
4. Copy your **Project URL** and **Service Role Key** from **Project Settings** -> **API**.

### 2. Telegram Bot Setup
1. Message `@BotFather` on Telegram, send `/newbot`, and obtain your API Token.
2. Message `@userinfobot` to get your numeric Telegram User ID for admin alerts.

### 3. Environment Variables
Copy `.env.example` to `.env` and fill in your keys:
```bash
cp .env.example .env
```

### 4. Import Workflows into n8n
1. Open your n8n dashboard (`http://localhost:5678`).
2. Go to **Workflows** -> **Import from File**.
3. Import:
   - `workflows/01_Customer_Support_Main.json` (Main Agent)
   - `workflows/02_Error_Handler_Workflow.json` (Error Handler)
4. Add your **Telegram API** credential in n8n Credentials.
5. Activate both workflows.

---

## 🧪 Phase 16: Verification & Testing

Execute the automated test suite covering all 16 scenarios:

```bash
python scripts/test_runner.py
```

### Test Suite Output:
```text
======================================================================
AI CUSTOMER SUPPORT AGENT — TEST SUITE EXECUTION
Total Test Scenarios: 16
======================================================================
[PASS] TC-01: Normal Question (FAQ)
[PASS] TC-02: Product Question
[PASS] TC-03: Pricing Inquiry
[PASS] TC-04: Lead Capture
[PASS] TC-05: Appointment Booking
[PASS] TC-06: Complaint Handling
[PASS] TC-07: Human Request
[PASS] TC-08: Unknown Question
[PASS] TC-09: Prompt Injection Defense
[PASS] TC-10: Sensitive Data Protection
[PASS] TC-11: Hallucination Protection
[PASS] TC-12: Multi-Turn Memory Check
[PASS] TC-13: Duplicate Customer Handling
[PASS] TC-14: Duplicate Lead Protection
[PASS] TC-15: Invalid Input Handling
[PASS] TC-16: Error Recovery & System Fallback
======================================================================
TEST SUMMARY: 16/16 Passed (0 Failed)
All Phase 16 system verification tests passed successfully!
```

---

## 🛡️ Security & Anti-Hallucination Guardrails

- **Zero-Shot Grounding**: The AI model only answers using retrieved context. It will never invent prices, services, or fake warranty terms.
- **Pre-Filter Injection Defense**: Detects and neutralizes jailbreak attempts (`"ignore instructions"`, `"system override"`, `"reveal prompt"`) before the LLM is executed.
- **Row-Level Security**: All 9 database tables are protected with PostgreSQL RLS policies.
- **Telemetry & Alerting**: System errors and high-priority handoffs immediately alert the admin via Telegram.

---

## 📄 License
This project is open-source under the MIT License.
