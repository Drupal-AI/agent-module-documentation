amazee.ai AI Provider is the amazee.ai plugin for the AI (AI Core) module: it registers the `amazeeio` AiProvider so Drupal can call amazee.ai's private, data-sovereign LLM gateway for chat, embeddings, text-to-image and text translation, plus an `amazeeio_vector_db` Postgres/pgvector vector-database provider.

---

The module registers a single `#[AiProvider(id: 'amazeeio')]` plugin (`AmazeeioAiProvider`, extending AI Core's `OpenAiBasedProviderClientBase` and implementing `TranslateTextInterface`) that adapts amazee.ai's OpenAI-compatible LiteLLM gateway to AI Core's operation-type interfaces. It declares eight operation types via `getSupportedOperationTypes()` — `chat`, `chat_with_complex_json`, `chat_with_image_vision`, `chat_with_structured_response`, `chat_with_tools`, `embeddings`, `text_to_image`, and `translate_text` — so amazee.ai models are available anywhere AI Core needs chat/text generation, embeddings, image generation or translation (chatbot, CKEditor, automators, agents, Search API RAG). `translate_text` is implemented in-module by prompting a chat model ("Translate the following text …"). Unusually for an AI provider it also ships an `#[AiVdbProvider(id: 'amazeeio_vector_db')]` plugin backed by Postgres + pgvector (over PDO), giving you an in-region vector store to pair with the embeddings. Authentication is unusual too: instead of pasting an API key you use the multi-step **amazee.ai AI Authentication** form at `/admin/config/ai/providers/amazeeio` (route `ai_provider_amazeeio.settings_form`, permission `administer ai providers`), which starts an anonymous free trial or verifies your email against amazee.ai's management API (`amazee_host`, default `https://api.amazee.ai`), then lets you pick or create a private key that provisions an LLM key and a VectorDB key. On connect the form saves the resolved LLM endpoint into `host` and the Postgres connection details into `ai_provider_amazeeio.settings`, writes the secrets into auto-created **Key** entities (`amazeeio_ai` for the LLM token, `amazeeio_ai_database` for the DB password, and a `amazeeio_ai_management_token` created for dashboard/account calls), and seeds AI Core's default provider/model map only for operation types that have no provider yet. When connected the form shows a **dashboard** (host health via `/health/liveliness`, LiteLLM version, key/team info, live model list) with Disconnect / Check Health / Refresh Models buttons. Model lists are fetched live from the gateway and cached ~24h. Budget/quota errors from the gateway are surfaced as a typed `AiQuotaException` (prompting a trial upgrade when running on the anonymous free tier), and rate-limit errors as `AiRateLimitException`. You never call this provider directly — you go through AI Core's `ai.provider` service so vendor choice stays config-driven.

---

- Add amazee.ai as a private, data-sovereign AI vendor to a Drupal site running AI (AI Core).
- Start an anonymous free trial of amazee.ai's LLM gateway straight from the Drupal admin UI.
- Verify an email address to provision a persistent amazee.ai account key from Drupal.
- Select an existing amazee.ai private key or create a new one per region from the settings form.
- Store the amazee.ai LLM key, VectorDB key and management token securely as Key entities instead of in plain config.
- Set amazee.ai as the site default provider for chat at `/admin/config/ai/settings`.
- Run chat completions through amazee.ai's OpenAI-compatible gateway via AI Core's `chat()`.
- Generate text embeddings through amazee.ai for semantic search / RAG pipelines.
- Send images to a vision-capable model as part of a chat message (`chat_with_image_vision`).
- Use amazee.ai models for tool / function calling so the model can invoke Drupal FunctionCall plugins.
- Request a structured JSON-schema response (`chat_with_structured_response`).
- Generate images from a text prompt through amazee.ai (`text_to_image`).
- Translate text between languages via amazee.ai (`translate_text`, implemented by prompting a chat model).
- Use the bundled `amazeeio_vector_db` provider to store embeddings in Postgres + pgvector.
- Pair amazee.ai embeddings with the amazee.ai vector database for an all-in-region RAG stack.
- Monitor the connected gateway from a built-in dashboard (host health, LiteLLM version, key/team info, live model list).
- Point the provider at a custom amazee.ai / LiteLLM-compatible endpoint via the `host` config value.
- Point the management/trial API at a self-hosted amazee.ai control plane via `amazee_host`.
- Auto-fetch the live list of available amazee.ai models and cache it (~24h).
- Seed AI Core's default provider/model map automatically when the amazee.ai key is provisioned.
- Redirect an admin to the provider settings page on login until it is configured (`redirect_on_login`).
- Surface amazee.ai budget-exceeded / quota errors as a typed `AiQuotaException` and rate-limit errors as `AiRateLimitException`.
- Prompt anonymous free-trial users to upgrade when their trial budget is exhausted.
- Keep environment-specific host/DB/credential config out of config exports via config_ignore integration.
- Power AI Core submodules (AI Chatbot, AI CKEditor, automators, AI Agents) with amazee.ai as the backend.
- Provide amazee.ai alongside OpenAI/Anthropic so an operator can A/B or fail over between LLM vendors.
- Provision trial access non-interactively from a recipe via the `ensureAmazeeAiAccess` config action.
- Configure the Postgres vector-database host, port, database, and credentials for embeddings storage.
- Call amazee.ai from custom PHP through the `ai.provider` service without touching the HTTP client.
