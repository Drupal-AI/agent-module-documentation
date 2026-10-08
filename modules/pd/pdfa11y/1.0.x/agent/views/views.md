# Views integration

`hook_views_data()` (in `pdfa11y.module`) exposes the `pdfa11y_results` base table (base field
`id`) with join + relationship definitions to `media_field_data` (`mid`) and `file_managed`
(`fid`), plus reverse relationships from Media and File back to results.

## Fields available

Standard columns: `id`, `fid`, `mid`, `check_id`, `status`, `severity`, `message`, `uid`, `checked`.
`status` and `severity` filters use `AccessibilityCheckResult::getStatusOptions()` /
`getSeverityOptions()`; `check_id` uses the `pdfa11y_check_id_options()` callback (plugin labels
under "Issues", sentinel labels under "Errors").

Custom field/filter plugins (namespace `Drupal\pdfa11y\Plugin\views\field` / `…\filter`):

| Views field id | Plugin | Renders |
|---|---|---|
| `pdfa11y_check_label` | `field\CheckLabel` | Friendly label for `check_id` (plugin label or sentinel label). |
| `pdfa11y_overall_status` | `field\OverallStatus` + `filter\OverallStatus` | Per-file Pass/Fail/Error rollup (Error if any sentinel row, Fail if any check failed, else Pass). |
| `pdfa11y_pass_count` / `pdfa11y_fail_count` | `field\PassCount` / `FailCount` (`ResultCountBase`) | Passed / failed counts for a grouped result. |
| `pdfa11y_failing_issues_list` | `field\FailingIssuesList` | `<ul>` of failing check + sentinel labels. |
| `pdfa11y_media_report_link` | `field\MediaReportLink` | Link to the media accessibility report. |
| `pdfa11y_file_report_info` | `field\FileReportInfo` | Filename of the checked file. |
| `pdfa11y_file_usage_entity` | `field\FileUsageEntity` | Link to an entity referencing the file. |

Config schema for the custom plugins: `config/schema/pdfa11y.views.schema.yml`.

## Bundled report view

Optional config `views.view.pdfa11y_report` (`config/optional/`, imported by `hook_update_10006`
on existing installs). It has two page displays:

- `media_page` → `admin/reports/pdf-accessibility/media` (linked from the Reports menu via
  `view.pdfa11y_report.media_page`).
- `files_page` → `admin/reports/pdf-accessibility/files`.

These provide the site-wide audit view across all checked PDFs. The per-media tab is the controller
route `pdfa11y.media_report`, not a view.
