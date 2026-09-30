# n8n Workflows Documentation

## 1. Overview of Workflow Artifacts

This repository includes three ready-to-import n8n workflow configurations:

| File | Purpose | Corresponding Phase |
| :--- | :--- | :--- |
| `00_Telegram_Echo_Test.json` | Standalone connection verification test | Phase 3 (Steps 15–17) |
| `01_Customer_Identification_Test.json` | Standalone customer detection and creation test | Phase 4 (Steps 18–21) |
| `01_Customer_Support_Main.json` | Complete production support agent | Phases 4–14 (Steps 18–52) |
| `02_Error_Handler_Workflow.json` | Global exception catching and alerting | Phase 15 (Steps 53–55) |

---

## 2. Main Production Workflow Walkthrough (`01_Customer_Support_Main.json`)

### Step 1: Ingestion & Identification (Nodes 1–10)
1. **Telegram Trigger**: Receives incoming message event.
2. **Extract Customer Information**: Normalizes fields (`telegram_id`, `customer_name`, `message_text`, `chat_id`).
3. **Guardrails Pre-Filter**: Runs regex checks against prompt injection and sensitive data exfiltration attempts.
4. **Guardrail Violation?**:
   - `True`: Immediately routes to **Security Guardrail Response** and ends pipeline without querying LLM.
   - `False`: Proceeds to database lookup.
5. **Search Supabase Customer**: Queries `/rest/v1/customers?telegram_id=eq.{id}`.
6. **Customer Exists?**:
   - `True`: Attaches existing `customer_id`.
   - `False`: Calls `POST /rest/v1/customers` to register new customer.

### Step 2: Session & Message Ledger (Nodes 11–17)
7. **Check Active Conversation**: Looks up open session for customer in `conversations`.
8. **Conversation Exists?**: Re-uses existing session or creates a new one.
9. **Save Incoming Message**: Records customer input into `messages` table with `sender_type = 'customer'`.
10. **Get Conversation History**: Retrieves up to 6 recent messages in the current conversation for multi-turn context.

### Step 3: Intent Classification & Routing (Nodes 18–19)
11. **Detect Intent & Format Context**: Classifies user query into one of:
    - `Human`
    - `Complaint`
    - `Appointment`
    - `Lead`
    - `Product`
    - `Pricing`
    - `FAQ` (Fallback)
12. **Intent Router (Switch Node)**: Routes execution to the appropriate specialized pipeline.

### Step 4: Specialized Pipelines
- **Human / Complaint**:
  - `POST /rest/v1/human_handoffs` creates escalation ticket.
  - Sends high-priority alert to owner Telegram chat.
  - Returns polite acknowledgment to customer.
- **Lead Capture**:
  - `POST /rest/v1/leads` registers prospect interest.
  - Sends immediate lead notification to owner Telegram chat.
  - Passes into product catalog lookup for tailored response.
- **Appointment Booking**:
  - `POST /rest/v1/appointments` records booking slot.
  - Returns friendly confirmation with meeting details.
- **Product / Pricing / FAQ**:
  - Fetches product specs or knowledge base entries from Supabase.
  - Assembles prompt with strict anti-hallucination rules.
  - Invokes Google Gemini 2.5 Flash via REST API.

### Step 5: Output Validation & Dispatch (Nodes 31–35)
13. **Validate AI Output**: Evaluates output for format integrity, prompt leakage, and safety.
14. **Save AI Response**: Persists response in `messages` table with `sender_type = 'assistant'`.
15. **Send Telegram Response**: Delivers message to customer in formatted Markdown.

---

## 3. Dedicated Error Handling Workflow (`02_Error_Handler_Workflow.json`)

- Triggered automatically via n8n's **Error Trigger** whenever any workflow node fails.
- Logs failure details into `system_logs` in Supabase (`workflow`, `error_message`, `last_node`, `execution_id`).
- Fires an alert directly to the administrator's Telegram chat with error context for rapid diagnosis.
