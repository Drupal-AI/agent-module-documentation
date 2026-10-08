<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Source UI — agent index

Admin UI to **upload a CSV/XML/JSON file and run an existing file-based migration** against it,
on top of Migrate + `migrate_tools`. It defines no migrations itself. Two routes, two
permissions, one config key.

- **Routes, the `file_temp_directory` setting, `migrate_source_ui.settings` config** →
  [configure/settings.md](configure/settings.md)
- **The two permissions and what each gates** →
  [permissions/permissions.md](permissions/permissions.md)
- **How the run form works: which migrations are listed, extensions, path override, execution** →
  [api/how-it-works.md](api/how-it-works.md)

Key facts:
- Run form: `/admin/content/migrate_source_ui` (`migrate_source_ui.form`, perm `access migrate
  source ui`) — this is also the `configure` route. Settings: `/admin/config/content/migrate_source_ui`
  (`migrate_source_ui.settings`, perm `administer migrate source ui`).
- Only config: `migrate_source_ui.settings:file_temp_directory` (where uploads are saved; unset
  = Drupal temporary scheme).
- Lists only migrations whose source reads an uploaded file: CSV (`migrate_source_csv`),
  Url/JSON+XML (`migrate_plus`), spreadsheet (`migrate_spreadsheet`). Allowed extensions:
  `csv`, `json`, `xml`.
- No plugins, no Drush, no hooks of its own.
