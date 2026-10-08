<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entities, forms, credential model & detail page

The module ships **two config entities**, both admin-managed under
**Configuration → Web services** (menu links in `cloudflare_ai.links.menu.yml`). There is no
global settings form. Everything is gated by the `administer cloudflare` permission (defined by
`cloudflare_sdk`, used as each entity's `admin_permission`).

## Credential model (applies to both entities)

Neither entity stores a secret. Each stores a **credential-set machine name** in its
`credentials` field. The account ID and API token are resolved at call time from a
`cloudflare_credentials` entity (provided by `cloudflare_sdk`) whose secret comes from
settings.php/env via the SDK's `CredentialResolverInterface`. So exported config is safe to
commit — only the machine name leaves the site. The add/edit forms populate the credential
`#type: select` from `entityTypeManager->getStorage('cloudflare_credentials')->loadMultiple()`
(id → label); they never render a token field.

## `cloudflare_gateway` — AI Gateway (`Entity/Gateway`)

`#[ConfigEntityType(id: 'cloudflare_gateway', config_prefix: 'gateway', admin_permission:
'administer cloudflare')]`, `route_provider: AdminHtmlRouteProvider`, forms add/edit
`GatewayForm` + delete `EntityDeleteForm`. Implements `GatewayInterface extends
CloudflareAssetInterface` (so it is a referenceable suite asset).

`config_export` / schema (`cloudflare_ai.gateway.*`):

| field | type | default | notes |
|-------|------|---------|-------|
| `id` | machine_name | — | |
| `label` | required_label | — | |
| `host` | string | `https://gateway.ai.cloudflare.com` | form `#type: url`, required |
| `gateway_slug` | string | `''` | required; the gateway name in the CF dashboard; also `getResourceName()` |
| `credentials` | string | `''` | credential-set id; required |
| `default_provider` | string | `openai` | upstream provider for passthrough (e.g. `openai`, `workers-ai`) |
| `origin` | string | `external` | `AssetOrigin` value; `managed` once provisioned by the suite |

Getters: `getHost`, `getGatewaySlug`, `getCredentialsId`, `getDefaultProvider`, `getType()`
(→ `GatewayProvider::TYPE` = `ai_gateway`), `getResourceName()` (= slug), `getOrigin`,
`isManaged`/`isExternal`, `getSetting($key)` (only `host`/`default_provider`). Links: collection,
add/edit/delete, **canonical** (the detail page). Managed gateways are created by
`GatewayAssetKind::ensure()` (see [primitives/provisioning.md](../primitives/provisioning.md)).

### Gateway detail page

Route `entity.cloudflare_gateway.canonical` →
`/admin/config/services/cloudflare/gateways/{cloudflare_gateway}`, `_permission: 'administer
cloudflare'`, controller `Controller/GatewayDetailController::view`. Renders a core-fields table
(type, name, origin, credential id, resolved URL via `AssetResolverInterface::url`) then delegates
to the matched asset kind's `detail()`. `GatewayAssetKind::detail()` adds an **Analytics (last
24h)** panel: it resolves the account, runs a Cloudflare **GraphQL** query
(`aiGatewayRequestsAdaptiveGroups`, filtered by account + gateway slug + a 24h window, values
passed as GraphQL **variables**), and prints `"@total requests · @rate% cache hits"`. It degrades
gracefully to a translated notice when there is no credential/secret or the token lacks
`Analytics:Read`.

## `cloudflare_vectorize_index` — Vectorize index (`Entity/VectorizeIndex`)

`#[ConfigEntityType(id: 'cloudflare_vectorize_index', config_prefix: 'vectorize_index',
admin_permission: 'administer cloudflare')]`, forms add/edit `VectorizeIndexForm` + delete. Only
entity CRUD routes (no custom controller/detail). Implements `VectorizeIndexInterface extends
CloudflareAssetInterface`.

`config_export` / schema (`cloudflare_ai.vectorize_index.*`):

| field | type | default | notes |
|-------|------|---------|-------|
| `id` | machine_name | — | |
| `label` | required_label | — | |
| `index_name` | string | `''` | required; the CF index name (its account identifier); also `getResourceName()` |
| `dimensions` | integer | 768 | form `#type: number`, **min 32 / max 1536**, required; fixed at index creation |
| `metric` | string | `cosine` | select: `cosine` / `euclidean` / `dot-product` (`VectorizeMetric` enum); fixed at creation |
| `credentials` | string | `''` | credential-set id; required |
| `origin` | string | `external` | `managed` once provisioned |

Getters mirror the gateway (`getIndexName`, `getDimensions` (cast int), `getMetric`,
`getCredentialsId`, `getType()` = `vectorize`, `getResourceName()` = index name, origin flags,
`getSetting` for `dimensions`/`metric`). The `VectorizeMetric` enum (`VectorizeMetric.php`) has a
`::isValid(string)` helper. Managed indexes are created by `VectorizeAssetKind::ensure()`.

## List builders

`GatewayListBuilder` (label / gateway slug / credential set) and `VectorizeIndexListBuilder`
(label / index name / dimensions / metric / credential set) add columns to the default entity
list at each collection route. Action links (`cloudflare_ai.links.action.yml`) add "Add AI
gateway" / "Add Vectorize index" on both the entity collections and the suite's unified
`entity.cloudflare_asset.collection`.
