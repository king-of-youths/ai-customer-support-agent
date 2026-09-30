# Supabase Database Setup Guide (Phase 1, Step 4)

## 1. Create a Supabase Project

1. Navigate to [Supabase](https://supabase.com) and sign in.
2. Click **New Project**.
3. Set the project details:
   - **Name**: `AI Customer Support Agent`
   - **Database Password**: Generate a secure password and save it in a safe place.
   - **Region**: Select the region geographically closest to your users or n8n server.
4. Click **Create new project** and wait ~2 minutes for provisioning to complete.

---

## 2. Execute SQL Migrations (Steps 5–13)

1. In your Supabase Dashboard, open the left sidebar and click **SQL Editor**.
2. Click **New Query**.
3. Open `scripts/supabase_schema.sql` from this repository, copy the full contents, and paste it into the Supabase SQL editor.
4. Click **Run** (or press `Ctrl+Enter` / `Cmd+Enter`).
5. Verify that the output shows `Success. No rows returned`.
6. Open **Table Editor** in the left sidebar to confirm all 9 tables have been created:
   - `customers`
   - `products`
   - `conversations`
   - `messages`
   - `leads`
   - `appointments`
   - `knowledge_base`
   - `human_handoffs`
   - `system_logs`

---

## 3. Seed Initial Products and Knowledge Base (Steps 28 & 30)

1. In the **SQL Editor**, click **New Query**.
2. Open `scripts/seed_data.sql` from this repository, copy the full contents, and paste it into the editor.
3. Click **Run**.
4. Check `products` and `knowledge_base` tables in the Table Editor to confirm the sample records are visible.

---

## 4. Obtain API Credentials

1. In your Supabase project dashboard, navigate to **Project Settings** (gear icon) -> **API**.
2. Copy the following values into your `.env` file:
   - **Project URL**:
     ```bash
     SUPABASE_URL="https://your-project-id.supabase.co"
     ```
   - **Project API Keys** -> `anon` `public`:
     ```bash
     SUPABASE_ANON_KEY="eyJhbGciOi..."
     ```
   - **Project API Keys** -> `service_role` `secret`:
     ```bash
     SUPABASE_SERVICE_ROLE_KEY="eyJhbGciOi..."
     ```

> [!WARNING]
> Keep `SUPABASE_SERVICE_ROLE_KEY` secret. It has full admin privileges that bypass Row Level Security. Only use it inside n8n workflows and secure backend environments.
