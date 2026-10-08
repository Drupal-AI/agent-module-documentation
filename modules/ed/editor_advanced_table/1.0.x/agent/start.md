<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editor Advanced Table (editor_advanced_table) — agent index

A single **CKEditor 5 plugin** that lets editors set the `id`, `dir` (language direction), and
`class` HTML attributes on tables — a re-creation of CKEditor 4's "Advanced" table tab. Package
**CKEditor 5**. Depends only on core **`ckeditor5`** (and, as a plugin condition, the core
`ckeditor5_table` plugin). Core `^10 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later. Version-dir
1.0.x (installed release 1.0.2).

- **The CKEditor 5 plugin: registration, the config form, per-format settings, and how to enable it** →
  [plugins/table_advanced.md](plugins/table_advanced.md)

## What it actually is

- One CKEditor 5 plugin definition `editor_advanced_table_table_advanced` in
  `editor_advanced_table.ckeditor5.yml`: JS plugin `tableAdvanced.TableAdvanced`, added to
  `config.table.contentToolbar` as `tableAdvanced`, declared elements `<table class id dir>`,
  library `editor_advanced_table/tableAdvanced`, and `conditions.plugins: [ckeditor5_table]`.
- One PHP class: `Drupal\editor_advanced_table\Plugin\CKEditor5Plugin\TableAdvanced`
  (`src/Plugin/CKEditor5Plugin/TableAdvanced.php`), extending `CKEditor5PluginDefault` and
  implementing `CKEditor5PluginConfigurableInterface`. It provides the settings form and passes
  `allowId`/`allowLanguageDirection`/`allowClasses` to JS via `getDynamicPluginConfig()`.
- Config **schema** only (`config/schema/editor_advanced_table.schema.yml`): keys `allow_id`,
  `allow_language_direction`, `allow_classes` (all boolean). No `config/install`, no permissions,
  no routes, no services, no `.module`/`.install`, no Drush.
- Client-side CKEditor 5 code under `js/ckeditor5_plugins/tableAdvanced/` (built to
  `js/build/tableAdvanced.js`): `TableAdvanced` requires `TableAdvancedEditing` (schema/converters +
  `setTableAttributes` command) and `TableAdvancedUI` (toolbar button + balloon `TableAdvancedFormView`).

## Enable it

Add the module, then per text format at `admin/config/content/formats`: the `tableAdvanced` button
lives on the table content toolbar; on the "Advanced table" plugin-settings tab, toggle which of the
three attributes editors may set. Details and the config-export shape are in
[plugins/table_advanced.md](plugins/table_advanced.md).
