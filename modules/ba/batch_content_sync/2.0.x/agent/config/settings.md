<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings

## Install / enable
`drush en batch_content_sync -y` (or via the UI). Pulls in core `rest`, `serialization`, `node`, `file`.
`hook_schema()` in `batch_content_sync.install` creates the `batch_content_sync_log` table (columns:
`id`, `json_entity` longblob, `title`, `language`, `type` sent|received, `created`).

## Config object: `batch_content_sync.settings`
Default values ship in `config/install/batch_content_sync.settings.yml`. **No `config/schema/` is provided.**

| Key | Type | Meaning | Default (shipped) |
|-----|------|---------|-------------------|
| `qa_url` | string | Full receive URL of the QA target | `https://qa.testenvironment.com/api/push-entity-qa` |
| `stage_url` | string | Full receive URL of the Stage target | `https://stage.testenvironment.com/api/push-entity-stage` |
| `prod_url` | string | Full receive URL of the Prod target | `https://testenvironment.com/api/push-entity-prod` |
| `existing_content_behavior` | string | `override` (update entity matched by UUID) or `clone` (create a new "(Clone) …" copy) | `override` |
| `access_token` | string | Shared secret sent as `X-Access-Token` header / `token` field on push, and compared on receive | `CHANGE_THIS_TO_A_UNIQUE_TOKEN` |

The env URLs are read in `SyncService::pushToRemote()` as `<env>_url` (`$env` ∈ qa|stage|prod). The token is
sent by the pusher and validated by `ReceiverController::getConfiguredToken()`. Both source and target sites
must run this module and share the same `access_token`; each side must change the shipped default to its own
unique value.

## Settings form: `Form\SettingsForm`
- Route `batch_content_sync.settings` → `/admin/config/services/batch-content-sync`, requirement
  `_permission: 'administer site configuration'`. Extends `ConfigFormBase` (CSRF-protected).
- Fields: QA/Stage/Prod URL textfields, an `existing_content_behavior` radios (override|clone), and an
  Access Token textfield.
- **Generate Token** button → AJAX `generateTokenAjax()` sets the token field to `bin2hex(random_bytes(16))`
  (32 hex chars). It only fills the form element; you still submit the form to persist it.
- `submitForm()` writes all five keys back to `batch_content_sync.settings`.

## Menu links (`batch_content_sync.links.menu.yml`)
Parent "Batch Content Sync" at `/admin/config/batch_content_sync` (route `batch_content_sync.main_menu`,
system admin-menu block), with child links to the settings form and the sync log — all gated by
`administer site configuration`.

## Operating notes
- After configuring, editors push from `/admin/content` using the node actions (see `../api/push-and-receive.md`).
- The receive endpoints (`/api/push-entity-*`) are always registered when the module is enabled; the token is
  the only gate. Keep the token secret and unique per site, and prefer HTTPS target URLs.
