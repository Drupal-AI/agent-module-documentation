<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare AI Gateway Provider (ai_provider_cloudflare_gateway) — agent index

A **provider plugin for the `drupal/ai` framework** that routes AI traffic through a
**Cloudflare AI Gateway**. One provider fronts every upstream model the gateway proxies
(OpenAI, Anthropic, Google, Mistral, Workers AI…) and adds the gateway's caching, logging and
cost analytics. Package `AI Providers`. Core `^10.5 || ^11 || ^12`. PHP `>=8.3`.
License GPL-2.0-or-later. Version 1.0.0-alpha7.

Depends on `ai:ai`, **`cloudflare_ai:cloudflare_ai`** and **`cloudflare_sdk:cloudflare_sdk`**
(the last two supply the gateway entity, credential resolution and model catalogue).

- **Provider plugin: operations, endpoint, credentials, streaming coercion** →
  [plugins/provider.md](plugins/provider.md)
- **Settings form, model picker, config object, autocomplete route** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `CloudflareGatewayProvider` (id **`cloudflare_gateway`**, label
  *"Cloudflare AI Gateway"*) in `src/Plugin/AiProvider/CloudflareGatewayProvider.php`, `final`,
  extending `Drupal\ai\Base\OpenAiBasedProviderClientBase`.
- Supported operations (`getSupportedOperationTypes()`): **`chat`**, **`embeddings`**.
- `getSetupData()` returns `key_config_name => ''` (no Drupal Key entity — the gateway holds
  upstream keys) and default models `chat => openai/gpt-4o`,
  `embeddings => openai/text-embedding-3-small`.
- `isUsable()` returns FALSE until a gateway is configured. `getConfiguredModels()` lists only
  the operator-enabled model IDs, enriching labels from the live catalogue when reachable.

## Config, routes, services

- Config object **`ai_provider_cloudflare_gateway.settings`** — `gateway` (cloudflare_gateway
  entity id), `cache_ttl` (int), `skip_cache` (bool), `metadata` (sequence), `models`
  (`chat`/`embeddings` sequences of model IDs). Schema in `config/schema/`, install defaults in
  `config/install/`.
- Two routes (`ai_provider_cloudflare_gateway.routing.yml`), both requiring
  **`_permission: 'administer ai providers'`**:
  `ai_provider_cloudflare_gateway.settings_form` at `/admin/config/ai/providers/cloudflare-gateway`
  (`CloudflareGatewayConfigForm`) and `…model_autocomplete` at `…/models-autocomplete`
  (`ModelAutocompleteController::handle`). Menu link under `ai.admin_providers`.
- Helper classes: `ModelLabel` (renders `id (owner) — $x in / $y out per 1M tokens`),
  `Http\SseContentCoercingStream` (streaming fix).

## Mechanism (from source)

- `loadGateway()` loads the configured `cloudflare_gateway` entity (throws
  `AiSetupFailureException` if none). `loadApiKey()` returns
  `gatewayClient->resolveCredentials($gateway)->apiToken` (empty string on failure, so
  availability checks don't fatal).
- `loadClient()` resolves credentials, sets the endpoint to
  `gatewayClient->buildBaseUri($gateway, EndpointStyle::OpenAiCompat, accountId)`, then builds an
  HTTP client via `http_client_factory->fromOptions(...)` with default cf-aig-* headers
  (`buildRequestHeaders`), the AI-settings request timeout, and a Guzzle handler that wraps
  `text/event-stream` bodies in `SseContentCoercingStream` before delegating to the base client.
- The gateway base URL is derived from admin-selected config/credentials, never from request
  input; credentials live in settings.php via cloudflare_sdk.
