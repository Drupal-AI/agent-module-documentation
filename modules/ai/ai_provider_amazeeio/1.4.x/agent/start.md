# ai_provider_amazeeio — agent start

Implements the `amazeeio` **AiProvider** plugin for the AI (AI Core) module, adapting
amazee.ai's OpenAI-compatible LiteLLM gateway (default `https://api.amazee.ai`) to AI Core's
operation-type interfaces, and also registers an `amazeeio_vector_db` **AiVdbProvider**
(Postgres/pgvector over PDO). Depends on `ai` and `key`. Supported operation types (8):
`chat`, `chat_with_complex_json`, `chat_with_image_vision`, `chat_with_structured_response`,
`chat_with_tools`, `embeddings`, `text_to_image`, `translate_text`
(`getSupportedOperationTypes()`). Config UI: **Admin → Config → AI → AI Providers →
amazee.ai Authentication** (`/admin/config/ai/providers/amazeeio`); route
`ai_provider_amazeeio.settings_form` (permission `administer ai providers`, defined by AI
Core). No permissions, plugin types, or Drush commands of its own.

Changes since 1.3.x: added `text_to_image` + `translate_text` operation types (provider now
implements `TranslateTextInterface`, translating by prompting a chat model); a built-in
**dashboard** on the connected settings page (host health, LiteLLM version, key/team info,
live models) with Disconnect / Check Health / Refresh Models; a third Key entity
`amazeeio_ai_management_token`; a `confirm_disconnect` form step; config_ignore integration
for host/DB/credentials; rate-limit errors mapped to `AiRateLimitException`. The VDB client
switched to PDO (`ext-pdo` + `ext-pdo_pgsql` replace `ext-pgsql`).

- Provision/authenticate (trial or email), the three Key entities, `host` / `amazee_host` /
  Postgres config, the connected dashboard, seeding amazee.ai as an AI Core default →
  [configure/settings.md](configure/settings.md)
- The AiProvider + AiVdbProvider plugins it registers, operation types, model handling,
  setup data → [plugins/ai_provider_amazeeio.md](plugins/ai_provider_amazeeio.md)
- Call amazee.ai (chat / embeddings / text-to-image / translate) from code through the
  `ai.provider` service → [api/ai_provider_amazeeio.md](api/ai_provider_amazeeio.md)
