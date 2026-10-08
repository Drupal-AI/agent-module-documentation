<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & integration points

## `analyze.helper` — `Drupal\analyze\Helper` (`HelperInterface`)
Central lookup used by the controller, access checker and forms.
- `getConfig(): ?ImmutableConfig` — the `analyze.settings` config.
- `getEntity(string $entity_type): ?EntityInterface` — the entity from the current route match.
- `getPlugins(array $plugin_ids = []): array` — instantiated `@Analyze` plugins (all, or a subset).
- `getEntityDefinitions(): array` — entity types **with a `canonical` link template** (the ones
  Analyze applies to).
- `getEntityBundles(string $entity_type): array`, `getApplicableDefinitions($type, $bundle = NULL)`
  — definitions whose plugin `isApplicable()` returns TRUE for the type/bundle.

## `analyze.batch_service` — `Drupal\analyze\Service\AnalyzeBatchService` (new in 1.3.0)
Backs both the batch form and `analyze:batch`.
- `getBatchableAnalyzers(): array` — plugin_id ⇒ label for analyzers implementing
  `BatchableAnalyzerInterface`.
- `getAvailableEntityBundles(array $analyzer_ids): array` — `type:bundle` ⇒ label for bundles that
  have any of those analyzers enabled in `analyze.settings:status`.
- `getEntitiesForAnalysis($analyzer_ids, $entity_bundles, $force = FALSE, $limit = 0): array` —
  published entities needing analysis (skips those where **all** chosen analyzers `hasResults()`
  unless `$force`). `accessCheck(FALSE)` — intended to run under the admin-gated command/form.
- `getAnalysisStatus($analyzer_ids, $entity_bundles): array` — total/pending/coverage per bundle
  (uses `countAnalyzedEntities()`).
- `processBatch($entities, $analyzer_ids, $force, $total, &$context)` — Batch API callback; runs each
  enabled analyzer's `processEntity()`, retries rate-limit exceptions with backoff, tallies
  processed/failed/rate_limited into `$context['results']`.

## `plugin.manager.analyze` — `AnalyzePluginManager`
The `@Analyze` plugin manager (see plugins doc). `getDefinitions()`, `createInstance($id)`; alterable
via `hook_analyze_info_alter()`.

## Access checker — `_analyze_access` (`AnalyzeAccessAccessChecker`, service `access_check.analyze.analyze_access`)
Route requirement on all Analyze report routes. Grants access only when the account has
`view analyze reports` **and** the entity's type+bundle is enabled; for a plugin route it also
requires that plugin enabled, honours a plugin's `access()` (forbid) and `fullReportUrlOverridden()`
(deny the default route if the plugin redirects its full report elsewhere).

## Integration plugins
- **Content Intel** — `Drupal\analyze\Plugin\ContentIntel\AnalyzePlugin` (`#[ContentIntel(id:
  'analyze')]`, weight 30). If `content_intel` is installed, exposes each enabled analyzer's summary
  to the Content Intel framework: `collect()` renders summaries in an isolated render context (CLI-
  safe) and flattens `analyze_table`/`analyze_gauge` render arrays into structured data. Degrades
  gracefully when Analyze services are absent (`isAvailable()`).
- **Views filter** — `Plugin/views/filter/AnalyzeSelectFilter` (`@ViewsFilter("analyze_select")`),
  an `InOperator` select filter that builds options from a callback, a lookup table, or distinct
  column values.

## Hooks invited (`analyze.api.php`)
- `hook_analyze_info_alter(array &$analyzers)` — alter the analyzer definition list (e.g. relabel).
- `hook_theme()` / `analyze_theme()` — reference the `analyze_gauge` render method (see the example
  submodule).
