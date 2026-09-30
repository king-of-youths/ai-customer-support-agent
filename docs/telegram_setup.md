# Telegram Bot Setup Guide (Phase 2, Step 14)

## 1. Create Your Telegram Bot via @BotFather

1. Open Telegram and search for `@BotFather` (verified account with blue checkmark).
2. Start the chat by sending `/start`.
3. Create a new bot by sending:
   ```text
   /newbot
   ```
4. Choose a display name:
   ```text
   AI Customer Support Agent
   ```
5. Choose a unique username ending in `bot` (for example: `ApexCustomerSupport_bot`).
6. BotFather will provide an HTTP API Token in this format:
   ```text
   1234567890:ABCdefGhIJKlmNoPQRsTUVwxyZ
   ```
7. Copy this token immediately and paste it into `.env`:
   ```bash
   TELEGRAM_BOT_TOKEN="1234567890:ABCdefGhIJKlmNoPQRsTUVwxyZ"
   ```

---

## 2. Obtain Your Admin Telegram Chat ID (For Alerts)

To receive real-time notifications for leads, complaints, and human handoffs:
1. Search for `@userinfobot` on Telegram and click **Start**.
2. The bot will reply with your personal numeric ID (e.g. `987654321`).
3. Add this ID to `.env`:
   ```bash
   TELEGRAM_ADMIN_CHAT_ID="987654321"
   ```

---

## 3. Configuring Telegram in n8n

1. Open your n8n web interface (`http://localhost:5678` or hosted instance).
2. Navigate to **Credentials** -> **New Credential** -> Select **Telegram API**.
3. Name it: `Telegram Bot Account`.
4. Paste your `TELEGRAM_BOT_TOKEN`.
5. Click **Save**.
6. When importing the workflow `01_Customer_Support_Main.json`, n8n will bind the Telegram Trigger and response nodes to this credential automatically.
