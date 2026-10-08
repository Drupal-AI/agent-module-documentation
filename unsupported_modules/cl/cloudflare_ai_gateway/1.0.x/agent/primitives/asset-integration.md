<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Primitive provider, asset kind, capability & analytics

The module plugs a gateway into the Cloudflare SDK's unified primitive/asset framework, so a
gateway is provisionable and inspectable like a Worker or R2 bucket rather than only hand-configured.
All four services are declared in `cloudflare_ai_gateway.services.yml`.

## Capability — `GatewayCapability`

`src/Plugin/CloudflareCapability/GatewayCapability.php`, `#[CloudflareCapability(id: 'ai_gateway',
...)]` (extends `CloudflareCapabilityBase`). Declares a single AI Gateway primitive requirement:
`requirements()` builds a `PrimitiveRequirement(new PrimitiveSpec(GatewayProvider::TYPE, $slug),
'AI Gateway', 'gateway')` where `$slug` = trimmed `config['name']`, defaulting to
`drupal-gateway`. So the deployment/config name becomes the gateway slug and multiple named
gateways coexist. `isApplicable()` always TRUE.

## Provider — `GatewayProvider`

`src/Primitive/GatewayProvider.php`, tagged `cloudflare_primitive_provider`, implements
`PrimitiveProviderInterface`. `const TYPE = 'ai_gateway'`. Deps: `cloudflare_api`
`CloudflareApiClientInterface` + SDK `PrimitiveSupport`. Calls target
`accounts/{account}/ai-gateway/gateways...`:

- `status(creds, spec)` — `GET .../gateways/{name}`; maps `forbidden`→unknown ("Token cannot read
  AI Gateways"), `!ok`→missing ("Not created"), ok→matching ("Gateway exists"). Account resolved
  via `PrimitiveSupport::account()`.
- `fulfil(creds, spec)` — `POST .../gateways` with a default payload (`id`=spec name,
  `cache_ttl:0`, `cache_invalidate_on_update:false`, `collect_logs:true`, rate-limiting all 0 /
  `fixed`). Success on ok OR `alreadyExists`; else failure with the API's first error.
- `listExisting(creds)` — `GET .../gateways`; returns `[{name, detail}]` (detail =
  `modified_on`/`created_on`).

## Asset kind — `GatewayAssetKind`

`src/Asset/GatewayAssetKind.php`, tagged `cloudflare_asset_kind` (priority 10), implements
`AssetKindInterface`. Bridges the `ai_gateway` primitive to the `cloudflare_gateway` config
entity — the entity **is** the asset (no separate runtime outputs).

- `appliesTo('ai_gateway')` TRUE; `entityTypeId()` = `cloudflare_gateway`.
- `ensure(assetId, label, type, name, credentialsId)` — loads-or-creates the gateway entity, sets
  label/slug/credentials and `origin = managed`, saves, returns it. This is how provisioning
  materialises a managed gateway.
- `url(asset)` — resolves the account from the credential and returns
  `GatewayClient::buildBaseUri(asset, OpenAiCompat, account)`; NULL if the account can't resolve.
- `record()` / `clear()` — no-ops (URL is derived from config; nothing runtime to store).
- `status(asset)` — `['label' => origin, 'detail' => []]`.
- `detail(asset)` — a "Analytics (last 24h)" details element whose body is `analytics()`.

### 24h analytics (`analytics()`)

Loads the gateway's credential, resolves the account, and runs a Cloudflare **GraphQL** query via
`cloudflare_api`'s `graphql()` over `aiGatewayRequestsAdaptiveGroups`. The account tag and gateway
slug are passed as **bound GraphQL variables** (`$tag`, `$gw`, `$start`, `$end` = now-24h..now),
not string-concatenated. It counts cached vs uncached groups and renders "`N requests · R% cache
hits`". Degrades gracefully: "No credential." / "No secret in settings.php." / "Analytics
unavailable (…). A token with Analytics:Read shows requests and cache hit-rate here." / "No
requests in the last 24h." — error strings do not leak the secret.

## Asset type label — `GatewayAssetTypes`

`src/Asset/GatewayAssetTypes.php`, tagged `cloudflare_asset_type`. `labels()` maps
`ai_gateway → t('AI Gateway')` for the unified asset UI.

## Origin enum

`src/GatewayOrigin.php`: `Managed` (`managed`, suite-provisioned) / `External` (`external`,
created outside Drupal, only referenced). Set to `managed` by `ensure()`; defaults to `external`
on hand-created entities.
