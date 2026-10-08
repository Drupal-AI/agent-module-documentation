<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BrokenLinksChecker — the Analyze plugin

`src/Plugin/Analyze/BrokenLinksChecker.php`. Annotation `@Analyze(id =
"analyze_broken_links_checker", label = "Broken Links", ...)`. Extends
`Drupal\analyze\AnalyzePluginBase`, implements `Drupal\analyze\BatchableAnalyzerInterface`.
`create()` injects `analyze.helper`, `current_user`, `config.factory`, the module's three services
(`.storage`, `.link_extractor`, `.link_checker`), and `request_stack`.

## Access

- `access(EntityInterface $entity): bool` → `currentUser->hasPermission('access broken links reports')`.
  This is what shows/hides the Broken Links gauge + report on the Analyze tab.

## Rendering methods (Analyze tab)

- `renderSummary($entity)` — builds the health gauge (`#theme => 'analyze_gauge'`). Loads links via
  `getOrExtractLinks()`; if **all** links are still unchecked (`status_code === 0`) it triggers
  `linkChecker->checkUrls($urls)` inline, then recomputes. Healthy % is `healthy / checked` (checked =
  total − unchecked) so unchecked links don't inflate the score. `broken` = codes in
  `broken_status_codes`.
- `renderFullReport($entity)` — checks any still-unchecked URLs, then renders a sortable
  `#theme => 'table'` (URL / Status / Link Text / Last Checked via `Core\Utility\TableSort`). Only
  non-2xx rows are shown; 3xx rows append the redirect target. Adds an "Edit this content" button when
  the entity has an `edit-form` template and the user can access it. Long URLs/redirects are
  `mb_substr`-truncated for display. Status labels come from a private `getStatusLabel()` map.
- Both cells are placed as plain strings in Drupal render arrays → **auto-escaped by the table theme**
  (no `|raw`/`Markup`); `getStatusLabel()` output is a static, hard-coded label set.

## Batch / processing (`BatchableAnalyzerInterface`)

- `processEntity($entity, $force_refresh = FALSE)` — returns FALSE early if not forcing and
  `hasResults()` (valid cache) is true; on force it `deleteScores()`. Extracts links, saves the
  entity→URL mappings **filtered by `linkExtractor->matchesScope()`**, then `checkUrls()` the scoped
  URLs. This is what `drush analyze:batch --analyzers=analyze_broken_links_checker` and the batch UI
  call.
- `hasResults($entity)` → `storage->hasValidCache($entity)` (content-hash comparison).
- `countAnalyzedEntities($type, $bundle)` → delegates to storage (distinct analyzed entities; joins
  `node_field_data` for `node`).
- `getFullReportUrl($entity)` — returns NULL when the entity has no links (checks stored, then
  extracts on the fly), otherwise the parent report URL.
- `getOrExtractLinks()` (private) — returns valid cached scores, else extracts fresh, saves scoped
  mappings, and returns the stored rows.

## Hooks in `.module` / `.install`

- `hook_cron()` — first `linkChecker->recheckStaleUrls(50)`; if nothing was stale, calls
  `_analyze_broken_links_cron_scan_new_entities()` which reads `analyze.settings[status]`, finds up to
  10 **published** entities of enabled bundles (`accessCheck(FALSE)`), and runs
  `plugin->processEntity()` on each — automatic scanning without a manual batch.
- `hook_entity_update()` / `hook_entity_delete()` — for supported entities
  (`_analyze_broken_links_is_supported_entity()` = has the analyzer enabled for its type/bundle),
  call `storage->deleteScores($entity)` to drop stale mappings.
- `hook_requirements('runtime')` — status-report warning when broken URLs exist.
- `hook_views_pre_view()` — adds the "Configure settings" button to the report View for
  `administer analyze` users.
- `hook_schema()` — the two tables (see [../api/services.md](../api/services.md)).
