Anthropic Provider is the Anthropic (Claude) plugin for the AI (AI Core) module: it registers the `anthropic` AiProvider so Drupal can call Anthropic's API for chat/text generation with Claude models.

---

The module registers a single `#[AiProvider(id: 'anthropic')]` plugin (`AnthropicProvider`, extending AI Core's `OpenAiBasedProviderClientBase` and using `ChatTrait`) that adapts Anthropic's REST API (`https://api.anthropic.com/v1`) to AI Core's operation-type interfaces. It declares support for exactly one operation type — `chat` — via `getSupportedOperationTypes()`, so Claude models are available anywhere AI Core needs chat/text generation (chatbot, CKEditor, automators, agents). You authenticate by selecting a Key entity (via the `key` module) on the settings form at **Admin → Configuration → AI → AI Providers → Anthropic Authentication** (`/admin/config/ai/providers/anthropic`); only the Key id is stored in config (`api_key`), never the raw key. Model lists are fetched live from Anthropic's `/v1/models` endpoint (sent with header `anthropic-version: 2023-06-01`) and cached (default 24h, `models_cache_ttl`), so new Claude releases appear automatically; a `getConfiguredModels()` capability filter narrows the list for JSON-output-capable models. Unlike the OpenAI provider, Anthropic has no native moderation endpoint — an optional `openai_moderation` flag instead routes each Anthropic prompt through the **AI External Moderation** module using OpenAI's moderation, and the form makes you explicitly acknowledge the ban risk if you run without moderation. On setup (`getSetupData()`) it seeds AI Core's default provider/model map — `chat` and `chat_with_image_vision` → a Claude Sonnet 4.5 model, and `chat_with_complex_json` / `chat_with_tools` / `chat_with_structured_response` → a Claude Opus 4.5 model — only for operation types that have no provider yet (`defaultIfNone`). Per-model settings tuning drops `top_p` for Claude 4.x+ models (Anthropic forbids sending temperature and top_p together), and low-credit errors are surfaced as a typed `AiQuotaException`. You never call this provider directly — you go through AI Core's `ai.provider` service so vendor choice stays config-driven.

---

- Add Anthropic (Claude) as an AI vendor to a Drupal site running the AI (AI Core) module.
- Store the Anthropic API key securely as a Key entity instead of in plain configuration.
- Set Anthropic as the site default provider for chat at `/admin/config/ai/settings`.
- Run chat completions with Claude models (Opus / Sonnet / Haiku) through AI Core's `chat()`.
- Send images to a vision-capable Claude model as part of a chat message (`chat_with_image_vision`).
- Use Claude for tool / function calling so the model can invoke Drupal FunctionCall plugins.
- Request a structured JSON-schema response from a Claude model.
- Auto-fetch the live list of available Claude models from Anthropic's `/v1/models` endpoint.
- Cache the fetched models list and tune its TTL via `models_cache_ttl`.
- Route Anthropic prompts through OpenAI moderation (AI External Moderation) before they run.
- Explicitly acknowledge and run Anthropic without moderation when you accept the ban risk.
- Seed AI Core's default provider/model map automatically when the Anthropic key is saved.
- Point the provider at a custom / proxy Anthropic-compatible endpoint via the `host` config value.
- Power AI Core submodules (AI Chatbot, AI CKEditor, automators, AI Agents) with Claude as the backend.
- Tune per-model chat settings — max_tokens, temperature, top_p, top_k — from the AI settings UI.
- Rely on automatic dropping of `top_p` for Claude 4.x+ models to avoid Anthropic API errors.
- Surface Anthropic low-credit / quota errors as a typed `AiQuotaException` for graceful handling.
- List only JSON-output-capable Claude models in admin selects via capability filtering.
- Provide Claude alongside OpenAI so an operator can A/B or fail over between LLM vendors.
- Migrate legacy `provider_anthropic` (old AI Core submodule) config into this standalone module on install.
- Call Claude from custom PHP through the `ai.provider` service without touching the HTTP client.
- Give AI Agents a Claude-backed reasoning model for complex JSON / tool-calling tasks.
