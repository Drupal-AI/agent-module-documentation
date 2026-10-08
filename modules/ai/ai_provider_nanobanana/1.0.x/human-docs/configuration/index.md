# Configuration

Configuration is two steps: store the Google API key as a **Key** entity backed
by an environment variable, then select that Key on the NanoBanana provider
settings. You need the **Administer AI providers** permission (an administrator by
default).

## 1. Store the Google API key as a secret

Keep the key in an environment variable exposed through a Key entity — not in a
plain configuration field.

1. Save the value with DDEV (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --google-api-key=<your-key>
   ddev restart
   ```

2. Confirm the container sees it *without* printing it:

   ```bash
   ddev exec 'test -n "$GOOGLE_API_KEY" && echo set'
   ```

3. Create a Key entity backed by that variable at **Configuration → System →
   Keys → Add key** (`/admin/config/system/keys`) using the **Environment** key
   provider pointing at `GOOGLE_API_KEY`, or with Drush:

   ```bash
   drush key:save google_api_key --label='Google API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"GOOGLE_API_KEY"}' \
     --key-input=none -y
   ```

## 2. Register NanoBanana as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and
   open the **NanoBanana** provider settings.
2. Select the **Key** holding your Google API key.
3. Choose which Gemini image model(s) to use — Gemini 2.5 Flash Image and/or
   Gemini 3 Pro Image — and save.

## 3. Use it for image generation

Because this is an **image** provider, use it through an image‑capable feature —
for example **NanoBanana Editor** — with NanoBanana selected as the provider. It
will not power text/chat operations.

## Things to keep in mind

- **Cost and data egress.** Every generation sends prompts and images to Google's
  API — it costs money and the content leaves your site.
- **Keep the key in env/Key**, never in exported configuration or version
  control. The key is a spending credential — consider a limit at Google.
