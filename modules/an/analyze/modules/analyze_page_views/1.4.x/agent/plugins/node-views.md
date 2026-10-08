<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Node Page Views analyzer (`node_views`)

`src/Plugin/Analyze/NodeViews.php` — `final class NodeViews extends AnalyzePluginBase`.

## Definition

```
@Analyze(
  id = "node_views",
  label = @Translation("Node Page Views Reports"),
  description = @Translation("Provides details from the Statistics module about nodes for Analyzer.")
)
```

## Dependencies injected (`create()` / constructor)

Base three (`analyze.helper`, `current_user`, `config.factory`) plus **`statistics.storage.node`**
(`Drupal\statistics\NodeStatisticsDatabaseStorage`), stored as `$this->nodeStatisticsDatabaseStorage`.

## Where the counts come from (core Statistics, not GA)

`renderSummary(EntityInterface $entity)`:

- `$views = $this->nodeStatisticsDatabaseStorage->fetchView($entity->id())` — the core Statistics
  storage service. `fetchView()` runs a parameterized query against the core **`node_counter`**
  table (`{node_counter}`), keyed by `nid`, and returns a `StatisticsViewsResult` (or `FALSE` if
  there is no row yet).
- `$total = $views->getTotalCount()` and `$day = $views->getDayCount()`. If `fetchView()` returns
  falsy, both default to `0`.
- Counts are only present when core Statistics' **"Count content views"** counter is enabled
  (`admin/config/system/statistics`); this submodule does not populate the table, it only reads it.
- **Not** Google Analytics, **not** a raw DB query written here — it delegates to the core service.

## What it renders

Returns an `analyze_table`:

- `#table_title` = `'Node views'`
- rows: `['label' => 'Total views', 'data' => $total]` and
  `['label' => "Today's count", 'data' => $day]`

`$total`/`$day` are integers from the core service; `analyze_preprocess_analyze_table` casts `data`
to string and the `analyze_table` twig escapes it via `|t`, so nothing user-controlled is rendered
into markup.

## Applicability & access

- `isApplicable(string $entity_type, ?string $bundle = NULL)` → `return $entity_type == 'node';`.
  Statistics are recorded per node, so the plugin is offered only on `node` bundles.
- `getFullReportUrl(EntityInterface $entity)` → `NULL`. Summary-only; no per-plugin full-report
  route/link (the parent treats the URL as overridden and shows no "View full report" link).
- `access(EntityInterface $entity)` → `return $this->currentUser->hasPermission('view post access counter');`
  This **overrides** the base `access()` (which returns TRUE) and reuses the core **Statistics**
  permission. It is an additional gate layered on the parent Analyze tab's `view analyze reports`
  route access — a user needs **both** to see the counts.

## Enable / operate

1. `drush en analyze_page_views` (pulls in `analyze`, `node`, `statistics`).
2. Enable core Statistics content-view counting at
   Configuration > System > Statistics (`admin/config/system/statistics`) so `node_counter` fills.
3. Enable "Node Page Views Reports" for the `node` bundle(s) you want at
   Configuration > Content > Content Analysis, or in the content type's edit form
   "Analyze settings" section (perm `administer analyze`).
4. Grant roles both `view analyze reports` (parent tab) **and** `view post access counter`
   (this plugin's `access()`).
5. Open a node's canonical page → "Analyze" tab → "Node views" table.

## Notes

- Summary-only analyzer; a clean reference for (a) injecting a core service into an Analyze plugin
  and (b) adding a plugin-specific permission gate via `access()`.
- A row of `0`/`0` usually means core Statistics is not counting views (counter disabled) rather
  than genuinely zero traffic.
- `fetchView()` uses the core service's own parameterized query — no SQL is assembled in this
  submodule.
