<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DataTables — agent index

Integrates the jQuery **DataTables** plugin into **Views** as a table style plugin. Build a view
with fields, pick **"DataTables"** as the display format, get client-side search, sort and
pagination. Depends on `views`.

- **The `datatables` Views style plugin: how to apply it and every option** →
  [plugins/views-style.md](plugins/views-style.md)
- **Library install (local vs CDN) + the `use_cdn` setting + requirements check** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Views style plugin id **`datatables`** (class `Plugin\views\style\DataTables extends Table`,
  theme `views_view_datatables`).
- Only site setting: **`datatables.settings` → `use_cdn`** (bool). Form at
  `/admin/config/services/datatables` (route `datatables.settings`, permission
  **`administer site configuration`**).
- Per-view options live in the view config under
  `display.*.display_options.style.type: datatables` (+ `style.options`), schema
  `views.style.datatables`.
- Needs the DataTables JS **library** in `/libraries` (or CDN); `hook_requirements()` reports
  if missing.
- Provides config schema; no permissions of its own, no Drush, no plugin types defined.
