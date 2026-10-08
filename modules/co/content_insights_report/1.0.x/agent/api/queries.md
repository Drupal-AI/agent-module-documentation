<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Report pages — routes, queries and access model

Two read-only pages, both driven off the node tables via the DB API (no entity query for the aggregates). Source: `src/Controller/ContentInsightsReportController.php`, `src/Controller/ContentController.php`, `src/Form/ContentReportFilterForm.php`.

## Routes & permissions (`content_insights_report.routing.yml`)

- `content_insights_report.report` -> `ContentInsightsReportController::contentReport`. Perm `view content_insights_report report`. Themed as `content_insights_report`.
- `content_insights_report.content_display` (GET, POST) -> `ContentController::contentReport`. Perms (all required): `access content overview, access content, view content_insights_report report`. Themed as `content_display`.
- `content_insights_report.update_filters` -> `ContentInsightsReportController::updateFilters`. Perm `access content`. Reads a fixed whitelist of query params, stores them in the caller's **own** `tempstore.private` collection `content_insights_report` under `content_filters`, then `RedirectResponse` to the listing. Writes only to the current user's session store; the listing it feeds is itself gated by the stronger permission set above.

Menu links: `content_insights_report.report` under Reports (`system.admin_reports`) with `insight_report`/`content_report` children; settings link under Config -> Content.

## Summary page — `ContentInsightsReportController`

`contentReport()` assembles `$report_data` from three private helpers, `usort()`s the per-type rows per `sort_by_field`/`sort_by_direction`, and renders `#theme => 'content_insights_report'` attaching library `content_insights_report/content_insights_report`.

- `getNodeCounts()` — seeds every `node_type` (entity storage) to zero, then one grouped `SELECT type, status, COUNT(DISTINCT nid) FROM node_field_data GROUP BY type, status`, plus a revision count from `node_revision`. Computes `published_percent` per type against the chosen `percentage_total` basis (guards divide-by-zero).
- `getInsightsCounts()` — builds a per-type x month skeleton for `number_of_months`, then three grouped queries over `node_field_data.created`, `node_field_data.changed`, and `node_revision.revision_timestamp`, bucketed with `FROM_UNIXTIME(<col>, '%Y%m')` and bounded by `strtotime()` of the month range.
- `getNodeSummaryPerModerationState()` — only meaningful with `content_moderation`; left-joins a grouped subquery on `content_moderation_state_field_data` and tallies counts per type/status/workflow/state.

## Node listing — `ContentController::contentReport`

Reads stored filters from tempstore, hard-caps `$limit = 50`, and builds a `PagerSelectExtender` query on `node_field_data` (optional left-joins for moderation state and a `node_revision` count subquery). For each returned row it **loads the node and skips it unless `$node->access('view', $currentUser)`** before formatting title link, type, status, moderation label, created/changed (via `date.formatter`), revision count, and an edit link gated by `edit any <bundle> content`. Attaches library `content_insights_report/content_display` and renders `#theme => 'content_display'` with the `ContentReportFilterForm`.

### Input hardening (why the listing is not injectable)

- `sort` is whitelisted against `['title','type','status','created','changed','revision_count','moderation_state']`; anything else falls back to `changed`.
- `status` is whitelisted to `['0','1']` (else NULL) and cast to `(int)`.
- Every date filter passes through `validateDate()` — `DateTime::createFromFormat('Y-m-d', ...)` with an exact round-trip check — before use.
- All user values (`title` LIKE `%..%`, `content_type`, `moderation_state`, date bounds) are passed as **placeholder arguments** to the DB API, never string-concatenated into SQL.
- `ContentReportFilterForm` (Form API, form id `content_report_filter_form`) validates that date fields are not in the future (`validateDateFields`) and persists filters to the same tempstore on submit; Reset deletes the tempstore entry.

## Access model (important)

Every aggregate/listing query runs through the controllers' private `applyNodeAccess(SelectInterface $query, string $node_id_field)`:

- Returns early (no restriction) if the user has `bypass node access`.
- Otherwise fetches `node_access_grants('view', $currentUser)`; if empty it forces `condition($node_id_field, 0)` (no rows).
- Otherwise inner-joins `node_access` and constrains `grant_view >= 1` plus an OR-group of `(realm, gid IN ...)` per grant.

So the pages only aggregate content the viewer may view, and the listing additionally re-checks `$node->access('view')` per row. Combined with the `restrict access: true` view permission, this is the module's deliberate answer to the fact that an aggregate can expose content a reader might not otherwise reach.

## Hooks & theming

`Hook\ContentInsightsReportHooks` implements `hook_help` (help.page text) and `hook_theme` (the two theme hooks and their variable defaults) as an autowired service, with thin `#[LegacyHook]` procedural shims in `content_insights_report.module`. Templates: `templates/content-insights-report.html.twig`, `templates/content-display.html.twig` (Twig auto-escaped; no `|raw`).
