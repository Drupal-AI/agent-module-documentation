<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The AiServerBackend plugin type — adding a backend

A backend plugin owns everything protocol-specific about one kind of inference server: how to build
its base URI, list its models, detect each model's operation types and routing metadata, and
(optionally) execute chat over a native protocol. The multi-server UI, config entities and provider
stay generic, so a new backend is additive — no core patch, and it can live in another module.

## Plumbing

- **Attribute** `src/Attribute/AiServerBackend.php` — `#[AiServerBackend(id, label, description?)]`.
- **Manager** `src/Backend/AiServerBackendManager.php` — a `DefaultPluginManager` scanning
  `Plugin/AiServerBackend` in every enabled module; alter hook
  `ai_provider_universal_server_backend_info`; service alias
  `plugin.manager.ai_provider_universal.server_backend`. `getOptions()` feeds the server form's backend
  select.
- **Interfaces** `src/Backend/AiServerBackendInterface.php` (required) and
  `AiInferenceBackendInterface.php` (optional, native chat).
- **Base class** `src/Backend/AiServerBackendPluginBase.php`.

## `AiServerBackendInterface` (implement all)

- `getBaseUri(AiUniversalServerInterface $server): string` — absolute base URI, e.g.
  `http://box:8080/v1`. Built from the server's `host_name`/`port` config (admin-set), never request
  input.
- `listModels($server): array` — one entry per model, each with at least `id` (raw model id); other
  keys pass through to `detectOperationTypes()`. Throws on connection/error.
- `detectOperationTypes(array $modelEntry): string[]` — operation type ids (chat, embeddings,
  moderation, rerank, speech_to_text, text_to_speech, text_to_image, …).
- plus routing-metadata detection (cost/context/quality/feature hints) used to seed model entities.

## `AiInferenceBackendInterface` (optional — native protocols)

By default the provider dispatches chat over the OpenAI REST protocol, which nearly every backend
speaks. A backend whose service uses a different protocol (Anthropic Messages, Gemini generateContent,
…) implements `doChat($input, $modelId, $server, $configuration, $streamed): ChatOutput` to own
execution. Everything around the call — the pre-call gate, model swap, per-server usage limits, usage
recording, the post-call event, routing, fact-check and governance — stays applied by the provider
whichever path a request takes. Streaming-incapable backends must throw `AiMissingFeatureException`
rather than silently returning a complete response. The token usage on the returned `ChatOutput` feeds
usage limits and the router savings report, so populate it when the API reports counts.

## Shipped backends (`src/Plugin/AiServerBackend/`)

`OpenAiCompatible` (reference: llama.cpp, vLLM, LM Studio, OpenAI REST — custom base URLs; also does
Hugging Face pipeline-tag lookups), `Ollama` (enriches metadata via `/api/show`), `OllamaCloud`,
`OpenRouter` (dynamic catalog + pricing), `Groq`, `Fireworks`, `HuggingFace`, `LiteLlm` (pulls pricing
from `/model/info`), `DeepSeek`, `Amazee` (amazee.ai), `Grok` (xAI), and `Anthropic` (native Messages
API via `AiInferenceBackendInterface`; streaming through
`src/Chat/AnthropicStreamedChatMessageIterator.php`).

## Credentials & transport

Every backend that authenticates reads the server's `api_key` (a **Key entity id**) through
`key.repository` (`->getKey($id)?->getKeyValue()`). HTTP clients are built
via `http_client_factory->fromOptions(['timeout' => …])` (the standard Drupal Guzzle client).
