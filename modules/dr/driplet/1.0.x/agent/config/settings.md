<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: settings, routes, permission, menu

## Install & enable

```bash
composer require drupal/driplet   # pulls make0x20/driplet ^0.1
drush en driplet -y
```

No Drupal module dependencies for the base module. It does **nothing useful** until a running
Driplet Go microservice exists and the settings below point at it (see the project `Readme.md`).

## Permission

`driplet.permissions.yml` declares a single permission **`administer driplet`**
(`restrict access: TRUE`) — "Allow access to configure Driplet notification system." It only gates
the settings form.

## Routes (`driplet.routing.yml`)

| Route | Path | Handler | Access |
|---|---|---|---|
| `driplet.settings` | `/admin/config/services/driplet` | `DripletSettingsForm` | `_permission: administer driplet` |
| `driplet.jwt` | `/api/driplet/jwt` | `DripletController::generateJwt` | `_access: 'TRUE'`, `no_cache: TRUE` |

`driplet.links.menu.yml` places the settings form under *Configuration → Web services*
(`parent: system.admin_config_services`, weight -1). The JWT route is covered in
[../api/messaging.md](../api/messaging.md).

## Settings form (`DripletSettingsForm`)

`src/Form/DripletSettingsForm.php` extends `ConfigFormBase`, edits config **`driplet.settings`**,
form id `driplet_settings_form`. Fields (all text/checkbox):

- **API Host** `driplet_api_host` (required) — `host:port` for REST calls Drupal → microservice.
- **Use SSL for API** `driplet_api_use_ssl` (checkbox) — usually off for internal traffic.
- **WebSocket Host** `driplet_websocket_host` (required) — `host:port` browsers → microservice.
- **Use SSL for WebSocket** `driplet_websocket_use_ssl` (checkbox) — usually on for browsers.
- **Service Name** `driplet_name` (required) — the service segment used in endpoints (e.g. `default`).
- **Driplet JWT Secret** `driplet_jwt_secret` (required) — key for JWT auth; the field description
  suggests generating with `openssl rand -hex 32`.
- **Driplet API Secret** `driplet_api_secret` (required) — key for message signing; same generation
  hint.

`submitForm()` saves those raw values **and derives two endpoints** from them:

- `driplet_api_endpoint` = `sprintf('%s://%s/api/%s/message', http|https, api_host, name)`
- `driplet_websocket_endpoint` = `sprintf('%s://%s/ws/%s', ws|wss, websocket_host, name)`

So `driplet_api_endpoint` / `driplet_websocket_endpoint` are computed on save, not entered directly.

## Config object `driplet.settings`

Install defaults (`config/install/driplet.settings.yml`) — DDEV-oriented placeholders:

```yaml
driplet_api_host: 'driplet:4719'
driplet_websocket_host: 'driplet.drupal-test.ddev.site:4719'
driplet_api_use_ssl: false
driplet_websocket_use_ssl: true
driplet_name: 'default'
driplet_jwt_secret: 'change-this-jwt-secret'
driplet_api_secret: 'change-this-api-secret'
driplet_api_endpoint: 'http://driplet:4719/api/default/message'
driplet_websocket_endpoint: 'wss://driplet.drupal-test.ddev.site:4719/ws/default'
```

Replace every value for a real deployment (both secrets and both hosts), then save the form so the
endpoints are recomputed. **No `config/schema/` is shipped**, so `driplet.settings` has no config
schema (`provides_config_schema` is false); strict config tooling may warn.

## Front-end attachment (`driplet.module`)

`driplet_page_attachments()` runs on every page: **if** `driplet_websocket_host` is set, it attaches
the `driplet/driplet` library and pushes `drupalSettings.driplet` = `{ ws_endpoint:
driplet_websocket_endpoint, service_name: driplet_name }`. Submodule JS reads `ws_endpoint` from
there. If the host is empty, nothing is attached.
