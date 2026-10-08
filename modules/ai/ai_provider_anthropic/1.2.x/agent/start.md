# ai_provider_anthropic — agent start

Implements the `anthropic` **AiProvider** plugin for the AI (AI Core) module, adapting
Anthropic's API (`https://api.anthropic.com/v1`) to AI Core's operation-type interfaces.
Depends on `ai` and `key`. Supported operation type: **chat only**
(`getSupportedOperationTypes()` returns `['chat']`). Config UI: **Admin → Config → AI → AI
Providers → Anthropic Authentication** (`/admin/config/ai/providers/anthropic`); route
`ai_provider_anthropic.settings_form` (permission `administer ai providers`, defined by AI
Core). No permissions, plugin types, or Drush commands of its own.

- Set the API key (via Key), moderation, `host`, model cache; pick Anthropic as an AI Core
  default → [configure/settings.md](configure/settings.md)
- The AiProvider plugin it registers + the chat operation / model handling →
  [plugins/ai_provider_anthropic.md](plugins/ai_provider_anthropic.md)
- Call Anthropic (Claude) from code through the `ai.provider` service →
  [api/ai_provider_anthropic.md](api/ai_provider_anthropic.md)
