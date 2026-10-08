<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bigin CRM Integration (bigin_crm) — agent index

Registers new Drupal users as **contacts + deals in Zoho Bigin CRM** via the Bigin REST API,
authenticated with **Zoho OAuth2** (authorization-code flow). Package `Bigin`. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1-alpha2. No composer/module deps; uses
core `user`, `config.factory`, `database`, `http_client`, `logger.factory`.

- **OAuth2 connect flow, token storage, REST client, data-center domains** →
  [api/oauth.md](api/oauth.md)
- **Config forms, settings keys, routes, permission, the user-insert sync** →
  [config/settings.md](config/settings.md)

## What it actually is

- **Trigger:** `bigin_crm_user_insert()` (`bigin_crm.module`, `hook_user_insert`) — on every new
  user whose roles intersect the configured `roles`, calls `bigin_crm.contacts_service`->`create()`.
- **Services** (`bigin_crm.services.yml`):
  - `bigin_crm.auth_service` = `BiginAuthService` — OAuth2 token generate/refresh/revoke, token
    store, per-domain account/api URLs.
  - `bigin_crm.client` = `Rest\RestClient` — thin Guzzle wrapper (`@http_client`) that signs
    requests with `Authorization: Zoho-oauthtoken <access_token>` and retries once on HTTP 401.
  - `bigin_crm.contacts_service` = `BiginContactsService` — `create()` a Contact, `get_users()`.
  - `bigin_crm.pipelines_service` = `BiginPipelinesService` — `create_deal()`, `get_layouts()`.
- **Controller** `Controller\BiginController`: `initialize()` (settings page render), `callback()`
  (OAuth redirect target), `revoke()`.
- **Forms** `Form\GetTokenForm` (`bigin_admin_settings`: client id/secret, domain, roles) and
  `Form\SettingsPipelinesForm` (`bigin_settings`: layout/pipeline/stage/owner/deal fields).
- **Config object** `bigin_crm.settings` (install defaults in `config/install/`; **no config
  schema shipped**). **Storage table** `bigin_crm_token` (`bigin_crm.install`, `hook_schema`):
  `access_token`, `refresh_token`, `created`.
- **Permission** (`bigin_crm.permissions.yml`): `administer crm integration` (restrict access).
  All four routes require it. **Theme** `form_settings` (`templates/form-settings.html.twig`).
- **Provides no** entities, fields, plugin types, Drush commands, or config schema.

## Routes (all `_permission: administer crm integration`)

- `bigin_crm.admin_settings_form` — `GET /admin/config/bigin/settings` → `BiginController::initialize`.
- `bigin_crm.callback` — `GET /auth/bigin/callback` → `BiginController::callback` (OAuth redirect_uri).
- `bigin_crm.revoke` — `GET /auth/bigin/revoke_token` → `BiginController::revoke`.
- `bigin_crm.pipelines_settings` — `/admin/config/bigin/settings/pipelines` → `SettingsPipelinesForm`.
