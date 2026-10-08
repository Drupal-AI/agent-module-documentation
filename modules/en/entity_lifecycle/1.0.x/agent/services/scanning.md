<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The scan pipeline: presave stamping, cron, scanner, Drush, banner

## Save-time stamping (`hook_entity_presave`)

`entity_lifecycle_entity_presave()` → `LifecycleHookHandler::applyPresaveStatus()`
(`src/Service/LifecycleHookHandler.php`). For a content entity of an enabled type with a `lifecycle_status`
field: new entities get the configured default status + a `lifecycle_last_reviewed` timestamp and a
`lifecycle_condition_details` of "Content created"; existing entities are re-stamped to the default status
with a new timestamp ("Content updated") on every save — so editing is treated as a review. In `shared`
translation mode, non-default translations are skipped (avoids core's untranslatable-fields constraint);
`_entity_lifecycle_restore_readonly_fields` (an `#entity_builders` callback registered by
`LifecycleFormAlterHandler`) restores the widget-less read-only fields so translation saves don't blank
them. If the status actually changed, an ECA status event is dispatched (see submodules).

## Cron (`hook_cron`)

`entity_lifecycle_cron()` → `LifecycleHookHandler::runCron()`. Reads `cron_interval` (default 24h): `0`
→ `disabled`; otherwise, unless `-1` (every run), it compares `now - state('entity_lifecycle.last_scan')`
against the interval and returns `throttled` or runs `LifecycleScanner::scanAndMark()` then updates the
state key (`scanned`).

## Scanner (`src/Service/LifecycleScanner.php`, service `entity_lifecycle.scanner`)

Facade over `LifecycleStatusEvaluator` (decides status) and `LifecycleStatusWriter` (persists).
- `scanAndMark($dry_run, $entity_type, $bundle)` — resolves enabled bundles
  (`getAllEnabledBundles()`) and bundleless types (`getAllEnabledBundlelessEntityTypes()`) from config,
  finds candidate entities, evaluates conditions per translation, and for each entity whose status would
  change calls `updateLifecycleStatus()` and (when ECA is on) dispatches a status-change event. A
  scan-completed event is dispatched at most once per `entity_lifecycle.scan_event_interval` (default
  86400s) to avoid spam.
- `findEntitiesForStatusUpdate()` / `findBundlelessEntitiesForStatusUpdate()` — entity queries use
  `accessCheck(FALSE)` (system-level batch maintenance) and skip entities with `lifecycle_exclude`;
  bundleless queries fire `hook_entity_lifecycle_bundleless_query_alter` and `_scan_result_alter`.
- `rebuildAndMark()` — clears existing statuses (`LifecycleStatusWriter::clearLifecycleStatuses()`), then
  re-scans.
- `getStatistics()` — per-status counts per entity type via direct DB `COUNT(*)` GROUP BY
  `lifecycle_status`, altered by `hook_entity_lifecycle_stats_query_alter`.
- `evaluateConditions()` / `getMatchedConditionsSummary()` — delegate to the evaluator (kept public as
  the de-facto API used by Drush).
- `getTranslationsToEvaluate()` — one entry keyed `NULL` in shared mode; one per language in
  per_translation mode.

## Evaluator (`LifecycleStatusEvaluator`)

`evaluateConditions()` sorts a bundle's conditions by weight and returns the status of the first matching
one. Each condition either uses the new `groups[]` structure (`evaluateConditionGroups()` with a
`group_operator` AND/OR across groups; plugins within a group are ANDed by `evaluatePluginGroup()`) or the
legacy flat `plugins[]` array. A condition with no plugins always matches (catch-all). Plugin errors are
logged and treated as non-match. `getMatchedConditionsSummary()` returns the first condition's plugins'
`getFormattedValue()` joined by commas — stored into `lifecycle_condition_details`.

## Writer (`LifecycleStatusWriter`)

`updateLifecycleStatus()` writes `lifecycle_status` (+ optional `lifecycle_condition_details`) **directly
to the entity data table** via `db->update()` — deliberately bypassing the Entity API so the `changed`
timestamp is not touched — then resets the entity cache. In per_translation mode the update is scoped to
one `langcode`; in shared mode it covers all rows. `clearLifecycleStatuses()` /
`clearLifecycleStatusForBundle()` / `…Bundleless()` NULL out the status fields for enabled bundles/types.

## Status checker & banner

`LifecycleStatusChecker` (`entity_lifecycle.status_checker`) — `needsReviewBanner()`,
`isOverdueForReview()`, `getReviewValidityMonths()`, `isEnabledForBundle()`;
`statusRequiresReview()` loads the status config entity, `userCanSeeBanner()` checks `banner_roles` or the
`view entity lifecycle dashboard` permission.
`entity_lifecycle_page_top()` → `LifecyclePageBannerService::attachBanner()` — when `display_banner` is on
and the current route resolves to an enabled entity whose status requires review, injects an `#type
container` role=alert banner (weight -1000) with a `t()`-escaped message; status label from the config
entity.

## Drush (`src/Drush/Commands/EntityLifecycleCommands.php`)

CLI-only. `entity-lifecycle:scan` (`lc-scan`), `:rebuild` (`lc-rebuild`) — options `--dry-run`,
`--entity-type`, `--bundle`; `:stats` (`lc-stats`); `:config` (`lc-config`). Scan/rebuild print result
tables and call the scanner; rebuild of a bundleless type resets fields then evaluates each entity,
falling back to the default status when no condition matches.
