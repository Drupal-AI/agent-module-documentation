<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conductor — install, settings & permissions

## Install / enable

```
composer require drupal/conductor
drush en conductor -y
```

Depends on `canvas` and `key`. A git clone needs the app built: `npm ci && npm run build` in the
module dir (the released package ships `app/dist/` prebuilt).

## Credentials (Key entity)

Create a Key (`/admin/config/system/keys/add`, type *Authentication (Multivalue)*) whose value is JSON.
Either scheme works; `api_token` wins when both are present:

```json
{ "api_token": "{bearer_token}" }
```
```json
{ "api_key": "{api_key}", "shared_secret": "{shared_secret}" }
```

Only the key's id lands in config (`conductor.settings:key_id`); the secret stays in the Key provider.
`ConductorConfigForm::validateCredentials()` re-validates the selected key on save: it must exist, be
non-empty, be valid JSON, and contain either `api_token` or both `api_key` and `shared_secret`.

## Settings form — ConductorConfigForm

Route `conductor.config` `/admin/config/services/conductor`, `_form` `ConductorConfigForm`
(extends `ConfigFormBase`), permission **`administer conductor`** (`restrict access: TRUE`). Menu link
`conductor.config_menu` under *Configuration → Services*. Fields:

- **API Credentials Key** (`key_id`) — a `key_select` element.
- **Enable automatic orphaned draft cleanup** (`enable_draft_cleanup`) — checkbox.
- **Node Form Integration → Content types** (`node_types`) — checkboxes of every `node_type`; only
  shown when node types exist. Selected bundles embed the Writing Assistant on their node edit form.

On submit it saves `conductor.settings`, invalidates the cache tag
`conductor_api:account_id` (so the account id re-resolves), then calls `connectionIsSuccessful()` →
`ConductorHttpApiClient::getAccountId()` and shows a success/error message ("Successfully established
connection to Conductor API." or a credentials error).

![Writing Assistant settings form](../../../../../../../screenshots/conductor/2.1.x/settings-form.png)

## Config object — conductor.settings

`config/install/conductor.settings.yml` defaults and `config/schema/conductor.schema.yml` types:

| key | type | default | meaning |
|-----|------|---------|---------|
| `key_id` | string | `~` | id of the Key holding Conductor credentials |
| `max_drafts` | integer | `15` | per-year draft cap (`DraftRepository::getMaxDrafts`, falls back to `DEFAULT_MAX_DRAFT = 15`) |
| `delete_unlinked_drafts_after` | integer | `21600` | min age (seconds, 6 h) before cron cleanup deletes an orphaned draft |
| `enable_draft_cleanup` | boolean | `false` | master switch for the cron cleanup (see endpoints.md) |
| `node_types` | sequence of string | `{}` | content-type ids that embed the Writing Assistant on their node form |

`max_drafts` and `delete_unlinked_drafts_after` are not exposed on the settings form — set them via
config import / `drush cset conductor.settings …` if you need non-defaults.

## Install hooks — conductor.install

- `hook_schema()` creates table `conductor_draft_map` (see [../api/endpoints.md](../api/endpoints.md)).
- `conductor_update_10001()` sets `enable_draft_cleanup = FALSE` on existing sites (safety default).
- `conductor_update_10002()` adds the `score` column to `conductor_draft_map`.
- `hook_uninstall()` drops the table.

## Permissions — conductor.permissions.yml

- **`use conductor`** — "Use Conductor". *Not* `restrict access`. Gates the proxy, the draft CRUD +
  score API, the settings API, the node-extension host, and the drafts dashboard. Intended for content
  editors. Grant it deliberately: it is the only gate on those routes.
- **`administer conductor`** — "Conductor SEO", `restrict access: TRUE`. Gates only the settings form.
