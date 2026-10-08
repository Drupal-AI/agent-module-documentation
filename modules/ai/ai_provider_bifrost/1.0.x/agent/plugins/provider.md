<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bifrost` AI provider plugin & gateway client

## Provider plugin

`src/Plugin/AiProvider/BifrostAiProvider.php` — `#[AiProvider(id: 'bifrost', label: 'Bifrost')]`,
extends `Drupal\ai\Base\OpenAiBasedProviderClientBase` (so the chat/embeddings/image/audio operation
methods are inherited from the AI module's OpenAI base, driven by the `OpenAI\Client`). Reached via
`\Drupal::service('ai.provider')->createInstance('bifrost')`.

- `getSupportedOperationTypes()` → `['chat', 'embeddings', 'text_to_image', 'text_to_speech',
  'speech_to_text']`.
- `isUsable()` overrides the base (whose `hasAuthentication()` is always TRUE): returns FALSE unless
  `host` is set **and** the Key id resolves to a non-empty value (any `getKeyValue()` throw → not
  usable). This avoids offering a provider whose key was deleted only to fail deep in a request.
- `getSetupData()` → `['key_config_name' => 'api_key']`. `getModelSettings()` passes general config
  through unfiltered (Bifrost exposes no per-model param metadata). `getConfig()` →
  `ai_provider_bifrost.settings`.
- `handleApiException()` maps `rate_limit_error`/`Too Many Requests` → `AiRateLimitException` and
  `insufficient_quota`/`budget` → `AiQuotaException`, else re-throws.

### Client construction

`loadClient()` reads `host`, throws `AiSetupFailureException` if empty (explicitly refuses to fall
back to any default endpoint), resolves the key (`loadApiKey()` → `setAuthentication()`), builds the
`BifrostAiClient($this->httpClient, $host, $this->apiKey)`, calls `setEndpoint($host)`, then
`parent::loadClient()`. `createClient()` is overridden because Bifrost needs the `x-bf-vk` header,
not a Bearer token:

```php
$factory = \OpenAI::factory()
  ->withHttpClient($this->httpClient)   // core Guzzle http_client
  ->withHttpHeader('x-bf-vk', $this->apiKey)
  ->withBaseUri($this->getEndpoint());  // the admin-set host
return $factory->make();
```

No request option disables TLS verification (Guzzle default, on); the key is only ever an HTTP
header, never in the URL. The base URI is the validated admin-set `host`.

## Model discovery & heuristics

`getConfiguredModels($op)` → `loadClient()` then `getModels($op)`:

- Fetches `BifrostAiClient::models()` (`GET <host>/models`, `x-bf-vk` header, returns the response's
  `data` array), cached 5 min (empty lists not cached — see config doc).
- Excludes any id containing `rerank` (`EXCLUDED_MODEL_KEYWORDS` via `isExcludedModel()`).
- Filters by operation with `modelSupportsOperation($model, $op)`:
  - `embeddings` → id contains `embed` (always id-based, even when `architecture` metadata exists —
    OpenRouter modality metadata doesn't describe embeddings).
  - If the entry has an OpenRouter-style `architecture` block, match modalities:
    `chat` = `text` in output; `text_to_image` = `image` in output; `text_to_speech` = `audio` in
    output; `speech_to_text` = `audio` in input; `moderation` = FALSE.
  - If no `architecture` (a bare `{id, created, owned_by}`, in practice Ollama-routed): assume
    **chat** unless the id looks like an embeddings model; all non-chat types → FALSE. (A documented
    caveat: a future bare-shape backend routing a non-chat model would be mis-offered as chat and
    only fail at request time.)
- A NULL/empty operation type returns every non-excluded model (per the interface contract).

`embeddingsVectorSize($model_id)` makes a real `embeddings` call with "Hello world!" and counts the
vector, caching the size permanently under the `ai_provider_bifrost:models` tag (returns 0 on error).

## The gateway client (`BifrostAiClient`)

`src/Bifrost/BifrostAiClient.php` — a small final-style class (constructed in code with `$httpClient`,
`$host`, `$virtualKey`; not a registered service). `models()` does
`GET rtrim($host,'/') . '/models'` with header `x-bf-vk: <virtualKey>` and returns the decoded
`data` array (or `[]`). It is used both by the provider (model discovery) and by the settings form
(live connectivity check).
