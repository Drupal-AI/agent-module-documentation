<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microsoft Graph API (ms_graph_api) — agent index

Developer-only connection/client layer for **Microsoft Graph** (Microsoft 365 / Entra ID). No
site-builder or end-user features. Package `MS Graph API`. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version **2.0.0-beta2** (**beta**; project marked *Seeking new maintainer* / *No
further development*).

Depends on contrib **`key`** (`key:key`) and, via Composer, on the official Graph SDK
`microsoft/microsoft-graph:^1.36.0`, `drupal/key:^1.14`, `guzzlehttp/uri-template:^1.0`. Install
with Composer so the SDK is pulled in.

- **Get an authenticated client, the factory API, the token exchange, and the Key type** →
  [api/graph-factory.md](api/graph-factory.md)
- **Settings form, config objects/schema, the default Key, install** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Services** (`ms_graph_api.services.yml`):
  - `ms_graph_api.graph.factory` → `Drupal\ms_graph_api\GraphApiGraphFactory` (args
    `@config.factory`, `@key.repository`). The real API.
  - `ms_graph_api.graph` → a `Microsoft\Graph\Graph`, produced by the factory's
    `buildDefaultGraph()`. The ready-to-use default client.
  - `ms_graph_api.graph.tenant_domain` → `SplString` from `getDefaultTenantDomain()`
    (tagged `parameter_service`).
- **Plugins** (extend Key module base plugins, not new plugin types):
  - `KeyType` `ms_graph_api` — `GraphApiKeyType` (multivalue: `tenant_id`, `client_id`,
    `client_secret`), extends `AuthenticationMultivalueKeyType`.
  - `KeyInput` `ms_graph_api` — `GraphApiKeyInput`, collects tenant_domain + tenant_id +
    client_id + client_secret, validates UUID/domain, obscures the secret.
- **Route** (`ms_graph_api.routing.yml`): `ms_graph_api.settings` at
  `/admin/config/services/ms-graph-api`, form `GraphApiSettingsForm`, requires permission
  **`administer site configuration`**. Menu link under *Web services*.
- **Config**: `ms_graph_api.settings` (single key `default_key_id`, schema in
  `config/schema/ms_graph_api.schema.yml`); install ships a default Key entity
  `key.key.ms_graph_api_default_key` and points `default_key_id` at it.
- **No** hooks, `.install`, `.module`, permissions file, Drush commands, entities, or fields.

## Auth model (from `GraphApiGraphFactory`)

OAuth 2.0 **client-credentials** grant (server-to-server; no user redirect, no callback route).
`obtainAccessToken()` POSTs `client_id` / `client_secret` / `resource` / `grant_type` to
`https://login.microsoftonline.com/{tenant_id}/oauth2/token?api-version=1.0`, reads
`access_token` from the JSON, and sets it on a new `Graph`. Credentials come only from a
`ms_graph_api` Key; missing/invalid values throw `ConfigValueException`.
