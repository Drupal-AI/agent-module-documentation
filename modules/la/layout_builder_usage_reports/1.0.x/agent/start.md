# Layout Builder Usage Reports — agent index

A single read-only admin report of nodes using Layout Builder overrides and the blocks/paragraph
components in them. No plugin types, no Drush, no config schema, no code API.

- **The report page, its query, filters, State-backed filter persistence, and the permission** →
  [configure/usage-report.md](configure/usage-report.md)

Key facts:
- Route `layout_builder_usage_reports.report_form` → `/admin/reports/layout/usage`, form
  `src/Form/ReportForm.php`; permission `access node layout reports` (`restrict access: TRUE`).
- Reads `node__layout_builder__layout` (+ `node_field_data`), `unserialize()` with an
  `allowed_classes` whitelist (Section/SectionComponent + Drupal markup) to enumerate components.
- Classifies plugin IDs: `inline_block:<type>` → block type, `component:<type>` → paragraph type.
- Filters (bundle / provider / language / block type / paragraph type) persist in State
  (`lbur_bundle`, `lbur_provider`, `lbur_language`, `lbur_block_type`, `lbur_paragraph_type`);
  unfiltered queries are capped at 500 rows.
- No security surface: restricted admin permission, DB API queries, and whitelisted unserialize of
  admin-authored layout config.
