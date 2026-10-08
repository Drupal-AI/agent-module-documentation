# Configuration

Langdock has its own settings form where you supply the connection details and API
key. Store the key as a secret rather than pasting it into exported configuration.

## Step 1 — Store the API key as a Key

On this project the convention is to hold secrets in an environment variable and
reference them through a **Key** entity. If the Key module is not yet enabled,
`composer require drupal/key` and `drush en key -y` first.

1. Save the value into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --langdock-api-key=<value>
   ddev restart
   ```

   The flag `--langdock-api-key` becomes the environment variable
   `LANGDOCK_API_KEY` inside the web container.

2. Create a Key entity that reads that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key** — **Authentication** key
   type, **Environment** key provider, pointing at `LANGDOCK_API_KEY`.

## Step 2 — Configure the Langdock provider

1. Open the Langdock provider settings form, reached from **Configuration → AI**
   (`/admin/config/ai`) under the provider settings (route
   `ai_provider_langdock.settings_form`).
2. Enter the **Langdock connection** details and select (or paste, if the form
   requires it) the **API key** — prefer the Key entity created in Step 1.
3. Save.

## Step 3 — Choose Langdock for AI operations

Open the AI module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select **Langdock** as the provider for the
operation types you want it to serve.

## A note on data

Content sent to the Langdock API leaves the site. Handle sensitive prompts —
unpublished material, personal data — accordingly, and keep the API key out of
exported configuration and code.
