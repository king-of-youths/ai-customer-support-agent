# Intent Classification Prompt

## Task
Analyze the incoming customer message and classify its primary intent into exactly one of the supported categories.

## Allowed Categories
- `FAQ`: General questions about company background, operational hours, contact details, standard policies, or services overview.
- `Product`: Questions about specific offerings, technical features, stack, capabilities, or package inclusions.
- `Pricing`: Direct questions regarding service costs, pricing tiers, payment methods, or currency.
- `Lead`: Expressions of clear buying intent, wanting to hire us, requesting a proposal/quote, or asking to get started.
- `Appointment`: Inquiries asking to schedule, book a call, check consultation availability, or meet with our team.
- `Complaint`: Dissatisfaction, complaints about delays, bugs, billing disputes, or negative feedback.
- `Human`: Explicit requests to speak to a real person, human agent, manager, or supervisor.
- `Unknown`: Unintelligible messages, off-topic gibberish, spam, or ambiguous text.

---

## Output Format
Return ONLY a valid JSON object matching this schema without any markdown formatting or surrounding backticks:

```json
{
  "intent": "FAQ | Product | Pricing | Lead | Appointment | Complaint | Human | Unknown",
  "confidence": 0.95,
  "reasoning": "Brief explanation of why this intent was selected",
  "entities": {
    "product_name": "AI Automation | Website Development | Consulting | null",
    "requested_time": "ISO date string or human string or null",
    "urgency": "low | medium | high",
    "sentiment": "positive | neutral | negative"
  }
}
```

---

## Few-Shot Reference Examples

1. **User**: "What are your business hours on Friday?"
   ```json
   {
     "intent": "FAQ",
     "confidence": 0.99,
     "reasoning": "Inquiring about business operational hours.",
     "entities": { "product_name": null, "requested_time": null, "urgency": "low", "sentiment": "neutral" }
   }
   ```

2. **User**: "How much do you charge for the AI Automation service?"
   ```json
   {
     "intent": "Pricing",
     "confidence": 0.98,
     "reasoning": "Direct inquiry regarding pricing for a specific package.",
     "entities": { "product_name": "AI Automation", "requested_time": null, "urgency": "medium", "sentiment": "neutral" }
   }
   ```

3. **User**: "I need this automation for my e-commerce store. Can we get started today?"
   ```json
   {
     "intent": "Lead",
     "confidence": 0.96,
     "reasoning": "Customer expresses direct buying intent and urgency to commence.",
     "entities": { "product_name": "AI Automation", "requested_time": null, "urgency": "high", "sentiment": "positive" }
   }
   ```

4. **User**: "Can I schedule a 30-minute consultation call tomorrow at 2 PM?"
   ```json
   {
     "intent": "Appointment",
     "confidence": 0.99,
     "reasoning": "Explicit booking request with date and time.",
     "entities": { "product_name": null, "requested_time": "tomorrow at 2 PM", "urgency": "medium", "sentiment": "neutral" }
   }
   ```

5. **User**: "Stop giving me robotic answers. I need to talk to a real person immediately."
   ```json
   {
     "intent": "Human",
     "confidence": 1.0,
     "reasoning": "Explicit escalation request demanding human operator.",
     "entities": { "product_name": null, "requested_time": null, "urgency": "high", "sentiment": "negative" }
   }
   ```
