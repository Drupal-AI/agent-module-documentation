# Configuration

Configuring this provider has three parts: create the gateway in Cloudflare,
store your Cloudflare API token securely, then point Drupal at the gateway and
choose it for AI operations.

## Step 1 — Create the AI Gateway in Cloudflare

In your Cloudflare dashboard, create an **AI Gateway** (under AI → AI Gateway).
Note two identifiers you will need in Drupal:

- your **account ID**, and
- the **gateway ID** (the name/slug of the gateway you created).

Create or reuse a Cloudflare **API token** with permission to use the AI Gateway.

## Step 2 — Store the API token as a Key

Keep the token out of exported configuration. On this project the convention is
to hold secrets in an environment variable and reference them through a **Key**
entity.

1. Save the value into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --cloudflare-api-token=<value>
   ddev restart
   ```

   The flag `--cloudflare-api-token` becomes the environment variable
   `CLOUDFLARE_API_TOKEN` inside the web container.

2. Create a Key entity that reads that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key** — **Authentication** key
   type, **Environment** key provider, pointing at `CLOUDFLARE_API_TOKEN`.

## Step 3 — Register the gateway as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`).
2. Find the **Cloudflare AI Gateway** provider and open its settings.
3. Enter your **account ID** and **gateway ID** from Step 1.
4. Select the **Key** you created in Step 2 as the API token.
5. Save.

## Step 4 — Choose it for AI operations

Open the AI module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select the **Cloudflare AI Gateway** as the
provider for the operation types you want it to serve (for example chat).

## What the gateway gives you

Because traffic flows through Cloudflare, repeated requests can be served from the
gateway cache, you can apply rate limits, and you get usage analytics in the
Cloudflare dashboard. Note that prompts still leave your site, and any upstream
model behind the gateway still incurs its own cost.
