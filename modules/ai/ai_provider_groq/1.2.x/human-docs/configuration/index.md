# Configuration

Groq has its own settings form where you supply the API key. Store the key
securely rather than pasting it into exported configuration.

## Step 1 — Store the API key as a Key

On this project the convention is to hold secrets in an environment variable and
reference them through a **Key** entity.

1. Save the value into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --groq-api-key=<value>
   ddev restart
   ```

   The flag `--groq-api-key` becomes the environment variable `GROQ_API_KEY`
   inside the web container.

2. Create a Key entity that reads that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key** — **Authentication** key
   type, **Environment** key provider, pointing at `GROQ_API_KEY`.

## Step 2 — Configure the Groq provider

1. Open the Groq provider settings form, reached from **Configuration → AI**
   (`/admin/config/ai`) under the provider settings (route
   `ai_provider_groq.settings_form`).
2. Select the **Key** you created in Step 1 as the Groq API key.
3. If the form lists models, choose the model(s) you intend to use.
4. Save.

## Step 3 — Choose Groq for AI operations

Open the AI module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select **Groq** as the provider for the
operation types you want it to serve. Groq is especially well suited to the
interactive operations — inline suggestions, autocomplete, an editorial assistant
— where its low latency is visible to the user.

## The three standing points

- **The key is a spending credential** — set a limit at Groq and watch it.
- **A prompt is a disclosure** — whatever you send leaves the site; treat
  unpublished or personal data accordingly, including where the provider
  processes.
- **A pinned model needs a plan** — decide what the site does when a model
  changes. The risk is lower here than most, since Groq serves open-weight models
  that can usually be run elsewhere.
