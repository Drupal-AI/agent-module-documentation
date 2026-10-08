<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — content_insights_report_group.settings

Config object: **`content_insights_report_group.settings`** (separate from the parent module's object; configuring one does not affect the other). Schema: `config/schema/content_insights_report_group.schema.yml`. Install defaults: `config/install/content_insights_report_group.settings.yml`. Edited via `Form\ContentInsightsReportGroupConfigForm` (form id `content_insights_report_settings_group_form`) at `/admin/config/content/content_insights_report_group/report-settings` (route `content_insights_report_group.report_settings`, permission `administer content_insights_report_group settings`, menu link under `system.admin_group`).

## Keys (identical shape to the parent module)

| Key | Type | Default | Effect |
|-----|------|---------|--------|
| `show_summary` | boolean | TRUE | Show the group Summary section (per-type percentages). |
| `show_insights_report` | boolean | TRUE | Show the monthly created/updated/revision grid. |
| `show_workflow_moderation_state_report` | boolean | FALSE | Show moderation-state summary (needs `content_moderation`). |
| `show_created_by_and_date` | boolean | TRUE | Show a "created by / date" run stamp. |
| `percentage_total` | string | `all_nodes` | Percentage basis: `all_nodes` / `published_nodes` / `unpublished_nodes` (schema `AllowedValues` lists `all_nodes`/`published_nodes`; controller also handles `unpublished_nodes`). |
| `number_of_months` | integer (min 1) | 6 | Months of activity covered. |
| `sort_by_field` | string | `total_percentage` | Summary sort: `content_type` / `content_type_machine` / `total_percentage`. |
| `sort_by_direction` | string | `desc` | `asc` / `desc`. |
| `show_print` | boolean | TRUE | Show the print icon. |
| `show_empty_results` | boolean | TRUE | Omit empty sections when FALSE. |

## Notes

- Same `$config->get(x) ?: <default>` display-default quirk as the parent (a stored FALSE re-shows the coded default in the form; persisted values are still read verbatim by the controllers).
- Consumed in `ContentInsightsReportGroupController::contentReport()` and its `getNodeCounts()` / `getInsightsCounts()` helpers.
- These settings only shape rendering/aggregation; the **group scoping** (which nodes are counted) is enforced by the SQL joins, not by config — see `../api/queries.md`.
