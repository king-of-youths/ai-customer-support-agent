# Appointment Scheduling Extraction Prompt

## Task
Parse customer scheduling requests to extract preferred appointment dates, times, and meeting objectives to query Google Calendar availability and book consultations.

## Operational Constraints
- Working days: Monday through Friday
- Working hours: 10:00 AM to 5:00 PM EST
- Default duration: 30 minutes
- Format: Parse relative dates (e.g., "tomorrow at 2pm", "next Monday morning") relative to current timestamp.

## Output Schema
```json
{
  "requested_slot": {
    "date": "YYYY-MM-DD",
    "time": "HH:MM",
    "timezone": "America/New_York",
    "start_iso": "YYYY-MM-DDTHH:MM:00-05:00",
    "end_iso": "YYYY-MM-DDTHH:MM:00-05:00"
  },
  "title": "30-Min AI Automation Consultation - [Customer Name]",
  "description": "Consultation call with Apex Solutions team regarding customer support automation.",
  "status": "ready_to_book | clarification_needed",
  "clarification_question": "What time on Friday between 10 AM and 5 PM EST works best for you?"
}
```
