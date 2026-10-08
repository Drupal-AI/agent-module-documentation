# Configuration

Configuring this provider has two parts: give Drupal your DXPR credentials, then
choose DXPR for the operations you want.

## Step 1 — Store DXPR credentials as a Key

Keep the credentials out of exported configuration. On this project the
convention is to hold secrets in an environment variable and reference them
through a **Key** entity.

1. Save the value into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --dxpr-ai-key=<value>
   ddev restart
   ```

   The flag `--dxpr-ai-key` becomes the environment variable `DXPR_AI_KEY` inside
   the web container.

2. Create a Key entity that reads that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key** — **Authentication** key
   type, **Environment** key provider, pointing at `DXPR_AI_KEY`.

## Step 2 — Register DXPR as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`).
2. Find **DXPR** in the list and open its settings.
3. Select the **Key** you created in Step 1 as the DXPR credential.
4. Save.

## Step 3 — Choose DXPR for AI operations

Open the AI module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select **DXPR** as the provider for the
operation types you want it to serve.

## A note on data governance

Content sent to DXPR leaves your infrastructure. Send only content you are
comfortable sharing with DXPR, and apply your usual governance to confidential or
personal material before it goes into a prompt.
