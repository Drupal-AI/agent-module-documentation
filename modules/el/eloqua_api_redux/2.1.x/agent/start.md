<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Eloqua API Redux (eloqua_api_redux) — agent index

OAuth client and REST wrapper for the **Oracle Eloqua** marketing-automation API. Provides a shared
HTTP client service plus `Contact` and `Forms` convenience services other modules build on. Package
`Eloqua`. Version **2.1.0**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. No Drupal module
dependencies (main module); ships one submodule.

- **Install, configuration, the OAuth flow, routes, permissions, services, token/base-URL handling** →
  [config/settings.md](config/settings.md)
- **The client + Contact/Forms API surface (methods and endpoints)** → [api/client.md](api/client.md)
- **Submodule** `eloqua_api_auth_fallback` (resource-owner password grant, Drush command) is documented
  in its own tree: `modules/el/eloqua_api_redux/modules/eloqua_api_auth_fallback/2.1.x/`.

## What it provides

- **Services** (`eloqua_api_redux.services.yml`):
  - `eloqua_api_redux.client` → `Service\EloquaApiClient` (implements `EloquaApiClientInterface`) —
    token exchange, token storage, base-URL resolution, generic `doEloquaApiRequest()`.
  - `eloqua_api_redux.auth_fallback_default` → `Service\EloquaAuthDefaultFallback` — a no-op default
    (returns FALSE) that the submodule **decorates** to add password-grant re-auth.
  - `eloqua_api_redux.contact` → `Service\Contact` (create/get/update/delete contacts, get by email).
  - `eloqua_api_redux.forms` → `Service\Forms` (list forms, get form, get form fields, submit form data).
- **Routes** (`eloqua_api_redux.routing.yml`), both gated by permission `administer eloqua api settings`:
  - `eloqua_api_redux.settings` — config form at `admin/config/services/eloqua_api_redux`.
  - `eloqua_api_redux.callback` — GET `eloqua_api_redux/callback`, the OAuth authorization-code return
    handler (`Controller\Callback::callbackUrl`).
- **Permission** (`eloqua_api_redux.permissions.yml`): `administer eloqua api settings` (restricted).
- **Config object**: `eloqua_api_redux.settings` (`client_id`, `client_secret`, `api_uri`). No config
  schema shipped by the main module.
- **State keys** (persistent token storage, not config): `eloqua_api_redux.access_token`,
  `eloqua_api_redux.refresh_token`, `eloqua_api_redux.api_base_uri` — each `{value, expire}`.
- **No entities, no plugin types, no Drush** in the main module.

## Notes

- `eloqua_api_redux.post_update_move_tokens` migrates tokens out of the old `eloqua_api_redux.tokens`
  config object into State (that config object is now unused/deleted).
- Consumer example on drupal.org: the Webform Eloqua module.
