# Configuration

Configuring this provider has two parts: give Drupal the details of your Bifrost
gateway (its URL and credential), then tell the AI module to use Bifrost for the
operations you want.

## Step 1 — Store the gateway credential as a Key

Never paste the gateway credential straight into a settings form that gets
exported to configuration. On this project the convention is to keep secrets in
an environment variable and reference them through a **Key** entity.

1. Save the value into DDEV's dotenv file (this does not commit it):

   ```bash
   ddev dotenv set .ddev/.env --bifrost-api-key=<value>
   ddev restart
   ```

   The flag `--bifrost-api-key` becomes the environment variable
   `BIFROST_API_KEY` inside the web container.

2. Create a Key entity that reads that variable. Go to **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key**, choose the
   **Authentication** key type and the **Environment** key provider, and point it
   at `BIFROST_API_KEY`. (The same can be done with `drush key:save`.)

## Step 2 — Register Bifrost as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`).
2. Find **Bifrost** in the list and open its settings.
3. Enter the **gateway URL** — the base endpoint of your Bifrost deployment that
   Drupal should send requests to.
4. Select the **Key** you created in Step 1 as the credential.
5. Save.

## Step 3 — Choose Bifrost for AI operations

Registering the provider does not by itself make anything use it. Open the AI
module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select **Bifrost** as the provider for the
operation types you want it to serve (for example chat). Because model routing
happens at the gateway, the specific model you get is decided by your Bifrost
configuration rather than in Drupal.

## A note on cost and data

Every prompt sent through Bifrost reaches the gateway and its upstream models,
which incurs cost and sends your content off-site. Set spending limits at the
gateway, and treat unpublished or personal data in prompts as a disclosure to a
third party.
