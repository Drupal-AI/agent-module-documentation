# Configuration

DeepL Provider has its own settings form where you supply the DeepL API key. As
with any credential, store it securely rather than pasting it into exported
configuration.

## Step 1 — Get a DeepL API key

Sign up for a **DeepL API** plan — **Free** or **Pro** — and copy the
authentication key from your DeepL account. The Free and Pro plans use different
API hosts, so note which one your key belongs to; the settings form lets you
indicate the plan.

## Step 2 — Store the API key as a Key

Keep the key out of exported configuration. On this project the convention is to
hold secrets in an environment variable and reference them through a **Key**
entity.

1. Save the value into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --deepl-api-key=<value>
   ddev restart
   ```

   The flag `--deepl-api-key` becomes the environment variable `DEEPL_API_KEY`
   inside the web container.

2. Create a Key entity that reads that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key** — **Authentication** key
   type, **Environment** key provider, pointing at `DEEPL_API_KEY`.

## Step 3 — Configure the DeepL provider

1. Go to the DeepL provider settings form, reached from **Configuration → AI**
   (`/admin/config/ai`) under the provider settings (route
   `ai_provider_deepl.settings_form`).
2. Select the **Key** you created in Step 2 as the DeepL API key.
3. Choose the correct **plan / endpoint** (Free or Pro) to match your key.
4. Save.

## Step 4 — Use DeepL for translation

DeepL then becomes available as the translation engine for the AI module's
translation features. Configure a **glossary** for your organisation's terms,
product names and legal phrasing so the engine does not fall back to generic
vocabulary — this is where general machine translation most often gets an
institution's language wrong.

## A note on data and workflow

The content you translate is sent to DeepL, so unpublished material and personal
data in it is a disclosure to a processor (DeepL processes in the EU, which may
help with residency requirements). Treat machine output as a **first draft** for
human review rather than final published text.
