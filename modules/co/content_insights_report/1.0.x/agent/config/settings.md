<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — content_insights_report.settings

Config object: **`content_insights_report.settings`**. Schema: `config/schema/content_insights_report.schema.yml`. Install defaults: `config/install/content_insights_report.settings.yml`. Edited via `Form\ContentInsightsReportConfigForm` (form id `content_insights_report_settings_form`) at `/admin/config/content/content_insights_report/report-settings` (route `content_insights_report.report_settings`, permission `administer content_insights_report settings`).

## Keys (type — install default — effect)

| Key | Type | Default | Effect |
|-----|------|---------|--------|
| `show_summary` | boolean | TRUE | Show the Content Insights **Summary** section (per-type percentages). |
| `show_insights_report` | boolean | TRUE | Show the **Insights** section (monthly created/updated/revision grid). |
| `show_workflow_moderation_state_report` | boolean | FALSE | Show the **moderation-state** summary (only rendered if `content_moderation` is enabled). |
| `show_created_by_and_date` | boolean | TRUE | Show a "created by <user> on <date>" stamp of when the report was run. |
| `percentage_total` | string | `all_nodes` | Denominator for percentages. Values: `all_nodes`, `published_nodes`, `unpublished_nodes`. (Schema `AllowedValues` lists only `all_nodes`/`published_nodes`, but the form and `getNodeCounts()` also handle `unpublished_nodes`.) |
| `number_of_months` | integer (min 1) | 6 | How many months back the Insights grid covers. |
| `sort_by_field` | string | `total_percentage` | Summary sort column: `content_type` (label), `content_type_machine` (id), `total_percentage`. |
| `sort_by_direction` | string | `desc` | `asc` or `desc`. |
| `show_print` | boolean | TRUE | Show the print icon (client-side `window.print()` of a section). |
| `show_empty_results` | boolean | TRUE | When FALSE, sections with no data are omitted from the render. |

## Notes

- Form `#default_value`s use `$config->get(x) ?: <default>`, so a stored **FALSE**/0 falls back to the coded default when the form rebuilds (e.g. `show_summary` re-defaults to TRUE). Persisted values are still read verbatim by the controllers; this only affects the form's displayed default.
- `submitForm()` writes all ten keys back to `content_insights_report.settings`.
- Settings are consumed in `ContentInsightsReportController::contentReport()` (summary render flags, months, percentage basis, sort) and by the query helpers `getNodeCounts()` / `getInsightsCounts()`.
- The Group submodule keeps a **separate** object `content_insights_report_group.settings` with the same shape — configuring one does not affect the other.
