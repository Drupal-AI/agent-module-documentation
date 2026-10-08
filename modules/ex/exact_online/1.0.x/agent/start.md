<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exact Online (exact_online) — agent index

OAuth2 API-connection middleware between Drupal and the **Exact Online** accounting/ERP
platform, built on the `picqer/exact-php-client` library. It sets up and maintains the
connection only — it ships **no** data-sync features; sync is custom code written against
the `\Picqer\Financials\Exact\Connection` returned by `exact_online.service`.

- **Version dir:** 1.0.x (installed `1.0.0-alpha1`). Core `^10 || ^11`. Package `Custom`.
- **Dependencies:** Drupal core only + Composer lib `picqer/exact-php-client:^4.4`. No module deps, no submodules.
- **Provides:** 3 permissions, config object + schema, 2 services, 6 routes, 2 controllers, 2 forms. No entities, no plugin types, no Drush commands, no hooks file (`.module`/`.install` absent).

## What it provides

- **Services** (`exact_online.services.yml`):
  - `exact_online.service` → `ExactOnlineService` (implements `ExactOnlineServiceInterface`) — connection lifecycle, tokens, rate limits, logs.
  - `exact_online.token_expiration_notifier` → `TokenExpirationNotifier` — emails a warning when the token is expiring (see caveats in api doc).
- **Config:** `exact_online.settings` (schema `config/schema/exact_online.schema.yml`): `client_id`, `callback_url`, `base_url`, `division`.
- **State keys:** `exact_online.client_secret`, `exact_online.tokens`, `exact_online.api_rate_limits.*`, `exact_online.logs`, `exact_online.reconnect_notification`, `exact_online.last_expiration_notification`.
- **Permissions** (`exact_online.permissions.yml`): `administer exact online configuration` (restricted), `access exact online dashboard`, `access exact online logs`.
- **Routes** (`exact_online.routing.yml`): dashboard, settings, authorize, callback, reset, logs — under `/admin/config/services/exact-online` (plus `/exact-online/callback`).
- **Menu links** (`exact_online.links.menu.yml`): Connection / Settings / Logs under Configuration › Services.

## Solution docs

- [config/settings.md](config/settings.md) — install/enable, settings form, config object + schema, where each credential/token is stored.
- [api/service.md](api/service.md) — the `exact_online.service` API (connection, tokens, rate limits, logs) and the token-expiration notifier.
- [routes/routes.md](routes/routes.md) — routes, controllers, forms, permissions and the admin dashboard/log UIs.
