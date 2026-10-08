<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dblog JSON Viewer (dblog_json_viewer) — agent index

A **client-side** enhancement of Drupal core's dblog **event** page. On
`/admin/reports/dblog/event/*` it detects JSON in the log message cell and replaces the raw text
with an interactive, searchable, collapsible viewer (bundled json-view library). Package
`Administration`. Depends only on core **`dblog`**. Core requirement `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.3. No entities, services, plugins, Drush, or module-defined
permissions.

- **The settings form, config object, schema, route and permission** →
  [config/settings.md](config/settings.md)
- **How it attaches, detects JSON, and renders (the JS pipeline + library)** →
  [integration/viewer.md](integration/viewer.md)

## What it actually is (from source)

- **`dblog_json_viewer.module`** — two hooks only:
  - `hook_help` (help.page text).
  - `hook_page_attachments()` attaches the `dblog_json_viewer/dblog-json-viewer` library **and**
    a `drupalSettings.dblogJsonViewer` payload (button texts + settings), but **only** when the
    current route is `dblog.event` **and** the user has `access site reports` **or**
    `administer site configuration`.
- **`dblog_json_viewer.libraries.yml`** — one library `dblog-json-viewer`: CSS
  `css/dblog-json-viewer.css`, JS `js/jsonview.js` (bundled UMD build of pgrabovets/json-view) and
  `js/dblog-json-viewer.js`; depends on `core/drupal`. (The settings form also references a
  `dblog_json_viewer/admin` library, which is **not defined** in the libraries file.)
- **`dblog_json_viewer.routing.yml`** — one route `dblog_json_viewer.admin_settings`
  (`/admin/config/development/dblog-json-viewer`), a `_form` for `DblogJsonViewerSettingsForm`,
  gated by `_permission: 'administer site configuration'`.
- **`src/Form/DblogJsonViewerSettingsForm.php`** — `ConfigFormBase` editing
  `dblog_json_viewer.settings`.
- **`dblog_json_viewer.links.menu.yml`** — an admin-menu link under
  `system.admin_config_development`.
- **`dblog_json_viewer.install`** — `hook_install` (status messages only) and `hook_uninstall`
  (deletes `dblog_json_viewer.settings`).
- **`config/install/dblog_json_viewer.settings.yml`** + **`config/schema/…schema.yml`** — the one
  config object.

## Key facts

- Everything user-facing happens in the **browser**; the PHP side only gates and configures.
- No module-defined permissions — it reuses core `access site reports` / `administer site
  configuration`. The settings route itself needs `administer site configuration`.
- No outbound HTTP, no database writes of its own, no queue/cron, no plugins.
