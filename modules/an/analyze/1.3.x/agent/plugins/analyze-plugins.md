<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze plugin type (`@Analyze`)

The one plugin type this module defines. An analyzer puts a report on an entity's Analyze tab.

- **Discovery dir:** `src/Plugin/Analyze/` in any module.
- **Interface:** `Drupal\analyze\AnalyzeInterface`. **Base class:** `Drupal\analyze\AnalyzePluginBase`
  (extends core `PluginBase`, implements `AnalyzeInterface` + `ContainerFactoryPluginInterface`).
- **Annotation:** `Drupal\analyze\Annotation\Analyze` — properties `id`, `title`, `description`
  (the README/example use `label` too via `@Translation`; `label()` reads `pluginDefinition['label']`).
- **Manager service:** `plugin.manager.analyze` (`AnalyzePluginManager`), alter hook `hook_analyze_info_alter(&$analyzers)`, cache bin `analyze_plugins`.

## Minimum implementation
Create `my_module/src/Plugin/Analyze/MyAnalyzer.php`, depend on `analyze:analyze`, extend
`AnalyzePluginBase`, and implement `renderSummary()`:

```php
/**
 * @Analyze(
 *   id = "my_analyzer",
 *   label = @Translation("My Analyzer"),
 *   description = @Translation("What this analyzer does")
 * )
 */
final class MyAnalyzer extends AnalyzePluginBase {
  public function renderSummary(EntityInterface $entity): array {
    return [
      '#theme' => 'analyze_table',        // or 'analyze_gauge'
      '#table_title' => 'My Analysis',
      '#rows' => [
        ['label' => 'Words', 'data' => 123],
        // max 3 rows for a readable summary
      ],
    ];
  }
}
```

**Summary is validated** (`AnalyzeController::validatePluginData`): a summary render array **must**
set `#theme` to exactly `analyze_gauge` or `analyze_table`, else the controller throws
`InvalidPluginDefinitionException`. Full reports (`renderFullReport()`) may return anything.

### Theme hooks (from `analyze.module`)
- `analyze_gauge` vars: `caption`, `range_min_label`, `range_mid_label`, `range_max_label`,
  `range_min`, `value`, `display_value`, `range_max`. (Renders a linear gauge.)
- `analyze_table` vars: `table_title`, `rows` (each row `{label, data}`; `data` is cast to string and
  `|t`-translated in the template — pass plain values, not markup).

## Overridable `AnalyzeInterface` methods (defaults in `AnalyzePluginBase`)
- `renderSummary($entity)` — required, no default.
- `renderFullReport($entity)` → `[]` (no full report).
- `getFullReportUrl($entity)` → route `analyze.{entity_type}.{plugin_id}`; return `NULL` to drop the
  link. `fullReportUrlOverridden()` reports whether you changed it (governs default-route access).
- `isEnabled($entity)` → reads `analyze.settings:status[type][bundle][plugin_id]`.
- `isApplicable($entity_type, $bundle = NULL)` → `TRUE` (limit which types/bundles can enable it).
- `access($entity)` → `TRUE` (per-plugin access gate, checked in the controller and access checker).
- `extraSummaryLinks($entity)` → `[]` (array of `{title, url}` shown as action links).
- `getConfigurableSettings()` → `[]` (structure that `getEntityTypeSettingsForm()` renders into the
  bundle edit form; see configure doc).

## Batch-capable analyzers (new in 1.3.0)
Also implement `Drupal\analyze\BatchableAnalyzerInterface` to be picked up by the batch UI/Drush:
- `processEntity(EntityInterface $entity, bool $force_refresh = FALSE): bool` — do the real analysis
  and **persist results yourself**; return `TRUE` only on success+save, `FALSE` when skipped/failed.
  Do NOT delegate through `renderSummary()`. Let `Drupal\ai\Exception\AiRateLimitException` propagate
  — the batch service retries with backoff (2s/4s/8s).
- `hasResults(EntityInterface $entity): bool` — used to skip already-analyzed entities.
- Optional override on the base class: `countAnalyzedEntities($entity_type_id, $bundle): int` (default
  `0`) for fast `--status` coverage if you store results in a DB table.

## Bundled analyzers (submodules, each its own `@Analyze` plugin)
- `analyze_basic_content_info` → `ContentInfo` (word/image counts).
- `analyze_page_views` (Node Statistics) → `NodeViews` (needs core `statistics`).
- `analyze_google_analytics` → `GoogleAnalytics` (needs `google_analytics_reports` + `views`).
- `analyze_plugin_example` → `Example` (reference implementation).
