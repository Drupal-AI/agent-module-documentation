<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenRouter Provider registers the `openrouter` AiProvider plugin for the Drupal AI (AI Core) module, routing chat, embeddings and text-to-image operations through OpenRouter — an OpenAI-compatible API aggregator that fronts hundreds of models (OpenAI, Anthropic, Google, Meta, Mistral, Qwen, Grok and more) behind one key.

---

The module ships a single `#[AiProvider(id: 'openrouter')]` plugin (`OpenRouterProvider`, extending AI Core's `AiProviderClientBase`, using `ChatTrait`) that declares `getSupportedOperationTypes()` = `['chat', 'embeddings', 'text_to_image']` and one capability, `StreamChatOutput`. All HTTP work is delegated to the `ai_provider_openrouter.client` service (`OpenRouterClient`), which wraps the **`openai-php/client`** SDK (`OpenAI\Factory->withApiKey()->withBaseUri()->make()`) because OpenRouter's REST API is OpenAI-wire-compatible; the base URI defaults to `https://openrouter.ai/api/v1` and is admin-overridable. Chat maps AI Core `ChatMessage` objects into OpenAI-style `messages` (with typed `text`/`image_url`/`video_url`/`file` content parts for multimodal image, video and PDF inputs), merges the provider `configuration` into the payload, supports tool/function calling (`tools` + `tool_calls`) and structured output (`response_format: json_schema`), and returns either a plain `ChatOutput` with a `TokenUsageDto` or, when streaming is requested, an `OpenRouterStreamedChatMessageIterator` over SSE chunks (with `stream_options.include_usage`). Embeddings normalise single/batch string input and honour a `dimensions` param (Matryoshka truncation) and `encoding_format`; `embeddingsVectorSize()` carries a hard-coded map of known model → vector size (384–3072). Text-to-image is done via the chat-completions endpoint with `modalities: ['image','text']`, decoding base64 `data:` image URLs into `ImageFile` objects. The **API key is never stored in module config** — the settings form (`/admin/config/ai/providers/openrouter/settings`, permission `administer ai providers`) stores only the machine name of a **Key** entity (`key_select`, filtered to `authentication` keys); the client resolves the real secret at request time via `key.repository`. `getConfiguredModels()` and the settings form fetch the live `/models` and `/embeddings/models` lists (sending `Authorization: Bearer`, `HTTP-Referer: https://drupal.org`, `X-Title: Drupal AI Module`) and let admins whitelist a curated `enabled_models` subset so downstream selects aren't flooded with 300+ options. Reasoning models (`openai/gpt-5*`, `openai/o1*`, `openai/o3*`, Grok reasoning) gain a `reasoning_effort` select. Three DeepChat hooks (`hook_deepchat_settings`, `hook_page_attachments_alter`, `hook_preprocess_ai_deepchat`) force `stream: true` for legacy (non-agent) assistants and disable it for agent-based ones. You never call the plugin directly — AI Core's `ai.provider` service dispatches to it based on config.

---

- Add OpenRouter as an AI vendor to a Drupal site running the AI (AI Core) module.
- Reach 300+ models from many upstream providers (OpenAI, Anthropic, Google, Meta, Mistral, Qwen, Grok) through a single account and key.
- Store the OpenRouter API key as a Key entity (Key module) instead of plaintext config.
- Set OpenRouter as the site default provider from the settings form's "Set as default provider" checkbox.
- Run chat completions against any enabled OpenRouter model through AI Core's `chat()`.
- Stream chat output token-by-token (SSE) with live token, reasoning and cached-token usage.
- Generate embeddings (single or batch) for semantic search / RAG via AI Core's `embeddings()`.
- Request truncated embedding dimensions (Matryoshka) on supporting models via the `dimensions` config.
- Generate images from a text prompt using multimodal models (Gemini, GPT-5) through `textToImage()`.
- Send images, PDFs and videos as part of a chat message to vision/multimodal-capable models.
- Use tool / function calling so a model can invoke Drupal FunctionCall plugins and drive agents.
- Request a structured JSON-schema response from a model (`response_format: json_schema`).
- Tune reasoning effort (none → extra-high) for o1/o3/GPT-5/Grok reasoning models.
- Curate a whitelist of `enabled_models` to keep model dropdowns lean for editors and workflows.
- Auto-discover new models the moment OpenRouter lists them (live `/models` fetch, no redeploy).
- Point the provider at a custom OpenAI-compatible endpoint via the admin-only Base URL field.
- Compare models by price/context directly in the settings form (pricing and context length shown per model).
- Power AI Core submodules (AI Chatbot/DeepChat, CKEditor AI, automators, AI Agents) with OpenRouter as backend.
- Call OpenRouter from custom PHP via `\Drupal::service('ai_provider_openrouter.client')` or, preferably, the `ai.provider` service.
- Surface rate-limit, quota and content-policy errors as typed AI exceptions (`AiRateLimitException`, `AiQuotaException`, `AiUnsafePromptException`).
- Provide OpenRouter alongside other providers so an operator can A/B or fail over between LLM vendors.
- Let a site use a different model per task (cheap model for bulk, strong model for reasoning) without vendor lock-in.
