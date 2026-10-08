# Configuration

Huggingface Provider has its own settings form where you supply the API token.
Store the token securely rather than pasting it into exported configuration.

## Step 1 — Get a Hugging Face access token

In your Hugging Face account, create an **access token** (under Settings → Access
Tokens) with permission to call the Inference API. Copy the token.

## Step 2 — Store the token as a Key

On this project the convention is to hold secrets in an environment variable and
reference them through a **Key** entity.

1. Save the value into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --huggingface-token=<value>
   ddev restart
   ```

   The flag `--huggingface-token` becomes the environment variable
   `HUGGINGFACE_TOKEN` inside the web container.

2. Create a Key entity that reads that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key** — **Authentication** key
   type, **Environment** key provider, pointing at `HUGGINGFACE_TOKEN`.

## Step 3 — Configure the Hugging Face provider

1. Open the Hugging Face provider settings form, reached from **Configuration →
   AI** (`/admin/config/ai`) under the provider settings (route
   `ai_provider_huggingface.settings_form`).
2. Select the **Key** you created in Step 2 as the Hugging Face token.
3. If the form lists models, choose the model(s) you intend to use.
4. Save.

## Step 4 — Choose Hugging Face for AI operations

Open the AI module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select **Hugging Face** as the provider for the
operation types you want it to serve (for example text generation and embeddings).

## A note on cost and data

Inference API usage may be rate-limited or billed depending on your Hugging Face
plan and the models used. Prompts sent to Hugging Face leave your site; treat
unpublished or personal data in them as a disclosure to a third party.
