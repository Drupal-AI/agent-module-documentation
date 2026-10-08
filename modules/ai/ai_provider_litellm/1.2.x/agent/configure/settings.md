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
token in a Key entity, then select it here.

## Validation (on save)

`validateForm()` requires both `api_key` and `host`, resolves the Key value, then constructs a
`LiteLlmAiClient` and calls `models()`. An empty model list, a non-working key, or a connection
error blocks the save. A `500` whose body starts with `LLM Model List not loaded in.` is downgraded
to a warning (save proceeds). When both host and key are set, the form also renders a "Key details"
table from `GET /key/info` (alias, key name, spend, max budget, blocked).

## LiteLLM REST endpoints used (`src/LiteLLM/LiteLlmAiClient.php`)

All GET, header `Authorization: Bearer <resolved key>`:

- `GET {host}/model/info` — `models()` / `model()`; each entry → `Model` DTO. Capability flags read from `model_info`: `supports_image_input/output`, `supports_audio_input/output`, `supports_video_output`, `mode` (`embedding`/`chat`), `supports_moderation`, `supported_openai_params`.
- `GET {host}/key/info` — `keyInfo()`; used only for the admin display table.

Chat/embeddings/etc. requests themselves go through the AI module's OpenAI base client with the
endpoint set to `host` (`LiteLlmAiProvider::loadClient()` → `setEndpoint()`).

## Operation types supported

`audio_to_audio`, `chat`, `embeddings`, `moderation`, `text_to_image`, `text_to_speech`,
`image_and_audio_to_video`. `getModels()` filters the discovered model list per operation type
using the DTO capability flags. Rate-limit / "Too Many Requests" errors map to `AiRateLimitException`;
"Budget has been exceeded" maps to `AiQuotaException`.
