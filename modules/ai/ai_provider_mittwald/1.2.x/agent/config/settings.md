<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the mittwald provider

## Install & enable

```bash
composer require drupal/ai_provider_mittwald
drush pm:enable ai_provider_mittwald -y
```

Requires the **AI module** (`drupal/ai:^1.3.0`) and the **Key module** (`drupal/key:^1.18`; pulled
in via Composer — the `.info.yml` lists only `ai:ai`). No submodules, no Drush commands, no
permissions of its own. Core requirement `^10.3 || ^11`.

## API key (Key module)

1. `/admin/config/system/keys/add` → key type *Authentication*, paste your mittwald API key, save.
   Obtain the key from mittwald's AI hosting access guide.
2. In the provider form, select that key in **mittwald API Key** (`#type => key_select`).

Only the key's **machine name** is stored in `api_key`; the base class resolves the secret via the
Key repository and sends it as `Authorization: Bearer <key>`. `getSetupData()` returns
`key_config_name: 'api_key'`.

## The settings form

Route **`ai_provider_mittwald.settings_form`** → `/admin/config/ai/providers/mittwald`, defined in
`ai_provider_mittwald.routing.yml`, gated by permission **`administer ai providers`** (owned by the
`ai` module). Menu link under *Configuration → AI* as *mittwald Authentication*. Form class:
`src/Form/MittwaldConfigForm.php`.

Config object **`ai_provider_mittwald.settings`** (schema in `config/schema/…`; install defaults
`api_key: ''`, `moderation: false`, `host: ''`):

| Key | Type | Exposed in form? | Meaning |
|---|---|---|---|
| `api_key` | string (Key name) | Yes (`key_select`, required) | The Key holding the mittwald API secret. |
| `host` | string | No — config only | API base, e.g. `llm.aihosting.mittwald.de/v1`. Empty → the default host is used. |
| `moderation` | boolean | No — config only | Flag read by `getClient()`; run moderation before a call. |

`validateForm()` requires a Key that resolves to a value, then instantiates the `mittwald` provider,
applies the key (and `host` if set in config), and calls `getConfiguredModels()` to confirm
connectivity — a failure sets an error on `api_key`. `submitForm()` re-resolves the key, runs
`MittwaldHelper::testRateLimit()`, saves `api_key`, and seeds default models via `setDefaultModels()`
→ `AiProviderPluginManager::defaultIfNone()`.

## Endpoint & client resolution

`MittwaldProvider` extends `OpenAiBasedProviderClientBase`:

- `loadClient()` sets the SDK endpoint to config `host`, or `llm.aihosting.mittwald.de/v1` when
  unset, then delegates to the base `loadClient()` (re-throwing setup failures as
  `AiSetupFailureException`).
- `getClient()` lazily reads the `moderation` config flag before returning the base client.

## Operations & model filtering

Supported operation types (`getSupportedOperationTypes()`): `chat`, `embeddings`, `moderation`,
`rerank`, `speech_to_text`, `text_to_speech`. Note `moderation()` and `textToImage()` currently
`throw new \Exception("not implemented")`.

`getModels($operation_type, $capabilities)`:

- Lists the server's models, skipping any with `owned_by === 'openai-dev'`.
- Filters by operation type via regex on the model id (chat: `gpt-oss|qwen3.[568]-|ministral-|glm-ocr`;
  embeddings: `qwen3-embedding`; moderation: `text-moderation|omni-moderation`; speech_to_text:
  `whisper`; rerank: `qwen3-vl-reranker`; text_to_speech: `qwen3-tts`).
- Applies capability heuristics — image-vision restricted to specific Qwen/ministral/glm ids;
  JSON-output restricted to specific families; audio/video capabilities are excluded for now.
- Sorts (`asort`) and caches the result per `operation_type` + hashed capabilities key in the cache
  backend.

`getModelSettings()` adds a **Reasoning Effort** select (minimal/low/medium/high) for models that
`isReasoningModel()` flags (`gpt-oss-*`, `qwen3.[568]-*`). `embeddingsVectorSize()` returns 4096 for
`qwen3-embedding-8b`, else 0.

### Rerank (direct call)

The OpenAI SDK has no rerank resource, so `rerank()` builds the URL from the resolved endpoint
(prepending `https://` if the stored endpoint has no scheme) + `/rerank`, and POSTs a
`{model, query, documents, top_n?}` JSON body through the base PSR-18 HTTP client with a bearer
token. Non-2xx responses are mapped onto the AI module's exceptions (status, reason phrase and body
in the message).

### Text-to-speech

`textToSpeech()` drops empty `voice`/`language`/`instructions` params (mittwald rejects empty
optionals), calls the SDK `audio()->speech()`, and derives the MIME type/extension from the requested
`response_format` via `speechResponseType()` (mittwald always returns an `audio/mpeg` header, so the
request drives the type; default `wav`).

## Setup-time rate-limit probe

`MittwaldHelper::testRateLimit($api_key)` (service `ai_provider_mittwald.helper`) POSTs a tiny chat
completion to `https://{host or default}/chat/completions` with the bearer key and `http_errors =>
FALSE`, capturing response headers via a Guzzle `on_stats` handler. If the response reports
`insufficient_quota` or an `x-ratelimit-limit-requests` header ≤ 200, it shows an admin error message
linking to mittwald's terms-of-use page.

## Update hooks

`ai_provider_mittwald.install` — `hook_update_10001` and `hook_update_10002` migrate withdrawn
default models (`Mistral-Small-3.2-24B-Instruct`, `Qwen3-Coder-30B-Instruct`,
`Devstral-Small-2-24B-Instruct-2512`) in `ai.settings` `default_providers` to
`Ministral-3-14B-Instruct-2512` (10002 fixes an inverted provider check in 10001).

## Operating notes

- The `host` and `moderation` keys are not in the UI; change them with `drush config:set
  ai_provider_mittwald.settings host …` (or config import) if you must target a non-default endpoint.
- Chat parameter defaults (max_tokens, temperature, penalties, top_p) come from
  `definitions/api_defaults.yml`.
