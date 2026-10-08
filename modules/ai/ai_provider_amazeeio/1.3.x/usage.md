amazee.ai AI Provider is the amazee.ai plugin for the AI (AI Core) module: it registers the `amazeeio` AiProvider so Drupal can call amazee.ai's private, data-sovereign LLM gateway for chat and embeddings, plus an `amazeeio_vector_db` Postgres/pgvector vector-database provider.

---

The module registers a single `#[AiProvider(id: 'amazeeio')]` plugin (`AmazeeioAiProvider`, extending AI Core's `OpenAiBasedProviderClientBase`) that adapts amazee.ai's OpenAI-compatible LiteLLM gateway to AI Core's operation-type interfaces. It declares six operation types via `getSupportedOperationTypes()` — `chat`, `chat_with_complex_json`, `chat_with_image_vision`, `chat_with_structured_response`, `chat_with_tools`, and `embeddings` — so amazee.ai models are available anywhere AI Core needs chat/text generation or embeddings (chatbot, CKEditor, automators, agents, Search API RAG). Unusually for an AI provider it also ships an `#[AiVdbProvider(id: 'amazeeio_vector_db')]` plugin backed by Postgres + pgvector, giving you an in-region vector store to pair with the embeddings. Authentication is unusual too: instead of pasting an API key you use the multi-step **amazee.ai AI Authentication** form at `/admin/config/ai/providers/amazeeio` (route `ai_provider_amazeeio.settings_form`, permission `administer ai providers`), which starts an anonymous free trial or verifies your email against amazee.ai's management API (`amazee_host`, default `https://api.amazee.ai`), then provisions an LLM key and a VectorDB key and writes them into two auto-created **Key** entities (`amazeeio_ai`, `amazeeio_ai_database`). On connect the form saves the resolved LLM endpoint into `host` and the Postgres connection details (`postgres_host`, `postgres_port`, `postgres_default_database`, `postgres_username`) into `ai_provider_amazeeio.settings`; only the Key ids are stored, never the raw secrets. Model lists are fetched live from the gateway and cached ~24h, and `getSetupData()` seeds AI Core's default provider/model map for chat and embeddings only for operation types that have no provider yet. Budget/quota errors from the gateway are surfaced as a typed `AiQuotaException` (prompting a trial upgrade when running on the anonymous free tier). You never call this provider directly — you go through AI Core's `ai.provider` service so vendor choice stays config-driven.

---

- Add amazee.ai as a private, data-sovereign AI vendor to a Drupal site running AI (AI Core).
- Start an anonymous free trial of amazee.ai's LLM gateway straight from the Drupal admin UI.
- Verify an email address to provision a persistent amazee.ai account key from Drupal.
- Store the amazee.ai LLM key and VectorDB key securely as Key entities instead of in plain config.
- Set amazee.ai as the site default provider for chat at `/admin/config/ai/settings`.
- Run chat completions through amazee.ai's OpenAI-compatible gateway via AI Core's `chat()`.
- Generate text embeddings through amazee.ai for semantic search / RAG pipelines.
- Send images to a vision-capable model as part of a chat message (`chat_with_image_vision`).
- Use amazee.ai models for tool / function calling so the model can invoke Drupal FunctionCall plugins.
- Request a structured JSON-schema response (`chat_with_structured_response`).
- Use the bundled `amazeeio_vector_db` provider to store embeddings in Postgres + pgvector.
- Pair amazee.ai embeddings with the amazee.ai vector database for an all-in-region RAG stack.
- Point the provider at a custom amazee.ai / LiteLLM-compatible endpoint via the `host` config value.
- Point the management/trial API at a self-hosted amazee.ai control plane via `amazee_host`.
- Auto-fetch the live list of available amazee.ai models and cache it (~24h).
- Seed AI Core's default provider/model map automatically when the amazee.ai key is provisioned.
- Redirect an admin to the provider settings page on login until it is configured (`redirect_on_login`).
- Surface amazee.ai budget-exceeded / quota errors as a typed `AiQuotaException` for graceful handling.
- Prompt anonymous free-trial users to upgrade when their trial budget is exhausted.
- Power AI Core submodules (AI Chatbot, AI CKEditor, automators, AI Agents) with amazee.ai as the backend.
- Provide amazee.ai alongside OpenAI/Anthropic so an operator can A/B or fail over between LLM vendors.
- Provision trial access non-interactively from a recipe via the `ensureAmazeeAiAccess` config action.
- Configure the Postgres vector-database host, port, database, and credentials for embeddings storage.
- Call amazee.ai from custom PHP through the `ai.provider` service without touching the HTTP client.
