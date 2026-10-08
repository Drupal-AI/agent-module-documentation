# Configuration

Configuration is two steps: store the OpenRouter API key as a **Key** entity
backed by an environment variable, then select that Key on the OpenRouter provider
settings. You need the access‑restricted **Administer AI providers** permission
(an administrator by default).

## 1. Store the API key as a secret

Keep the key in an environment variable exposed through a Key entity — not in a
plain configuration field.

1. Save the value with DDEV (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --openrouter-api-key=<your-key>
   ddev restart
   ```

2. Confirm the container sees it *without* printing it:

   ```bash
   ddev exec 'test -n "$OPENROUTER_API_KEY" && echo set'
   ```

3. Create a Key entity backed by that variable at **Configuration → System →
   Keys → Add key** (`/admin/config/system/keys`) using the **Environment** key
   provider pointing at `OPENROUTER_API_KEY`, or with Drush:

   ```bash
   drush key:save openrouter_api_key --label='OpenRouter API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"OPENROUTER_API_KEY"}' \
     --key-input=none -y
   ```

## 2. Register OpenRouter as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and
   open the **OpenRouter** provider settings.
2. Select the **Key** you created above.
3. Save.

## 3. Choose a model and select the provider

OpenRouter exposes **many models from many vendors** through one key. Pick a
specific model (for example an OpenAI, Anthropic, Google or Meta model id) and set
OpenRouter as the provider for the AI operations you want it to power. Pin the
model rather than relying on a default.

## Things to keep in mind

- **The key is a spending credential.** An OpenRouter key can incur real cost at
  speed — set a **spend limit at OpenRouter** and have someone watch it.
- **Data handling is a contractual question, not a technical one.** Prompts may
  carry personal data or unpublished content, and passing them through an
  aggregator to an underlying model provider is a **processing chain** that belongs
  in your privacy assessment.
- **Model availability changes without notice** on an aggregator — a site pinned to
  a specific model needs a plan for the day it is withdrawn.
