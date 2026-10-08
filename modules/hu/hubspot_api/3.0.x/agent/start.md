<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hubspot API (hubspot_api) — agent index

A **developer library** that wraps the official `hubspot/api-client` PHP SDK and hands other code an
authenticated HubSpot client. No entities, no fields, no content feature of its own — package
`Hubspot`, core `^10.4 || ^11`, PHP `8.1`, license GPL-2.0-or-later, version 3.0.0.

- **Install, credentials (Private App token + OAuth), the settings form, config, routes** →
  [config/settings.md](config/settings.md)
- **The `hubspot_api.manager` / `hubspot_api.oauth` services and how to call the API** →
  [api/manager.md](api/manager.md)

## What it actually is

- **One composer dependency:** `hubspot/api-client:^10` (no Drupal module dependencies).
- **Two services** (`hubspot_api.services.yml`):
  - `hubspot_api.manager` → `Drupal\hubspot_api\Manager` (implements `ManagerInterface`). Returns a
    `HubSpot\Discovery\Discovery` handler: `getHandler()` prefers OAuth, falls back to the Private
    App token; `getHandlerWithOauth()`; `getHandlerWithAccessToken(?$token)`.
  - `hubspot_api.oauth` → `Drupal\hubspot_api\Services\OAuth`. Authorization-code + refresh-token
    exchange via the SDK (`getTokensByCode()`, `getTokensByRefresh()`, `saveTokens()`).
- **One config form:** `Drupal\hubspot_api\Form\SettingsForm` (id `hubspot_api_settings`) at route
  `hubspot_api.settings` → `/admin/config/services/hubspot-api`. Writes config object
  `hubspot_api.settings` (`access_key`, `client_id`, `client_secret`).
- **One controller:** `Drupal\hubspot_api\Controller\OAuth::oauthRedirect()` at route
  `hubspot_api.oauth_redirect` → `/hubspot_api/oauth-redirect` — the OAuth callback that reads the
  `code` query param and stores tokens.
- **Constants** in `Drupal\hubspot_api\Enum\HubSpotEnum`: config key `hubspot_api.settings`, state
  key `hubspot_api_tokens`, logger channel `hubspot_api`.
- OAuth access/refresh tokens live in **State** (`hubspot_api_tokens`), not config.
- **No permissions of its own** (both routes require core `administer site configuration`), **no
  Drush commands**, **no plugins**, **no hooks** except `hook_help()` rendering the README.

## Credential model (from source)

- **Private App token** — stored in config `hubspot_api.settings:access_key`; `getHandler()` uses it
  via `Factory::createWithAccessToken()` when no OAuth tokens exist.
- **OAuth 2.0** — `client_id` / `client_secret` in config; the Authorize button (`SettingsForm::
  oauthAuthorizeSubmit()`) builds the HubSpot auth URL (`HubSpot\Utils\OAuth2::getAuthUrl`, scopes
  `content`, `oauth`) and redirects; the callback exchanges the `code` for access + refresh tokens,
  saved to State. `Manager::getHandlerWithOauth()` refreshes automatically when the access token is
  within ~15 min of its 6-hour expiry.
