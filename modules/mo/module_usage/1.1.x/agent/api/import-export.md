<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import / export data model

Tables (constants in `QueryService`):
- `module_usage` (PK `machine_name`) — name, package, description, version, status, text_format, timestamps.
- `module_usage_activity` (PK `id`) — machine_name, activity_date, current_version, status, event_description (e.g. `Installed`, `Version changed ...`).
- `module_usage_urls` (PK `id`) — machine_name, url, url_description, text_format.
- `module_usage_notes` (PK `id`) — machine_name, note_title, note_text, text_format.

Web import: `module_usage.import` → `/admin/module_usage/import` (ImportForm) accepts a `managed_file` upload to `private://import_files/` restricted to `json`/`txt`, then `Json::decode()`s it and calls `QueryService::doImport()`. Export: `module_usage.export` → `/admin/module_usage/export` streams `module_usage.json`.

All reads/writes use the Drupal DB API with bound parameters (no string concatenation).