<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare AI Gateway provider plugin

`src/Plugin/AiProvider/CloudflareGatewayProvider.php` — `final`,
`#[AiProvider(id: 'cloudflare_gateway', label: 'Cloudflare AI Gateway')]`, extends
`Drupal\ai\Base\OpenAiBasedProviderClientBase`. Injects (via `create()`) `GatewayClientInterface`,
`entity_type.manager`, `ModelCatalogue` and `http_client_factory` on top of the base services.

## Operations & models

- `getSupportedOperationTypes()` → `chat`, `embeddings`.
- `getSetupData()` → `key_config_name => ''` (no Key entity; gateway holds upstream keys),
  default models `chat: openai/gpt-4o`, `embeddings: openai/text-embedding-3-small`.
- `getConfiguredModels($op)` → `enabledModelIds($op)` from `settings:models`, with labels
  enriched from `ModelCatalogue::getModels($gateway)` via `ModelLabel::format()` when the
  catalogue is reachable; falls back to the raw ID otherwise.
- `getModelSettings()` returns the generic config unchanged.
- `isUsable()` → FALSE unless `settings:gateway` is set; otherwise checks the operation type.
- `embeddingsVectorSize()` returns known dimensions by model-ID substring
  (text-embedding-3-large 3072; -3-small / ada-002 1536; bge-large 1024 / -base 768 / -small 384),
  else defers to the base.

## Credentials & endpoint

- `loadGateway()` loads the `cloudflare_gateway` entity named by `settings:gateway`; throws
  `AiSetupFailureException` when unset or missing.
- `loadApiKey()` returns `gatewayClient->resolveCredentials($gateway)->apiToken`; on any throwable
  it returns `''` so provider-availability checks do not fatal. For every gateway mode (unified
  billing, BYOK, Workers AI) the resolved token is the Authorization credential — the module never
  stores upstream provider keys.
- `loadClient()`:
  1. `resolveCredentials($gateway)` (wraps `CloudflareApiException` as `AiSetupFailureException`).
  2. `setEndpoint(gatewayClient->buildBaseUri($gateway, EndpointStyle::OpenAiCompat, accountId))` —
     the base URI (including the account-ID path) is built by cloudflare_ai from the selected
     gateway entity, not from request input.
  3. Builds a Guzzle handler stack whose `Middleware::mapResponse` wraps any
     `text/event-stream` response body in `SseContentCoercingStream`.
  4. `setHttpClient(http_client_factory->fromOptions([...]))` with headers from
     `gatewayClient->buildRequestHeaders($credentials, $this->requestOptions())`, timeout from
     `ai.settings:request_timeout` (default 60), and the handler stack. TLS verification is left at
     the Guzzle default (on).
  5. Nulls `$this->client` so the OpenAI client is rebuilt around the fresh HTTP client (the
     cf-aig-* metadata headers vary per request), then calls `parent::loadClient()`.

## Per-request gateway controls

- `requestOptions()` builds a `GatewayRequestOptions`: `withCacheTtl` when `settings:cache_ttl > 0`,
  `withSkipCache` when `settings:skip_cache`, and `withMetadata` from `requestMetadata()`.
- `requestMetadata()` merges operator-configured `settings:metadata` (string/numeric values only)
  with the provider's AI-suite tags (`getTags()`), joined into a `tags` entry. These become the
  `cf-aig-metadata` / `cf-aig-skip-cache` default headers on the HTTP client.

## SSE coercion

`Http/SseContentCoercingStream` (uses `StreamDecoratorTrait`) rewrites streamed SSE `data:` lines
so a numeric chat `content` delta (Workers AI emits `{"delta":{"content":1}}`) is coerced to a
string, one line at a time (no full-response buffering), preventing a `TypeError` in openai-php's
strict streamed-response parser. `coerceContent()` walks `choices[*].delta|message.content`.
