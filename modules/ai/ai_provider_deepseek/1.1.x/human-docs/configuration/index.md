# Configuration

Before configuring anything, settle the **jurisdiction question**: DeepSeek's
hosted API processes in China, so confirm that sending your prompts there is
acceptable under your data-protection and data-residency obligations. If it is
not, plan to point the provider at a self-hosted deployment of the open-weight
models instead.

Configuration then has two parts: give Drupal your API key, and choose DeepSeek
for the operations you want.

## Step 1 — Store the API key as a Key

Keep the key out of exported configuration. On this project the convention is to
hold secrets in an environment variable and reference them through a **Key**
entity.

1. Save the value into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --deepseek-api-key=<value>
   ddev restart
   ```

   The flag `--deepseek-api-key` becomes the environment variable
   `DEEPSEEK_API_KEY` inside the web container.

2. Create a Key entity that reads that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key** — **Authentication** key
   type, **Environment** key provider, pointing at `DEEPSEEK_API_KEY`.

## Step 2 — Register DeepSeek as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`).
2. Find **DeepSeek** in the list and open its settings.
3. Select the **Key** you created in Step 1 as the API credential. If you are
   self-hosting, set the base URL / endpoint to your own deployment where the form
   allows.
4. Save.

## Step 3 — Choose DeepSeek for AI operations

Open the AI module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select **DeepSeek** as the provider for the
operation types you want it to serve.

## The three standing points

- **The key is a spending credential** — set a limit at the provider and watch
  it.
- **A prompt is a disclosure** — with DeepSeek's hosted API the destination is
  China; treat unpublished or personal data accordingly.
- **A pinned model needs a plan** — decide what the site does when a model
  changes; because the weights are open, moving to self-hosted inference is a real
  fallback here.
