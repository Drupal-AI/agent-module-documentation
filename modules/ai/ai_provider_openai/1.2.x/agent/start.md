# ai_provider_openai — agent start

Implements the `openai` **AiProvider** plugin for the AI (AI Core) module, adapting OpenAI
(and OpenAI-compatible / Azure endpoints) to AI Core's operation-type interfaces. Depends on
`ai` and `key`. Supported operation types: **chat, embeddings, moderation, text_to_image,
text_to_speech, speech_to_text**. Config UI: **Admin → Config → AI → AI Providers → OpenAI
Authentication** (`/admin/config/ai/providers/openai`); route `ai_provider_openai.settings_form`
(permission `administer ai providers`, defined by AI Core).

- Set the API key (via Key), host, moderation; pick OpenAI as an AI Core default →
  [configure/settings.md](configure/settings.md)
- The AiProvider plugin it registers + which operation types it supports →
  [plugins/ai_provider_openai.md](plugins/ai_provider_openai.md)
- Call OpenAI operations from code through the `ai.provider` service →
  [api/ai_provider_openai.md](api/ai_provider_openai.md)
