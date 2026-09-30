# Lead Information Extraction Prompt

## Task
Extract actionable lead qualification details from the customer message and conversation context to record into the `leads` table and alert the sales team.

## Extraction Fields
- `product_name`: Target service/product mentioned (e.g. "AI Automation", "Website Development", "Consulting", or "General").
- `interest`: Summary of the client's business requirement or goal.
- `budget`: Mentioned budget or tier (or null if not provided).
- `timeline`: Urgency or target launch date (or null).
- `missing_fields`: Array of required fields still missing to finalize proposal (e.g. `["email", "phone"]`).

## Output Schema
```json
{
  "product_name": "AI Automation",
  "interest": "Client wants to automate customer support on Telegram with n8n and LLM",
  "budget": "$3000",
  "timeline": "ASAP / within 2 weeks",
  "notes": "E-commerce store owner experiencing 500+ messages daily",
  "missing_fields": ["email"]
}
```
