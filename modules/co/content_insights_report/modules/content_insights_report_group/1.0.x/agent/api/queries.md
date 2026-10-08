<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group report — scoping, routes, access and queries

The submodule mirrors the parent's two report pages but scopes every query to one Group. Source: `src/Controller/ContentInsightsReportGroupController.php`, `src/Controller/ContentGroupController.php`, `src/Form/ContentReportGroupFilterForm.php`.

## Routes (`content_insights_report_group.routing.yml`)

All report routes carry a `{group}` slug typed `entity:group` and are guarded by one custom access callback (not a bare permission):

- `content_insights_report_group.report` -> `ContentInsightsReportGroupController::contentReport`. `_admin_route: TRUE`. Theme `content_insights_report_group`.
- `content_insights_report_group.content_display` -> `ContentGroupController::contentReport`. Theme `content_display_group`.
- `content_insights_report_group.update_filters` -> `ContentInsightsReportGroupController::updateFilters` — stores the whitelisted query params plus `group_id` in the caller's own `tempstore.private` collection `content_insights_report_group`, then redirects to the group listing.
- `content_insights_report_group.report_settings` -> `ContentInsightsReportGroupConfigForm`. Gated by `administer content_insights_report_group settings` (this is the one route using a plain `_permission`).

A `Report` local task (`content_insights_report_group.links.task.yml`) is attached to `entity.group.canonical`.

## Access — `ContentInsightsReportGroupController::access($group, $account)`

Returns `AccessResult`:

- `admin_access` = `allowedIfHasPermission($account, 'administer content_insights_report_group settings')` (adds `$group` as cache dependency), **OR**
- `group_member_access` = `allowedIf(method_exists($group,'getMember') && (bool) $group->getMember($account))` **andIf** `allowedIfHasPermission($account, 'view content_insights_report_group report')`, cached per user with `$group` as dependency.

So a viewer must be a member of that specific group and hold the view permission, unless they are a module administrator. This is the primary access boundary; `update_filters` and both report controllers all reference the same callback.

## Group scoping (the added dimension)

Every counting/listing query the parent runs is repeated here with an extra join that limits rows to the group's own content:

```
$query->innerJoin('group_relationship_field_data', 'grfd', "nfd.nid = grfd.entity_id");
$query->condition('grfd.gid', $group_id);
$query->condition('grfd.plugin_id', "group_node:%", 'LIKE');
```

`$group_id` comes from the route's resolved `entity:group` parameter (`ContentInsightsReportGroupController::contentReport()` / `ContentGroupController::contentReport()` read it from `RouteMatchInterface`). It is passed as a placeholder argument, and the `group_node:%` LIKE is a static literal — no user string reaches the SQL. This join is applied in `getNodeCounts()`, `getInsightsCounts()`, `getNodeSummaryPerModerationState()` and the `ContentGroupController` listing query.

## Node access + listing hardening (same as parent)

- Both controllers carry the identical private `applyNodeAccess()` helper: early-out on `bypass node access`, else apply `node_access_grants('view', ...)` (empty grants -> no rows), else inner-join `node_access` with `grant_view >= 1` and the realm/gid OR-group.
- `ContentGroupController::contentReport()` hard-caps `$limit = 50`, whitelists `sort` and `status`, validates every date with `validateDate()` (exact `Y-m-d` round-trip), passes all filter values as placeholders, and **re-checks `$node->access('view')` per row** after load.
- Per-row edit link is gated on the **group** permission `update any group_node:<bundle> entity` via `$group->hasPermission(...)`, not a global permission.
- `ContentReportGroupFilterForm` (Form API) validates dates are not in the future and persists filters to the group tempstore; Reset clears them.

## Hooks & theming

`Hook\ContentInsightsReportGroupHooks` provides `hook_help` and `hook_theme` (themes `content_insights_report_group`, `content_display_group` with a `group`/`group_data` variable added) as an autowired service, with `#[LegacyHook]` shims in `content_insights_report_group.module`. Templates: `templates/content-insights-report-group.html.twig`, `templates/content-display-group.html.twig` (Twig auto-escaped; no `|raw`).
