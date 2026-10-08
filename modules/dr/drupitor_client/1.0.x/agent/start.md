<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupitor Client (drupitor_client) — agent index

Site-side companion to the external **Drupitor** monitoring SaaS. Publishes one token-authenticated,
read-only JSON endpoint that reports available **Composer package updates** for the site. Package
`Development`. Depends only on core **`system`**, **`user`**. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.0. Disabled by default.

- **Config form, config object, keys, install defaults, `settings.php` overrides** →
  [config/settings.md](config/settings.md)
- **The API route, the custom token access check, and what the controller returns** →
  [api/endpoint.md](api/endpoint.md)

## What it provides (from source)

- **Route `drupitor_client.api_updates`** — `GET /drupitor/api/v1/updates`, `no_cache: TRUE`,
  `_controller: DrupitorClientController::getUpdates`, guarded by `_drupitor_api_access: TRUE`.
- **Route `drupitor_client.config`** — `/admin/config/development/drupitor-client`, form
  `DrupitorClientConfigForm`, `_permission: 'administer drupitor client'`.
- **Access check service `drupitor_client.api_access_check`** — class
  `src/Access/DrupitorApiAccessCheck.php`, tagged `access_check` with `applies_to: _drupitor_api_access`.
- **Controller** `src/Controller/DrupitorClientController.php` — runs `composer show --latest` via
  `proc_open()`, builds a package inventory, AES-encrypts it, returns JSON.
- **Permission** `administer drupitor client` (`restrict access: TRUE`).
- **Config object** `drupitor_client.settings` (install defaults in `config/install/`; there is **no
  `config/schema/`** — `provides_config_schema` is false).
- **Menu link** `drupitor_client.config` under `system.admin_config_development`.
- `hook_help()`, `hook_install()` (sets `enabled: FALSE`), `hook_requirements()` (runtime checks).
- No entities, no plugins, no services beyond the access check, no Drush, no submodules.

## Mechanism (from source)

- The endpoint returns nothing useful unless config `enabled` is TRUE **and** `api_token` is set **and**
  the caller presents the matching token **and** `encryption_key` is set (the controller throws → 500
  otherwise).
- Token is read by `DrupitorApiAccessCheck::getTokenFromRequest()` from, in order: `Authorization:
  Bearer <t>` / raw `Authorization: <t>`, `X-API-Token` header, or `?token=` query param.
- Token match uses `hash_equals($configured_token, $provided_token)` (timing-safe); an empty configured
  token yields `AccessResult::forbidden()`.
- Inventory is encrypted with `openssl_encrypt` (AES-256-GCM default, or AES-256-CBC) keyed by
  `hash('sha256', encryption_key, true)` before it leaves the site.
- The module makes **no outbound HTTP calls** — Drupitor polls this endpoint.
