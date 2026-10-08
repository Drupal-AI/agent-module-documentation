<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Api Sync BasicAuth module (apisync_basicauth) — agent index

Submodule of [apisync](../../../../1.0.x/agent/start.md). Ships one auth provider plugin. Package `liip`, core `^9.1 || ^10 || ^11`, PHP `>=8.1`. No services, routes, permissions, or config schema of its own.

## What it provides
- **Auth plugin** `Drupal\apisync_basicauth\Plugin\ApiSyncAuthProvider\ApiSyncBasicAuthPlugin` — `@Plugin(id="basic_auth", label="Basic Authentication")`, extends `ApiSyncAuthProviderPluginBase`.
  - `isTokenBasedProvider(): FALSE`; `getAccessToken()`/`hasAccessToken()` return NULL/FALSE; `clearAccessToken()`/`refreshAccessToken()` are no-ops.
  - `defaultConfiguration()`: `login_user => ''`, `login_password => ''`.
  - `buildConfigurationForm()`: a `textfield` Username and a `password` field.
  - `appendAuthHeaders()`: returns `Authorization: 'Basic ' . base64_encode(login_user:login_password)`; throws `IdentityNotFoundException` when credentials are empty.

## Configure
Enable the module, then create/edit an `apisync_auth` config at `/admin/config/apisync/authorize`, select **Basic Authentication**, and enter the username/password. These land in the entity's `provider_settings`. Set the global `instance_url` to `https://…` so the Basic credentials are sent over TLS.

## Install
`apisync_basicauth.install`: `apisync_basicauth_update_9100()` clears the legacy `instance_url` from `apisync_basicauth.settings` (the URL moved to `apisync.settings`).
