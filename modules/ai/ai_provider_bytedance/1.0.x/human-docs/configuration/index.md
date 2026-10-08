# Configuration

Configuring this provider has two parts: give Drupal your ModelArk API key, then
tell the AI module to use ByteDance for the operations you want.

## Step 1 — Store the API key as a Key

Keep the ModelArk key out of exported configuration. On this project the
convention is to hold secrets in an environment variable and reference them
through a **Key** entity.

1. Save the value into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --bytedance-api-key=<value>
   ddev restart
   ```

   The flag `--bytedance-api-key` becomes the environment variable
   `BYTEDANCE_API_KEY` inside the web container.

2. Create a Key entity that reads that variable. Go to **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key**, choose the
   **Authentication** key type and the **Environment** key provider, and point it
   at `BYTEDANCE_API_KEY`. (If the Key module is not yet enabled, run
   `composer require drupal/key` and `drush en key -y` first.)

## Step 2 — Register ByteDance as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`).
2. Find **ByteDance** in the list and open its settings.
3. Select the **Key** you created in Step 1 as the API credential.
4. If the form offers a model or endpoint selection, choose the ModelArk model(s)
   you intend to use.
5. Save.

## Step 3 — Choose ByteDance for AI operations

Open the AI module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select **ByteDance** as the provider for the
operation types you want it to serve (for example chat).

## A note on cost and data

Every prompt sent to ByteDance ModelArk incurs cost and sends your content
off-site to a third-party processor. Set a spending limit at the vendor, and
treat unpublished or personal data in prompts as a disclosure.
