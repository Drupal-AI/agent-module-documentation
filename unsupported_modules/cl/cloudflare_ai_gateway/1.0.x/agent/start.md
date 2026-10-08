<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare AI Gateway (cloudflare_ai_gateway) — agent index

A Drupal client for the **Cloudflare AI Gateway** (`gateway.ai.cloudflare.com`). It stores each
gateway as a config entity, builds the gateway's request URLs for the three endpoint styles, adds
the `cf-aig-*` control headers (caching, metadata, fallbacks), exposes the gateway's live model
catalogue, and registers a gateway as a first-class provisionable Cloudflare **primitive** (a
capability, provider and asset-kind) alongside Workers and buckets. It builds requests only — it
does not make the LLM calls itself; the separate
[`ai_provider_cloudflare_gateway`](https://www.drupal.org/project/ai_provider_cloudflare_gateway)
module uses a configured gateway to route the Drupal AI module through it.

Package `Cloudflare`. Core `^10.5 || ^11` (from `.info.yml`). PHP `>=8.3`. License
GPL-2.0-or-later. Installed as **1.0.0-alpha4** (version dir `1.0.x`).

> Project status (drupal.org): the standalone project is marked **Obsolete / Unsupported** — its
> code was consolidated unchanged into the broader **Cloudflare AI**
> (`drupal/cloudflare_ai`) module, which also adds Vectorize and AI Search. New sites should
> install `cloudflare_ai` instead. This doc set describes the code as shipped in the installed
> `cloudflare_ai_gateway` 1.0.0-alpha4 release.

## Dependencies

- Drupal modules (`.info.yml`): **`cloudflare_sdk`** (credential resolver, shared HTTP client
  factory, primitive/asset framework, the `administer cloudflare` permission) and
  **`cloudflare_api`** (Cloudflare REST + GraphQL client). Both required.
- Composer (`composer.json`): `php >=8.3`, `drupal/cloudflare_api:^1.0@alpha`,
  `drupal/cloudflare_sdk:^1.0@alpha`.
- No PHP libraries, no JS/CSS libraries, no Drush commands, no submodules.

## What it provides (from source)

- **Config entity** `cloudflare_gateway` (`src/Entity/Gateway.php`) — host, gateway_slug,
  credentials (ref), default_provider, origin. Admin UI at
  `/admin/config/services/cloudflare/gateways` (`configure:` link). Add/edit form
  `src/Form/GatewayForm.php`, list `src/GatewayListBuilder.php`, config schema
  `config/schema/cloudflare_ai_gateway.schema.yml`.
- **Gateway client** `GatewayClient` (`src/GatewayClient.php`, service
  `GatewayClientInterface`) — pure URL/header construction over the SDK's HTTP client factory;
  `listModels()` reads the OpenAI-compat `/models` endpoint. `GatewayRequestOptions` (immutable
  `cf-aig-*` value object), `EndpointStyle` enum (Passthrough/Universal/OpenAiCompat),
  `ModelCatalogue` (per-gateway 1h cache of the model list).
- **Primitive + asset integration** (Cloudflare suite): `Primitive/GatewayProvider`
  (`type: ai_gateway`, provisions/inspects gateways via the AI Gateway management API),
  `Asset/GatewayAssetKind` (a `cloudflare_gateway` entity IS the asset; contributes a 24h
  GraphQL analytics panel), `Asset/GatewayAssetTypes` (type label), `Plugin/CloudflareCapability/GatewayCapability`
  (`id: ai_gateway`), `GatewayOrigin` enum (managed/external).
- **Detail route** `entity.cloudflare_gateway.canonical` → `GatewayDetailController` (behind
  `administer cloudflare`). **Update hook** `_update_10001` installs `cloudflare_api`. One
  `hook_help`. This module defines **no permissions of its own** (uses `administer cloudflare`
  from `cloudflare_sdk`).

## Solution docs

- **Gateway config entity, form, schema, admin UI, detail page** → [config/gateway-entity.md](config/gateway-entity.md)
- **Gateway client, request options, endpoint styles, model catalogue** → [api/gateway-client.md](api/gateway-client.md)
- **Primitive provider, asset kind, capability, analytics (Cloudflare suite integration)** → [primitives/asset-integration.md](primitives/asset-integration.md)
