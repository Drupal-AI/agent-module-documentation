<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare AI (cloudflare_ai) — agent index

The **AI-group resource layer** of the Cloudflare suite. Two things: (1) an **AI Gateway
client** that builds gateway URLs + `cf-aig-*` control headers, and (2) two provisionable,
referenceable **config-entity assets** — an **AI Gateway** and a **Vectorize index** — each
with a data-plane/management client. No user-facing AI feature of its own: it is the plumbing
that `ai_provider_cloudflare_gateway` (and your own code) build on. Package `Cloudflare`.
Core `^10.5 || ^11 || ^12`. PHP `>=8.3`. License GPL-2.0-or-later. Installed **1.0.0-alpha3**
(version dir `1.0.x`).

Secrets are never in configuration: the account ID and API token are resolved at call time
from a **credential set** (a `cloudflare_credentials` entity provided by `cloudflare_sdk`,
backed by settings.php/env). Config entities store only the credential set's machine name.

> Workers AI is **not** a provisionable resource here — it is stateless inference reached
> *through* the AI Gateway, so there is nothing to configure for it.

## Dependencies

- Drupal modules (required, from `.info.yml`): **`cloudflare_sdk`** (credential framework,
  shared HTTP client factory, primitive/asset framework) and **`cloudflare_api`** (the
  Cloudflare v4/GraphQL client). Composer: `drupal/cloudflare_sdk:^1.0@alpha`,
  `drupal/cloudflare_api:^1.0@alpha`.
- No third-party PHP libraries, no bundled JS/CSS libraries.

## What it provides (from source)

- **Config entity `cloudflare_gateway`** (`Entity/Gateway`) — host (default
  `https://gateway.ai.cloudflare.com`), gateway slug, credential-set ref, default provider
  (default `openai`), origin (managed/external). Add/edit form `Form/GatewayForm`, list
  builder, and a **detail route** `entity.cloudflare_gateway.canonical`
  (`/admin/config/services/cloudflare/gateways/{cloudflare_gateway}`,
  `Controller/GatewayDetailController`) showing core fields + a 24h analytics panel.
- **Config entity `cloudflare_vectorize_index`** (`Entity/VectorizeIndex`) — index name,
  dimensions (default 768, form range 32–1536), metric (`cosine`/`euclidean`/`dot-product`),
  credential-set ref, origin. Form `Form/VectorizeIndexForm`, list builder. Entity CRUD
  routes only (no custom controller).
- **`GatewayClient`** (`GatewayClient`, iface `GatewayClientInterface`) — pure URL/header
  construction over the SDK HTTP client factory: `buildBaseUri`, `buildRequestHeaders`,
  `resolveCredentials`, `createClient`, `listModels`. Endpoint styles in `Endpoint/EndpointStyle`
  (Passthrough / Universal / OpenAiCompat). Per-request controls in `GatewayRequestOptions`
  (`cf-aig-cache-ttl`, `-skip-cache`, `-metadata`, `-cache-key`). `ModelCatalogue` caches
  `listModels` per gateway for 1h.
- **`VectorizeClient`** (iface `VectorizeClientInterface`) — stateless vector data plane over
  the Vectorize **v2** REST API (`api.cloudflare.com/client/v4/…/vectorize/v2/indexes`):
  `describeIndex`, `createIndex`, `deleteIndex`, `upsert` (NDJSON), `query`, `getByIds`,
  `deleteByIds`.
- **Primitive providers** (tagged `cloudflare_primitive_provider`) — `Primitive/GatewayProvider`
  (type `ai_gateway`) and `Primitive/VectorizeProvider` (type `vectorize`): provision + inspect
  the resource via the Cloudflare management API (`status`/`fulfil`/`listExisting`).
- **Asset kinds** (tagged `cloudflare_asset_kind`) — `Asset/GatewayAssetKind`,
  `Asset/VectorizeAssetKind`: bind each primitive type to its config entity, `ensure()` a
  managed entity, expose URL/detail. `Asset/AiAssetTypes` names both types for the unified asset
  UI. `AssetOrigin` enum (managed/external).
- **Capability plugin** `Plugin/CloudflareCapability/GatewayCapability` (id `ai_gateway`) —
  declares a single AI Gateway primitive requirement so the suite can deploy a managed gateway.
- **Hooks** — `Hook/CloudflareAiHooks::help()` only (help.page.cloudflare_ai), with a
  `#[LegacyHook]` shim in `cloudflare_ai.module`. No install/schema/update hooks.
- **Permission** — none of its own; everything is gated by `administer cloudflare` (from
  `cloudflare_sdk`). `configure` → `entity.cloudflare_gateway.collection`.
- **Config schema** (`config/schema/cloudflare_ai.schema.yml`) for both config entities.

## Solution docs

- **Config entities, forms, schema, credential model, detail page** → [config/entities.md](config/entities.md)
- **AI Gateway client, endpoint styles, request options, model catalogue** → [api/gateway-client.md](api/gateway-client.md)
- **Vectorize data-plane client (upsert/query/get/delete)** → [api/vectorize-client.md](api/vectorize-client.md)
- **Provisioning: primitive providers, asset kinds, capability plugin** → [primitives/provisioning.md](primitives/provisioning.md)
