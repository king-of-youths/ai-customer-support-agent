-- ====================================================================
-- AI Customer Support Agent - Seed Data
-- Populates initial Products and Knowledge Base entries (Steps 28 & 30)
-- ====================================================================

-- --------------------------------------------------------------------
-- Seed Products (Step 30)
-- --------------------------------------------------------------------
INSERT INTO products (name, description, price, currency, features, category, availability, status)
VALUES
(
    'Website Development',
    'Custom high-performance web applications built with modern frameworks, tailored responsive design, and SEO optimization.',
    1499.00,
    'USD',
    '["Responsive design across all devices", "Up to 5 custom pages", "Contact and booking forms", "SEO and Google Analytics setup", "Fast page load optimization", "30 days post-launch warranty"]'::jsonb,
    'Development',
    true,
    'active'
),
(
    'AI Automation',
    'End-to-end intelligent workflow automation using n8n, Google Gemini LLMs, and API integrations for customer support and sales.',
    2999.00,
    'USD',
    '["Multi-channel support (Telegram, WhatsApp, Web)", "Custom Knowledge Base RAG integration", "Automated lead capture & CRM syncing", "Google Calendar appointment booking", "Automated human escalation protocols", "60 days maintenance and tuning"]'::jsonb,
    'Automation',
    true,
    'active'
),
(
    'Consulting',
    'Dedicated 1-on-1 strategic consulting and architectural advisory for AI integration, technology stack selection, and automation roadmap.',
    499.00,
    'USD',
    '["60-minute deep-dive video session", "Architecture and security review", "Tailored step-by-step implementation roadmap", "Recommended toolchain and prompt templates", "1 week email follow-up Q&A"]'::jsonb,
    'Advisory',
    true,
    'active'
)
ON CONFLICT DO NOTHING;

-- --------------------------------------------------------------------
-- Seed Knowledge Base Entries (Step 28)
-- --------------------------------------------------------------------
INSERT INTO knowledge_base (title, content, category, source, status)
VALUES
(
    'Company Overview & Mission',
    'Apex Solutions is a modern technology consultancy specializing in enterprise AI automation, autonomous customer support agents, and modern cloud application development. We empower businesses to operate 24/7 with zero human latency while maintaining exceptional customer satisfaction.',
    'company',
    'official_docs',
    'active'
),
(
    'Operating Hours & Availability',
    'Our standard customer support and engineering operating hours are Monday through Friday from 9:00 AM to 6:00 PM Eastern Standard Time (EST). Automated AI support is active 24/7/365. For critical outages or enterprise emergency tier clients, on-call engineers respond within 30 minutes.',
    'operations',
    'official_docs',
    'active'
),
(
    'Contact Information & Channels',
    'You can reach our team via:
- Telegram: Official bot channel (@ApexSupportBot)
- Email: support@apexsolutions.example.com
- Sales: sales@apexsolutions.example.com
- Phone: +1 (555) 019-2834 (Monday-Friday during office hours)
- Office Address: 100 Innovation Way, Suite 400, New York, NY 10001',
    'contact',
    'official_docs',
    'active'
),
(
    'Pricing & Payment Methods',
    'We maintain transparent fixed pricing for our core packages:
- Website Development: $1,499 USD
- AI Automation: $2,999 USD
- Consulting Session: $499 USD
Custom enterprise engagements are scoped individually. We accept major Credit/Debit Cards via Stripe, ACH / SEPA Bank Wire Transfers, and Cryptocurrency payments in USDC / USDT.',
    'pricing',
    'official_docs',
    'active'
),
(
    'Refund & Satisfaction Policy',
    'We provide a 14-day 100% money-back satisfaction guarantee on all service kickoff packages if no development milestones or architecture deliverables have been handed over. Once engineering sprints or custom code development has commenced, fees for completed milestones are non-refundable. Consultation sessions can be rescheduled up to 24 hours prior to the booked time without penalty.',
    'policy',
    'official_docs',
    'active'
),
(
    'Consultation & Booking Protocol',
    'Consultations can be booked directly through our Telegram assistant or via Google Calendar. Sessions are conducted via Google Meet, lasting 30 to 60 minutes. Booking slots are open Monday through Friday between 10:00 AM and 5:00 PM EST. Customers receive an automated calendar invitation with the meeting link upon confirmation.',
    'booking',
    'official_docs',
    'active'
),
(
    'Human Escalation Protocol',
    'Whenever a customer expresses frustration, reports an unresolved dispute, requests a human supervisor, or asks a technical question outside our documented knowledge base, our AI assistant immediately initiates a human handoff. The customer is politely acknowledged, and a ticket is dispatched to an engineering manager who replies within 2 business hours.',
    'support',
    'official_docs',
    'active'
)
ON CONFLICT DO NOTHING;
