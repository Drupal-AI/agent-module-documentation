# Configuration

Configuring this provider has two parts: give Drupal the Dropsolid AI endpoint
and API key, then choose Dropsolid AI for the operations you want.

## Step 1 — Store the API key as a Key

Keep the key out of exported configuration and out of code. On this project the
convention is to hold secrets in an environment variable and reference them
through a **Key** entity, always over HTTPS.

1. Save the value into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --dropsolid-ai-key=<value>
   ddev restart
   ```

   The flag `--dropsolid-ai-key` becomes the environment variable
   `DROPSOLID_AI_KEY` inside the web container.

2. Create a Key entity that reads that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key** — **Authentication** key
   type, **Environment** key provider, pointing at `DROPSOLID_AI_KEY`.

## Step 2 — Register Dropsolid AI as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`).
2. Find **Dropsolid AI** in the list and open its settings.
3. Enter the **Dropsolid AI endpoint** (the base URL of the LiteLLM proxy you
   were given).
4. Select the **Key** you created in Step 1 as the API credential.
5. Save.

## Step 3 — Choose Dropsolid AI for AI operations

Open the AI module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select **Dropsolid AI** as the provider for the
operation types you want it to serve.

## A note on data

Prompt content is sent to the Dropsolid endpoint (external egress) — confirm that
is acceptable for the content involved, and treat unpublished or personal data in
prompts as a disclosure to a third party.
