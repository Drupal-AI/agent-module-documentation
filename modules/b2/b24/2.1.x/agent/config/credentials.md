<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# b24 — install, OAuth setup & configuration

## Install / enable

`composer require drupal/b24` then enable `b24` (pulls in `token`). Enable the submodules you need
separately. The configure link is `b24.credentials`.

## Bitrix24 side (prerequisite)

You must create a **local application** on the Bitrix24 portal (menu link built in
`CredentialsForm` to `https://<site>/devops/section/standard/`), scope `crm`, with **redirect_uri =
`<drupal-scheme-and-host>/b24/oauth`**. That yields the `client_id` and `client_secret` entered
below. Note: since April 2025 the Bitrix24 REST API is a paid option.

## Config forms & routes (all require `administer b24 configuration`)

| Route | Path | Form/controller | Writes |
|-------|------|-----------------|--------|
| `b24.root_config_page` | `/admin/config/b24` | SystemController menu block | — |
| `b24.credentials` | `/admin/config/b24/credentials` | `Form\CredentialsForm` | `b24.settings` |
| `b24.settings` | `/admin/config/b24/settings` | `Form\DefaultSettingsForm` | `b24.default_settings` |
| `b24.auth` | `/b24/oauth` | `Controller\Auth::build` | `state` tokens |

Menu links in `b24.links.menu.yml` place these under *Configuration → Bitrix24*.

## `CredentialsForm` (`src/Form/CredentialsForm.php`)

Progressive form editing config object **`b24.settings`**:
- `site` — Bitrix24 domain name (required). Update hook `b24_update_20001` appends `.bitrix24.ru`
  to a legacy bare value.
- Once `site` is set, an *Application data* fieldset exposes `client_id` and `client_secret`.
- Once `client_secret` is set, a disabled *Access token* field shows `state('b24_access_token')`
  and a **"Get access token"** link to the authorize URI produced by
  `RestManager::getAuthorizeUri()`.

`submitForm()` saves `site`, `client_id`, `client_secret` (legacy `login`/`password` handled only if
posted). `getFormId` = `b24_settings`.

## OAuth2 flow

1. `RestManager::getAuthorizeUri()` builds
   `https://<site>/oauth/authorize?client_id=…&response_type=code&redirect_uri=<host>/b24/oauth&state=<token>`,
   generating an anti-CSRF **state token** (`Crypt::randomBytesBase64(32)`) stored in
   `state('b24_oauth_state')`.
2. Bitrix24 redirects back to **`b24.auth`** (`/b24/oauth`, permission-gated). `Auth::build()`
   validates the returned `state` against the stored one with `hash_equals()` and deletes it
   (single use), then exchanges the `code` at `https://<site>/oauth/token/` for
   `access_token`/`refresh_token`, saving both to `state`.
3. `hook_cron()` (`b24.module`) calls `RestManager::refreshAccessToken()` (refreshes only when the
   token is within 30 min of `state('b24_token_expires')`) and `setCrmMode()`.

## `DefaultSettingsForm` (`src/Form/DefaultSettingsForm.php`)

Edits config object **`b24.default_settings`**:
- `crm_mode` — radios (`CRM_MODE_CLASSIC=1`/`CRM_MODE_SIMPLE=2`), **disabled** (mirrors the portal
  setting; install default `crm_mode: 1`).
- `assignee` — a Bitrix24 employee (options fetched live via `RestManager::get('user.get', …)`), or
  `custom` to enter `user_id` manually (validated as a positive integer). Used by
  `RestManager::addEntity()` to set `ASSIGNED_BY_ID` on new records.

## Config schema (`config/schema/b24.schema.yml`)

- `b24.settings`: `site`, `client_id`, `client_secret` (strings).
- `b24.default_settings`: `assignee` (string), `user_id` (int), `crm_mode` (int).

## Storage table (`b24.install`)

`hook_schema()` defines `b24_reference` (`id`, `entity_id`, `bundle`, `ext_id`, `ext_type`, `hash`),
indexed on `bundle` and `ext_type` — the Drupal↔Bitrix24 mapping used by all submodules.
