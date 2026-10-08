<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Modification Log (content_modification_log) — agent index

An exportable, date-filterable **audit log of content modifications**. Core entity hooks record
every `node`/`file` create/update/delete into a dedicated `content_modification_log` DB table; an
admin report at `/admin/reports/content-modification-log` shows the history with sort, a date-range
filter, and CSV export. Package `Drupal`. **No dependencies** (core only). Core requirement
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed version 1.0.1 (single `1.x` branch).

- **How events are captured + the log table schema** → [api/logging.md](api/logging.md)
- **The admin report, routes, permission, filter form, CSV export, clear-log** → [reports/log-view.md](reports/log-view.md)
- **Settings form + config keys** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- **No entity, no plugin type, no service, no Drush.** One permission, three hook implementations,
  one controller, three forms, one block plugin, one menu-link plugin.
- **Recording** (`content_modification_log.module`): `hook_entity_insert` / `_update` / `_delete`
  each call `_content_modification_log_record_entry($entity, $action)`. That helper **only records
  `node` and `file`** entities (`in_array($entity_type, ['node','file'])`); all other entity types
  are ignored. It inserts one row (uid, timestamp, client_ip, entity_type/id/title/bundle,
  revision_log_message, action) into the `content_modification_log` table (defined by
  `content_modification_log_schema()`).
- **Report** (`ContentModificationLogExportController::content()`): a paged, `TableSort`-sortable
  `#type => table` at `/admin/reports/content-modification-log`, joined to `users_field_data` for
  the author name, with an embedded `ContentModificationLogFilterForm` (start/end date + Export +
  Reset). `::export_csv()` serialises the log to CSV.
- **Settings** (`ContentModificationLogSettingsForm`, `/admin/config/content/content-modification-log`):
  rows-per-page, "show Modifications tab" toggle, CSV filename, and a link to the clear-log confirm
  form (`ContentModificationLogConfirmDeleteForm`, which `truncate()`s the table).
- **Permission** (`content_modification_log.permissions.yml`): a single
  `administer content_modification_log settings` (restrict access: true) gates **all** routes —
  report, settings, export, and delete.
- **Config object**: `content_modification_log.settings` (keys `acl_rowcount`, `acl_csv_filename`,
  `show_tab`). No `config/install` and **no config schema** ships with the module.
- **Extras**: a `content_modification_log` Block plugin (renders an empty themeable container +
  `drupalSettings.json_url`), a `hook_theme` template, and a `ContentModificationLogContentLink`
  menu-link that appears only when `show_tab` is enabled.

## Gotchas

- Only `node` and `file` saves are logged — not users, terms, comments, config, or other entities.
- The controller reads the CSV filename from config key `cml_csv_filename`, but the settings form
  saves it as `acl_csv_filename` (and rows-per-page: controller reads `cml_rowcount`, form saves
  `acl_rowcount`) — so those two admin settings do **not** take effect and the built-in defaults
  (`content-log.csv`, 50 rows) are used.
- `show_tab` is compared with `!== 1` in `hook_local_tasks_alter` and the menu-link plugin, so the
  tab shows only when the value is exactly integer `1`.
- The install hook `content_modification_log_update_10002()` adds the `revision_log_message` column
  to existing installs.
