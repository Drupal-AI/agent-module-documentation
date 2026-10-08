<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provisioning: primitive providers, asset kinds & capability

This module plugs its two resources into the `cloudflare_sdk` **primitive/asset framework** so a
gateway or Vectorize index becomes a first-class, provisionable, referenceable asset (like a
Worker or bucket in the rest of the suite). Three moving parts per resource: a **primitive
provider** (creates/inspects it via the management API), an **asset kind** (binds the primitive
type to its config entity), and — for the gateway — a **capability** the suite can deploy.

## Primitive providers (tagged `cloudflare_primitive_provider`)

Both implement `PrimitiveProviderInterface` directly and compose `PrimitiveSupport` (no base
class). Constructor deps: `CloudflareApiClientInterface` (from `cloudflare_api`) + `PrimitiveSupport`.

### `Primitive/GatewayProvider` — type `ai_gateway`

- `status()` — GET `accounts/{acct}/ai-gateway/gateways/{name}`; maps to `unknown` (account
  unavailable / token can't read AI Gateways), `missing` (not created), or `matching`.
- `fulfil()` — POST `accounts/{acct}/ai-gateway/gateways` with `{id, cache_ttl:0,
  cache_invalidate_on_update:false, collect_logs:true, rate_limiting_*:0/fixed}`; success also when
  `PrimitiveSupport::alreadyExists()`.
- `listExisting()` — GET the gateways collection → `[{name, detail: modified_on|created_on}]`.

### `Primitive/VectorizeProvider` — type `vectorize`

- `listExisting()` — GET `accounts/{acct}/vectorize/v2/indexes` → `[{name, detail: "{dims}d {metric}"}]`.
- `status()` — GET `…/vectorize/v2/indexes/{name}` (direct by name, since the name is the account
  identifier); `unknown`/`matching`/`missing`.
- `fulfil()` — POST `…/vectorize/v2/indexes` with `{name, config:{dimensions (default 768),
  metric (default cosine)}}` taken from `PrimitiveSpec::config`.

## Asset kinds (tagged `cloudflare_asset_kind, priority: 10`)

Both implement `AssetKindInterface`.

### `Asset/GatewayAssetKind`

`appliesTo('ai_gateway')`, `entityTypeId() = 'cloudflare_gateway'`. `ensure(assetId, label, type,
name, credentialsId)` loads-or-creates the gateway entity, sets label/slug/credentials and
`origin = managed`, saves. `url()` builds the OpenAi-compat base URI (via `GatewayClient` +
resolved account). `record()`/`clear()` are no-ops (a gateway URL is derived from config, nothing
runtime to store). `detail()` renders the **24h analytics** panel (see
[config/entities.md](../config/entities.md#gateway-detail-page)): a Cloudflare GraphQL
`aiGatewayRequestsAdaptiveGroups` query (variables: account tag, gateway slug, 24h window)
producing "N requests · X% cache hits", degrading to a translated notice without a secret or
`Analytics:Read`.

### `Asset/VectorizeAssetKind`

`appliesTo('vectorize')`, `entityTypeId() = 'cloudflare_vectorize_index'`. `ensure()` loads-or-
creates the index entity, sets label/index_name/credentials + `origin = managed`. `url()` returns
NULL (a Vectorize index has no public URL); `status()` reports origin; `record`/`clear`/`detail`
are no-ops. Re-ensuring an index created via the form keeps its dimensions/metric intact (those
fields aren't touched by `ensure`).

### `Asset/AiAssetTypes` (tagged `cloudflare_asset_type`)

Names both primitive types for the unified asset UI: `ai_gateway → "AI Gateway"`,
`vectorize → "Vectorize index"`.

## Capability plugin

`Plugin/CloudflareCapability/GatewayCapability` — `#[CloudflareCapability(id: 'ai_gateway',
module: 'cloudflare_ai', …)]`, extends `CloudflareCapabilityBase`. `requirements()` returns a
single `PrimitiveRequirement(new PrimitiveSpec('ai_gateway', $slug), 'AI Gateway', 'gateway')`
where `$slug` = trimmed `config['name']` or `'drupal-gateway'` — so a deployment name becomes the
gateway slug and multiple named gateways coexist. `isApplicable()` always TRUE. There is **no**
Vectorize capability plugin (Vectorize is provisioned via its provider/asset kind, not as a
deployable capability).

## `AssetOrigin` enum (`AssetOrigin`)

`Managed = 'managed'` (suite-provisioned) / `External = 'external'` (created outside Drupal, only
referenced). Config entities default to `external`; the asset kinds' `ensure()` flips a
provisioned entity to `managed`.
