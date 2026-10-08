<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OAuth 1.0 (oauth) — agent index

OAuth **1.0a** two-legged server authentication for Drupal. Registers a Drupal
authentication provider that validates `Authorization: OAuth ...` signed requests via the
PHP **PECL `oauth` extension** (`OAuthProvider`). Version **8.x-2.6**, core `^10.3 || ^11`.

## Dependencies
- Drupal: core `system` only (`oauth.info.yml`).
- Runtime: the **PECL `oauth` PHP extension** — enforced by `oauth_requirements()` in
  `oauth.install` (REQUIREMENT_ERROR if `\OAuthProvider` class is missing). No composer.json.

## What it provides
- **Authentication provider** `authentication.oauth` (`OAuthDrupalProvider`, tag
  `authentication_provider` provider_id `oauth`, priority 100) — `applies()` matches the
  `Authorization: OAuth` header; `authenticate()` runs `OAuthProvider::checkOAuthRequest()`
  in `is2LeggedEndpoint(TRUE)` mode.
- **Consumer credentials** — per-user key/secret pairs stored in core `users_data`
  (module key `oauth`); no custom entity. Managed via forms.
- **Nonce table** `oauth_nonce` (`oauth_schema()` in `oauth.install`) for replay protection;
  `oauth_cron()` deletes nonces older than 24h.
- **Access checker** `oauth.access_checker` (`_oauth_access_check`, `CustomAccessCheck`).
- **Page-cache policy** `DisallowOauthRequests` — never cache OAuth-authenticated responses.
- **Config object** `oauth.settings` (keys `request_token_lifetime`, `login_path`).

## Routes
- `oauth.admin_form` — `/admin/config/services/oauth` — perm `administer oauth`.
- `oauth.user_consumer` — `/user/{user}/oauth/consumer` (list) — `_oauth_access_check`.
- `oauth.user_consumer_add` — `/oauth/consumer/add/{user}` — `_oauth_access_check`.
- `oauth.user_consumer_delete` — `/oauth/consumer/delete/{user}/{key}` — `_oauth_access_check`.

## Permissions (`oauth.permissions.yml`, all `restrict access: TRUE`)
`access own consumers`, `oauth register any consumers`, `administer oauth`,
`administer consumers`.

## Solution docs
- [agent/config/settings.md](config/settings.md) — install, PECL requirement, `oauth.settings`,
  consumer management, admin form.
- [agent/api/authentication-provider.md](api/authentication-provider.md) — the provider,
  signature/nonce handling, routes, access check, page-cache policy.

Note: OAuth 1.0a is a compatibility layer; new integrations usually prefer OAuth 2.0
(`simple_oauth`). Use this when a client mandates 1.0a.
