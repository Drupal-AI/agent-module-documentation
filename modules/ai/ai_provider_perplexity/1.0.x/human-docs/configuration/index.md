# Configuration

Configuration is two steps: store the Perplexity API key as a **Key** entity
backed by an environment variable, then select that Key on the Perplexity provider
settings. You need the AI provider administration permission (an administrator by
default).

> Remember the module's machine name is **`ai_perplexity`**, even though the
> project is `ai_provider_perplexity`.

## 1. Store the API key as a secret

Keep the key in an environment variable exposed through a Key entity — not in a
plain configuration field.

1. Save the value with DDEV (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --perplexity-api-key=<your-key>
   ddev restart
   ```

2. Confirm the container sees it *without* printing it:

   ```bash
   ddev exec 'test -n "$PERPLEXITY_API_KEY" && echo set'
   ```

3. Create a Key entity backed by that variable at **Configuration → System →
   Keys → Add key** (`/admin/config/system/keys`) using the **Environment** key
   provider pointing at `PERPLEXITY_API_KEY`, or with Drush:

   ```bash
   drush key:save perplexity_api_key --label='Perplexity API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"PERPLEXITY_API_KEY"}' \
     --key-input=none -y
   ```

## 2. Register Perplexity as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and
   open the **Perplexity** provider settings.
2. Select the **Key** holding your API key.
3. Save.

## 3. Choose Perplexity for AI operations

In the AI module's settings, set Perplexity (and a specific model — its
answer/search‑augmented models are the distinctive draw) as the provider for the
operations you want it to power. Pin a specific model rather than relying on a
default.

## Security notes

- **Store the API key as a secret** (Key entity / environment variable), never in
  plain configuration or version control.
- **Prompts sent leave the site.** Treat content going to Perplexity — especially
  unpublished content or personal data — as an external data transfer. The key is
  a spending credential, so consider a spend limit at the provider.
