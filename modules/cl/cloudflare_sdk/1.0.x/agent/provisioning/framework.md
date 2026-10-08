<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provisioning framework: capabilities, primitives, reconciler, assets

This is the declare-and-reconcile machinery the suite uses to create/track Cloudflare resources.
`cloudflare_sdk` ships the framework and the generic catch-all; concrete capability plugins,
primitive providers and deployment appliers are contributed by upstream suite modules. (This layer
was moved here from `cloudflare_api`.)

## Capability plugin type (`cloudflare_capability`)

An attribute-discovered plugin type (this is the plugin type the module provides):

- Attribute `Attribute/CloudflareCapability` (`#[CloudflareCapability(id, label, description?,
  module?, usage?, deriver?)]`).
- Manager `CloudflareCapabilityPluginManager` — dir `Plugin/CloudflareCapability`, interface
  `CloudflareCapabilityInterface`, alter hook `cloudflare_capability_info`, cache key
  `cloudflare_capability_plugins`. Service `plugin.manager.cloudflare_capability`.
- Base `Capability/CloudflareCapabilityBase` — supplies id/label/description/module/usage from the
  definition; empty `settingsForm`/`validateSettings` by default.
- Interface `CloudflareCapabilityInterface`: a capability declares which primitives it needs via
  `requirements(CredentialsInterface, array $config): PrimitiveRequirement[]` and carries UI
  metadata + an optional deployment `settingsForm()`. **A capability never provisions anything
  itself.**

`Capability/PrimitiveRequirement` (readonly): a `PrimitiveSpec` + label + `role` (stable key,
defaults to the spec type) + `optional` flag.

A test capability lives in `tests/modules/cloudflare_sdk_test`
(`Plugin/CloudflareCapability/TestCapability`) — test fixture only, not shipped.

## Primitives

`Primitive/PrimitiveProviderInterface` — a tagged service (`cloudflare_primitive_provider`, keyed by
`type()`) that provisions/inspects one primitive type. Contract: `status()` and `listExisting()` are
GET-only and must be forbidden-safe (return unknown/empty when the token can't read); only
`fulfil()` writes and must be idempotent.

Value objects:
- `PrimitiveSpec` (readonly) — desired state: `type`, `name`, `config` map (interpreted by the
  owning provider).
- `PrimitiveResult` (readonly) — `ok`, `message`, `details`, `url`; `::success()` / `::failure()`.
- `PrimitiveStatus` — live status (`checkable`, `exists`, …; `::unknown()` when unreadable).
- `PrimitiveSupport` (`autowire`) — shared helpers by composition (not a base class): `resolve()`
  / `account()` credential resolution, `alreadyExists()` (treats "exist"/"duplicate" errors as
  success), `firstError()`.
- `PrimitiveProviderRegistry` (`service_collector` tag `cloudflare_primitive_provider`) — `get(type)`
  routes to the provider owning a type.

## Reconciler

`Reconcile/Reconciler` (`ReconcilerInterface`, `autowire`) —
`reconcile(string $capabilityId, CredentialsInterface, array $config): ReconcileStepResult[]`:

1. Instantiate the capability; unknown → one `failed` result.
2. Compute `writeCapable` via `TokenCapabilityResolver::resolve()->allowsWrite()`.
3. For each `requirement()`, either **linked** (adopt an existing asset named in
   `config['adoptions'][role]`) or **managed** (provision it):
   - *managed*: refuses without a read-write token; calls the provider's `fulfil()`; on success
     `ensure()`s a `cloudflare_asset` via the type's asset kind and records outputs in State.
   - *linked*: loads the referenced asset, checks the provider `status()`, records `linked`/
     `verified`/`missing`.
4. Run matching **deployment appliers** over the provisioned assets.

`Reconcile/ReconcileStepResult` (readonly) — `role`, `label`, `outcome`
(`provisioned`/`linked`/`verified`/`failed`/`skipped`), `assetId`, `url`, `message`, `entityType`;
`ok()` = outcome ≠ failed; static factories per outcome. Managed asset ids are deterministic slugs
(`<deployment>__<role>`).

## Deployment appliers

`Deployment/DeploymentApplierInterface` — post-provision follow-on config (e.g. wiring new assets
into a feature). Tagged `cloudflare_deployment_applier`; `applies(capabilityId)` + idempotent
`apply(DeploymentApplyContext): ReconcileStepResult[]`. `DeploymentApplierRegistry`
(`service_collector`) `forCapability()` selects the matching ones. `DeploymentApplyContext` carries
the capability id, credentials, `settings`, and the provisioned assets keyed by role.

## Asset registry (kinds & resolver)

Runtime side of an asset (its URL/status), separate from the config entity's stored intent.

- `Asset/AssetKindInterface` + `AssetKindRegistry` (`service_collector` tag `cloudflare_asset_kind`,
  priority-ordered) — `forType()`/`forAsset()` return the first kind whose `appliesTo()` matches;
  specific kinds outrank the catch-all.
- `Asset/GenericAssetKind` (tag priority `-100`, catch-all) — `ensure()` creates/updates a
  `cloudflare_asset`; `url()`/`status()` resolve from State for managed assets (or the stored
  `endpoint` for external ones); `record()`/`clear()` write/delete State keys
  `cloudflare_sdk.asset.{url,status,checked}.<id>`.
- `Asset/AssetResolver` (`AssetResolverInterface`, `autowire`) — thin front over the registry:
  `url()`/`status()`/`record()`/`clear()` delegate to the owning kind (`clear()` fans out to all
  kinds since the asset may be gone).
- `Asset/AssetOutputs` (readonly) — `url`, `statusLabel`, `detail`, `checked` timestamp.
- `Asset/AssetTypeRegistry` (`service_collector` tag `cloudflare_asset_type`) — collects
  type-id→label mappings from upstream modules; powers the asset form's type select + detail labels.

## Resource lister

`Resource/AccountResourceLister` (`AccountResourceListerInterface`, `autowire`) —
`list(credentials, primitiveType)` delegates to the type's provider `listExisting()` (empty list for
an unknown type). Powers the "link existing" adoption picker.
