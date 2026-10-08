<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Eloqua API Auth Fallback (eloqua_api_auth_fallback) — agent index

Submodule of **Eloqua API Redux**. Adds an OAuth **resource-owner password credentials grant** as a
fallback to the parent's interactive authorization-code flow, so the client can re-authenticate
non-interactively. Package `Eloqua`. Version **2.1.0**. Core `^8 || ^9 || ^10 || ^11`.
Depends on `eloqua_api_redux`.

- **Install, configuration, the decorated service, the Drush command, the token flow** →
  [config/settings.md](config/settings.md)

## What it provides

- **Service decoration** (`eloqua_api_auth_fallback.services.yml`):
  `eloqua_api_auth_fallback.auth_token_generate` → `Commands\EloquaAuthTokensGenerate`,
  `decorates: eloqua_api_redux.auth_fallback_default` (`decoration_priority: -10`, `public: false`).
  So the parent client's `getAccessTokenByRefreshToken()` calls this implementation of
  `EloquaAuthFallbackInterface::generateTokensByResourceOwner()` when both tokens are gone.
- **Drush command** (`drush.services.yml`, `eloqua_api_auth_fallback.commands`): the same class tagged
  `drush.command` — `eloqua_api_auth_fallback:generate-tokens` (alias **`eloqua-gt`**).
- **Route** `eloqua_api_auth_fallback.settings` (`eloqua_api_auth_fallback.routing.yml`): config form
  at `admin/config/services/eloqua_api_redux/auth_settings`, permission
  **`administer eloqua api settings`** (defined by the parent module; this submodule defines none).
- **Config object** `eloqua_api_auth_fallback.settings` (`sitename`, `username`, `password`) with a
  config schema in `config/schema/eloqua_api_auth_fallback.schema.yml`.
- **Menu link** under the parent's Eloqua API settings (`eloqua_api_auth_fallback.links.menu.yml`).
- No entities, no plugin types, no permissions of its own.

## Key class

`src/Commands/EloquaAuthTokensGenerate.php` — extends `DrushCommands`, implements
`EloquaAuthFallbackInterface`. Injected with `config.factory`, `logger.factory`, and
`eloqua_api_redux.client`. Its one method both serves the Drush command and the decorated service.
