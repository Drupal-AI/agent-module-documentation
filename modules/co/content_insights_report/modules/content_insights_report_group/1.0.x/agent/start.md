<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Insights Report Group (content_insights_report_group) — agent index

Submodule of **content_insights_report**. Reproduces the parent's summary/activity/moderation
aggregates and node listing, but **scoped to a single Group** by joining `group_relationship_field_data`
on `gid` + `plugin_id LIKE 'group_node:%'`. Reached from a per-group **Report** tab.

- **Version dir:** 1.0.x (installed 1.0.11). `core_version_requirement: ^10.1 || ^11 || ^12`.
- **Dependencies:** `drupal:node`, `drupal:group`, `group:gnode` (composer requires `drupal/group ^2.3`).
  The base `content_insights_report` module must also be present. `content_moderation` optional.
- **Parent docs:** `../../../1.0.x/agent/start.md`.

## Provides

- **Routes** (`content_insights_report_group.routing.yml`) — all report routes take `{group}` (`entity:group`) and share one custom access check:
  - `content_insights_report_group.report_settings` — settings form, `/admin/config/content/content_insights_report_group/report-settings`, perm `administer content_insights_report_group settings`.
  - `content_insights_report_group.report` — group summary, `/group/{group}/reports/content-insights-report-group`, `_custom_access: ...Controller\ContentInsightsReportGroupController::access`.
  - `content_insights_report_group.content_display` — group node listing, `/group/{group}/reports/content-insights-report-group/content`, same custom access.
  - `content_insights_report_group.update_filters` — writes filters to the caller's own tempstore + group id, then redirects, same custom access.
- **Permissions:** `administer content_insights_report_group settings`, `view content_insights_report_group report` (both `restrict access`).
- **Custom access** `ContentInsightsReportGroupController::access(EntityInterface $group, AccountInterface $account)`: allow if `administer content_insights_report_group settings`, OR (`$group->getMember($account)` truthy AND `view content_insights_report_group report`). Cache: per-user, group as cache dependency.
- **Config:** `content_insights_report_group.settings` (config_object; schema + install defaults; same ten keys as parent).
- **Controllers:** `ContentInsightsReportGroupController` (summary + access + `updateFilters`), `ContentGroupController` (node listing). **Forms:** `ContentInsightsReportGroupConfigForm` (form id `content_insights_report_settings_group_form`), `ContentReportGroupFilterForm`. **Hooks:** `Hook\ContentInsightsReportGroupHooks` (help, theme).
- **Themes:** `content_insights_report_group`, `content_display_group`. **Menu/task links:** settings under `system.admin_group`; a `Report` local task on `entity.group.canonical`.

## Solution docs

- Configuration + settings keys: `config/settings.md`
- Group scoping, routes, access & queries: `api/queries.md`
