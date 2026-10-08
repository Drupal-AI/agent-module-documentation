# ai_provider_amazeeio — agent start

Implements the `amazeeio` **AiProvider** plugin for the AI (AI Core) module, adapting
amazee.ai's OpenAI-compatible LiteLLM gateway (default `https://api.amazee.ai`) to AI Core's
operation-type interfaces, and also registers an `amazeeio_vector_db` **AiVdbProvider**
(Postgres/pgvector). Depends on `ai` and `key`. Supported operation types:
`chat`, `chat_with_complex_json`, `chat_with_image_vision`, `chat_with_structured_response`,
`chat_with_tools`, `embeddings` (`getSupportedOperationTypes()`). Config UI: **Admin → Config
→ AI → AI Providers → amazee.ai Authentication** (`/admin/config/ai/providers/amazeeio`); route
`ai_provider_amazeeio.settings_form` (permission `administer ai providers`, defined by AI
Core). No permissions, plugin types, or Drush commands of its own.

- Provision/authenticate (trial or email), the two Key entities, `host` / `amazee_host` /
  Postgres config, seeding amazee.ai as an AI Core default →
  [configure/settings.md](configure/settings.md)
- The AiProvider + AiVdbProvider plugins it registers, operation types, model handling,
  setup data → [plugins/ai_provider_amazeeio.md](plugins/ai_provider_amazeeio.md)
- Call amazee.ai (chat / embeddings) from code through the `ai.provider` service →
  [api/ai_provider_amazeeio.md](api/ai_provider_amazeeio.md)
