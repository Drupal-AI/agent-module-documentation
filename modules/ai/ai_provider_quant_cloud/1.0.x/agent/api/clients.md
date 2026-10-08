<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP clients & services

All HTTP goes through the core `http_client` (Guzzle) service; requests carry `Authorization: Bearer <token>` where the token comes from the Key module. Base URL and org id come from `ai_provider_quant_cloud.settings`.

## QuantCloudClient (`ai_provider_quant_cloud.client`)

`Client\QuantCloudClient` — buffered Dashboard AI calls. Ctor args: `http_client`, `config.factory`, `logger.factory`, `key.repository`.

- `getAccessToken()` reads `auth.access_token_key` → `key.repository->getKey()->getKeyValue()`.
- `getDashboardUrl()` maps `platform` → hard-coded URL (`quantcdn`, `quantgov`, plus `*_staging`).
- `getOrganizationId()` reads `auth.organization_id` (throws if unset).
- `buildApiUrl($path)` → `{dashboard}/api/v3/organisations/{orgId}/ai/{path}`.
- `post($path,$data,$opts)` / `get($path,$query)` — JSON body/headers, timeout from `advanced.timeout` (default 30) or per-call override, `connect_timeout` 10. Decodes JSON; on `GuzzleException` logs and throws `\RuntimeException`. Logs method+URL and status only when `advanced.enable_logging`.
- Convenience: `chat($messages,$model,$opts)` → POST `chat` (`temperature`, `maxTokens`, optional `responseFormat`/`toolConfig`/`systemPrompt`); `complete()` → POST `chat`; `embeddings($text,$model)` → POST `embeddings`; `getModels($filters)` → GET `models`; `getModelDetails($id)` → GET `models/{id}`. Image generation is reached via `post('image-generation', …)` from the provider.

## QuantCloudStreamingClient (`ai_provider_quant_cloud.streaming_client`)

`Client\QuantCloudStreamingClient extends QuantCloudClient`. Adds SSE:

- `chatStreamRaw($messages,$model,$opts)` → POST `chat/stream` with `Accept: text/event-stream`, `stream => TRUE`, timeout from `advanced.streaming_timeout` (default 60); returns the raw PSR-7 stream body (consumed by `QuantCloudChatMessageIterator`).
- `chatStream(...callback)` (deprecated) and `completeStream()` — buffered SSE reader that parses `data:` lines and invokes a callback per delta.

## QuantCloudVectorDbClient (`ai_provider_quant_cloud.vectordb_client`)

`Client\QuantCloudVectorDbClient` — direct VectorDB API, base path `{dashboard}/api/v3/organisations/{orgId}/ai/vector-db/{path}`. Same auth/config/logging shape as the chat client. Usable without Search API.

Collections: `createCollection($name,$description,$embeddingModel,$dimensions)` (POST `collections`), `listCollections()` (GET), `getCollection($id)`, `deleteCollection($id)` (DELETE). Documents: `uploadDocuments($id,$documents)` (POST `collections/{id}/documents`; server generates embeddings when no vector supplied). Search: `queryByText($id,$query,$limit,$threshold,$includeEmbeddings)` and `queryByVector($id,$vector,…)` both POST `collections/{id}/query` with the search term sent as a JSON body field (parameterized, not concatenated); `limit` clamped 1–20. Deletion: `deleteDocuments($id, $purgeAll, $documentIds, $metadataField, $metadataValues)` — one of purge-all / by-ids / by-metadata (throws `InvalidArgumentException` if none given).

## AuthService (`ai_provider_quant_cloud.auth`)

`Service\AuthService` — OAuth + org helpers (Guzzle default TLS; `http_errors => FALSE` so it inspects status codes itself).

- `getOrganizations()` — GET `{dashboard}/api/v2/organizations` with the Bearer token; returns the array of `{name, machine_name}` (used to populate the org dropdown). `validateToken()` = non-empty org list.
- `getAuthorizationUrl($state,$redirect)` — builds `{dashboard}/oauth/authorize?...` (public client `drupal-ai-provider`, scope `ai:read ai:write models:read usage:read`).
- `exchangeCodeForToken($code,$redirect)` — POST `{dashboard}/oauth/token` (`grant_type=authorization_code`, no client secret); returns the token array or NULL.
- `refreshToken($refresh)` — POST `oauth/token` `grant_type=refresh_token` (uses `auth.oauth_client_id`/`_secret` config, not currently set by the form).
- `getTokenGenerationUrl()` — `{dashboard}/account/api-tokens`.

## ModelsService (`ai_provider_quant_cloud.models`)

`Service\ModelsService` — wraps `QuantCloudClient` model calls with `cache.default`. `getModels($feature,$bypass)` GETs `models?feature=…`, caches under `ai_provider_quant_cloud:models:<feature>` for `CACHE_LIFETIME` = 3600 s; on failure returns a 4-item `getFallbackModels()` list. `getModelDetails($id)` scans the cached list. `getModelsForOperation($op)` maps op→feature and returns `[id => name]`. `clearCache()` deletes the per-feature cache entries.
