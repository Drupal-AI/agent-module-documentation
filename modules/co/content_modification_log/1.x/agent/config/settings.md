<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form + config object

## Install / enable

`drush en content_modification_log -y`. No dependencies (core only). Enabling runs
`content_modification_log_schema()`, creating the `content_modification_log` table. Logging then
starts automatically for `node` and `file` saves/deletes — no configuration required.

## Settings form — `ContentModificationLogSettingsForm`

`src/Form/ContentModificationLogSettingsForm.php` (`ConfigFormBase`, form id
`content_modification_log_admin_settings`), route `content_modification_log.settings` at
`/admin/config/content/content-modification-log` (perm `administer content_modification_log
settings`). Also linked from the module `configure:` key in the info.yml.

Three fieldsets:

- **Clear content modification log** — a "Clear Log Data" `#type => link` to route
  `content_modification_log.delete` (the confirm form that truncates the table).
- **Content Modification Log Settings**
  - `content_modification_log_rowcount` (number, 1–100, required, default from
    `$config->get('acl_rowcount') ?: 50`) → saved to config key **`acl_rowcount`**.
  - `content_modification_log_show_tab` (checkbox, default from `$config->get('show_tab') ?: false`)
    → saved to config key **`show_tab`**. Controls the "Modifications" local task on
    `/admin/content` (see `hook_local_tasks_alter` + `ContentModificationLogContentLink::isEnabled`,
    which require the value to be exactly `1`).
- **CSV File Settings**
  - `content_modification_log_csv_filename` (textfield, required, default from
    `$config->get('acl_csv_filename') ?: 'content-log.csv'`) → saved to config key
    **`acl_csv_filename`**. A `token_tree_link` (`user` token types) is shown for building the name.

`submitForm()` writes `acl_rowcount`, `acl_csv_filename`, `show_tab` into
`content_modification_log.settings` and invalidates the `config:content_modification_log.settings`
cache tag.

## Config object: `content_modification_log.settings`

Keys actually written by the form: `acl_rowcount`, `acl_csv_filename`, `show_tab`.

The module ships **no `config/install` default and no `config/schema`** — the config object is created
lazily on first save, and there is no typed-config schema (`provides_config_schema` is false).

### Key-name mismatch (important)

The **controller reads different keys than the form writes**:

- `ContentModificationLogExportController::content()` reads `cml_rowcount` (rows per page) — the form
  saves `acl_rowcount`. → rows-per-page falls through to the hardcoded default **50**.
- `ContentModificationLogExportController::export_csv()` reads `cml_csv_filename` — the form saves
  `acl_csv_filename`. → the export filename falls through to the hardcoded default
  **`content-log.csv`**.

So the "Rows per page" and "CSV Filename" settings are inert in this release; only `show_tab` (read
consistently as `show_tab`) actually takes effect. To change those two behaviours in practice you
would set the `cml_*` keys directly (e.g. via `drush config:set`) rather than the form.
