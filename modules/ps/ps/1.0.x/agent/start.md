# Paragraphs Stats (`ps`) — agent index

Reports on where Paragraph types are used across node / block_content / paragraph parents, with
drill-down and CSV export. Under `/admin/reports/paragraphs-stats-report`. Requires `paragraphs`.
No config UI (`configure` null), no config schema, no Drush.

- **Routes, permissions, the report/drill-down/export flow, the metrics table** →
  [permissions/permissions.md](permissions/permissions.md)
- **The `ps.service` (`ParagraphsStats`) methods for programmatic use** → [api/service.md](api/service.md)

Key facts:
- Permissions (both `restrict access: true`): `access paragraphs stats report` (all read routes),
  `administer paragraphs stats configuration` (the "Update the data structure" action).
- "Update structure" (`ParagraphsStats::updateStructure()`) fills the `paragraphs_stats_inuse` table by
  scanning fields with `target_type == paragraph`; the report SQL then counts real usage in
  `paragraphs_item_field_data`.
- Everything lives in `src/ParagraphsStats.php` (service `ps.service`); `src/Controller/PsController.php`
  is a thin dispatcher.
