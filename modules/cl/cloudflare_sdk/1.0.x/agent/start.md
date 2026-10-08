<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare SDK (cloudflare_sdk) — agent index

The **base framework layer** for the Cloudflare module suite. It provides named **credential
sets** (thin config entities), **secret resolution** of account ID + API token from `settings.php`
(nothing account-specific is stored in config or the DB), a shared **HTTP client factory** the
sibling modules build their clients on, a **Cloudflare asset registry** (a `cloudflare_asset`
config entity + an asset-kind/resolver framework), and a **provisioning framework** (capability
plugins, primitives, a reconciler and deployment appliers) that feature modules drive to create
and reconcile Cloudflare resources. It makes no calls to Cloudflare by itself. Package
`Cloudflare`. Core `^10.5 || ^11 || ^12`. PHP `>=8.3`. License GPL-2.0-or-later. Installed as
**1.0.0-alpha7** (version dir `1.0.x`); not covered by the security advisory policy (alpha).

## Dependencies

- Drupal module: **`cloudflare_api`** (required, from `.info.yml` / `composer.json`) — the
  standalone Cloudflare API client this framework wraps.
- PHP: **`>=8.3`**.
- Suggested: **`drupal/key`** — enable the bundled **`cloudflare_sdk_key`** submodule to resolve a
  credential set's token from a Key instead of `settings.php`.

## What it provides (from source)

- **`cloudflare_credentials`** config entity (`Entity/Credentials`) — machine name + label only
  (`config_export: [id, label]`). The account ID and token are NOT entity fields; they live in
  `settings.php`. Admin permission `administer cloudflare`. Full CRUD UI under
  `/admin/config/services/cloudflare/credentials` (routes from `AdminHtmlRouteProvider`).
- **`cloudflare_asset`** config entity (`Entity/CloudflareAsset`) — durable intent for a tracked
  Cloudflare resource (`type`, `name`, `credentials`, `origin` managed/external, `settings`).
  Runtime outputs (resolved URL, last status) are kept in **State**, never in config. UI under
  `/admin/config/services/cloudflare/assets`, plus a canonical detail route
  (`AssetDetailController`, `cloudflare_sdk.routing.yml`).
- **Credential resolution**: `CredentialResolverInterface` → default `SettingsCredentialResolver`
  (reads `$settings['cloudflare']['credentials'][<id>]`). Decoratable (the submodule does so).
- **HTTP plumbing**: `CloudflareHttpClientFactory` (binds a base URI + default headers over core's
  `ClientFactory`) and `HeaderInjectingHttpClient` (a PSR-18 decorator adding fixed headers).
- **Token capability detection**: `TokenCapabilityResolver` — verifies a token and classifies it
  read-only / read-write (declared scope, else auto-introspection), cached.
- **Provisioning framework**: a `cloudflare_capability` plugin type (attribute + manager +
  `CloudflareCapabilityBase`), primitive providers, a `Reconciler`, deployment appliers, and an
  `AccountResourceLister`. Capability plugins themselves are supplied by upstream suite modules.
- **Permission** (`.permissions.yml`): `administer cloudflare` (`restrict access: true`). **Config
  schema** for both config entities + third-party settings. Hooks via OOP `Hook/CloudflareSdkHooks`
  (help, `cloudflare_asset` delete cleanup, credentials-form scope field) with `#[LegacyHook]`
  shims in `.module`.

## Submodule

- **Cloudflare SDK Key** (`cloudflare_sdk_key`) — optional; resolves a credential set's token from
  a **Key** entity instead of `settings.php`. Docs:
  [modules/cloudflare_sdk_key/1.0.x/agent/start.md](../modules/cloudflare_sdk_key/1.0.x/agent/start.md).

## Solution docs

- **Credential + asset config entities, forms, admin routes, schema, permission, token scope** →
  [config/credentials-and-assets.md](config/credentials-and-assets.md)
- **Secret resolution, settings.php format, HTTP client factory, header injector, exceptions,
  token-capability detection** → [api/http-and-credentials.md](api/http-and-credentials.md)
- **Provisioning framework: capability plugin type, primitives, reconciler, deployment appliers,
  asset kinds/resolver, resource lister** → [provisioning/framework.md](provisioning/framework.md)

## Credential model (quick reference)

```php
// settings.php — keyed by the credential set's machine name.
$settings['cloudflare']['credentials']['my_account'] = [
  'account_id' => 'your-cloudflare-account-id',
  'token' => 'your-cloudflare-api-token',
];
```
