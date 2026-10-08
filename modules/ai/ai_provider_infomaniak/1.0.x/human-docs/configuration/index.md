# Configuration

Configuring this provider has two parts: give Drupal your Infomaniak API key and
pick a model, then choose Infomaniak for the operations you want.

## Step 1 — Store the API key as a Key

Keep the key out of exported configuration. On this project the convention is to
hold secrets in an environment variable and reference them through a **Key**
entity.

1. Save the value into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --infomaniak-api-key=<value>
   ddev restart
   ```

   The flag `--infomaniak-api-key` becomes the environment variable
   `INFOMANIAK_API_KEY` inside the web container.

2. Create a Key entity that reads that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key** — **Authentication** key
   type, **Environment** key provider, pointing at `INFOMANIAK_API_KEY`.

## Step 2 — Register Infomaniak as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`).
2. Find **Infomaniak** in the list and open its settings.
3. Select the **Key** you created in Step 1 as the API credential.
4. Use the **model-list autocomplete** to choose the Infomaniak model(s) you
   intend to use.
5. Save.

## Step 3 — Choose Infomaniak for AI operations

Open the AI module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select **Infomaniak** as the provider for the
operation types you want it to serve (for example chat).

## A note on cost and data

Every prompt sent to Infomaniak incurs cost and sends your content off-site. Set a
spending limit at the vendor, and treat unpublished or personal data in prompts as
a disclosure — Infomaniak's Swiss processing may help with residency requirements,
but confirm the specifics against their terms.
