# Configure LiteLLM AI Provider

Route `ai_provider_litellm.settings_form` → `/admin/config/ai/providers/ai_provider_litellm`
(menu under *AI › Providers*), permission **`administer ai providers`**. Form class
`LiteLlmAiConfigForm`. All state is the `ai_provider_litellm.settings` config object.

## Config keys (`ai_provider_litellm.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | **Machine name of a Key entity** (selected via a `key_select` element), not the raw key. Resolved at request time through `key.repository`. |
| `host` | string | `''` | Base URL of the LiteLLM proxy, e.g. `https://litellm.internal`. Must pass `FILTER_VALIDATE_URL` and must **not** end in `/`. |
| `moderation` | bool | `TRUE` | Send an OpenAI-compatible moderation request before each call. Turn off only if LiteLLM does its own moderation. |

Requires the **Key** module (via the `key_select` element / `key.repository`). Store the LiteLLM
token in a Key entity, then select it here. On load the form warns you the OpenAI provider module
can be uninstalled if it is enabled without an API key (`notifyOpenAiUsage()`).

## Validation (on save)

`validateForm()` requires both `api_key` and `host`, resolves the Key value, then constructs a
`LiteLlmAiClient` and calls `models()`. An empty model list, a non-working key, or a connection
error blocks the save. A `500` whose body `detail.error` starts with `LLM Model List not loaded in.`
is downgraded to a warning (save proceeds). When both host and key are set, the form also renders a
"Key details" table from `GET /key/info` (alias, key name, spend, max budget, blocked); a `400`
`budget_exceeded` or `401` invalid-key response is surfaced as an error message.

## LiteLLM REST endpoints used (`src/LiteLLM/LiteLlmAiClient.php`)

All GET, header `Authorization: Bearer <resolved key>`, 5-second timeout, request-scoped cache:

- `GET {host}/model/info` — `models()` / `model()`; each entry → `Model` DTO.
- `GET {host}/v1/models` — **fallback** used by `models()` when `/model/info` throws (that endpoint
  needs an admin key). Each id becomes a stub `Model` with `mode: chat` (chat-only capabilities).
- `GET {host}/key/info` — `keyInfo()`; used only for the admin display table.

Chat/embeddings/etc. requests themselves go through the AI module's OpenAI base client with the
endpoint set to `host` (`LiteLlmAiProvider::loadClient()` → `setEndpoint()`).

## `Model` DTO capability mapping (`src/DTO/Model.php`, from `model_info`)

- image input = `supports_vision`; image output = `mode === image_generation`;
  audio in/out = `supports_audio_input/output`; video output = `mode === video_generation`;
  embeddings = `mode === embedding`; chat = `mode === chat`; moderation = `mode === moderation`.
- 1.3.x adds `supports_function_calling`, `supports_tool_choice`, `supports_response_schema`, plus
  derived `image_and_audio_to_video` (image+audio input) and `image_to_video` (image input + video output).
- `supported_openai_params` drives `getModelSettings()`, which strips generation params a model doesn't support.

## Operation types supported

`getSupportedOperationTypes()` (1.3.x): `chat`, `chat_with_complex_json`, `chat_with_image_vision`,
`chat_with_structured_response`, `chat_with_tools`, `embeddings`, `moderation`, `text_to_image`,
`text_to_speech`, `translate_text`. `getModels()` filters the discovered model list per operation
using the DTO flags (e.g. `chat_with_tools` needs `supportsFunctionCalling || supportsToolChoice`;
`chat_with_structured_response`/`_complex_json` need `supportsResponseSchema`). `translate_text`
(implements `TranslateTextInterface`) is served by `translateText()`, which builds a translation
prompt and calls `chat()`. Rate-limit / "Too Many Requests" / "Request too large" / "rate limit
exceeded" errors map to `AiRateLimitException`; "Budget has been exceeded" maps to `AiQuotaException`.
`embeddingsVectorSize()` probes vector size once (via an `embeddings()` call) and caches it in `cache.ai`.
