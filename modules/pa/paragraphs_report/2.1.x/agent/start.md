<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Report — agent index

Catalogs which Paragraph types are used on which nodes, for selected content types; renders a filterable
table + CSV export. Requires `paragraphs` + `path_alias`. No plugin types.

- **Settings config, report/export routes, `configure` route** → [configure/settings.md](configure/settings.md)
- **The `paragraphs_report:update` (pru) Drush command** → [drush/commands.md](drush/commands.md)
- **The `paragraphs_report.report` service & where report data is stored** → [api/service.md](api/service.md)
- **The three permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts: settings in `paragraphs_report.settings` (`content_types`, `hide_paras`,
`import_rows_per_batch` default 10, `watch_content`). Report data lives in the **key-value** collection
`paragraph_report.report_data` (key `data`), NOT in config. Report page `/admin/reports/paragraphs-report`
(route `paragraphs_report.report`, also the `configure` route); settings tab `.../settings`.
