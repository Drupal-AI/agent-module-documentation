<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing an Analyze plugin

The `Analyze` plugin type is how you put per-entity information on the "Analyze" tab. One plugin =
one analyzer = one summary block (+ optional full report) on every entity that has it enabled.

## Anatomy

- **Discovery**: annotation-based. Put the class in `src/Plugin/Analyze/` of your module.
  Manager: `AnalyzePluginManager` (`plugin.manager.analyze`), directory `Plugin/Analyze`,
  interface `AnalyzeInterface`, annotation `Drupal\analyze\Annotation\Analyze`, alter hook
  `analyze_info` (`hook_analyze_info_alter(&$analyzers)`), cache bin `analyze_plugins`.
- **Annotation keys** (`Annotation\Analyze`): `id`, `title`, `description`. In practice submodules
  annotate with `label = @Translation(...)` (used by `AnalyzePluginBase::label()` via
  `$this->pluginDefinition['label']`) and `description`.
- **Base class**: extend `Drupal\analyze\AnalyzePluginBase` (implements `AnalyzeInterface` and
  `ContainerFactoryPluginInterface`). Its constructor is injected with `analyze.helper`,
  `current_user` and `config.factory`; override `create()`/`__construct()` to add your own
  services (see `analyze_google_analytics` / `analyze_basic_content_info`).

## The one method you must implement

```php
public function renderSummary(EntityInterface $entity): array;
```

Return a render array whose `#theme` is **`analyze_table`** or **`analyze_gauge`** — the controller
(`AnalyzeController::validatePluginData()`) rejects anything else for the summary and throws
`InvalidPluginDefinitionException`. Return `[]` to render nothing for this entity.

- **Table**: `['#theme' => 'analyze_table', '#table_title' => '...', '#rows' => [['label' => ...,
  'data' => ...], ...]]`. Each row's `data` is cast to string by `analyze_preprocess_analyze_table`
  and the twig escapes it (`{{ row['data']|t }}`).
- **Gauge**: `['#theme' => 'analyze_gauge', '#caption' => ..., '#range_min'/'#value'/'#range_max' =>
  ..., '#range_min_label'/'#range_mid_label'/'#range_max_label'/'#display_value' => ...]`
  (or `analyze_circular_gauge`). See `analyze_plugin_example/src/Plugin/Analyze/Example.php`.

## Optional overrides (all have sane defaults in `AnalyzePluginBase`)

- `renderFullReport(EntityInterface $entity): array` — any render array; shown on the full-report
  route. Default `[]`.
- `getFullReportUrl(EntityInterface $entity): ?Url` — default returns the module's
  `analyze.<type>.<plugin>` route. Return `NULL` to suppress the "View full report" link
  (Basic Content Info does this); return another `Url` to link elsewhere. The access check calls
  `fullReportUrlOverridden()` and denies the default report route when overridden.
- `isApplicable(string $entity_type, ?string $bundle = NULL): bool` — default `TRUE`. Controls
  whether the analyzer appears in the per-bundle settings form (Google Analytics returns FALSE
  until GA Reports is configured).
- `isEnabled(EntityInterface $entity): bool` — default reads `analyze.settings` `status`
  `[type][bundle][plugin_id]`. Override to add extra conditions (GA also requires GA Reports setup).
- `access(EntityInterface $entity): bool` — default `TRUE`; the controller and access check call it
  per plugin. Override to tie the analyzer to a permission (GA requires
  `access google analytics reports`). **Note:** this is per-plugin display gating layered on top of
  the route's `view analyze reports` permission.
- `extraSummaryLinks(EntityInterface $entity): array` — array of `['title' => ..., 'url' => Url]`
  rendered as action links on the summary.
- `getConfigurableSettings(): array` — declares grouped settings (`type`/`title`/`settings`) that
  `getEntityTypeSettingsForm()` renders into the bundle edit form and stores in
  `analyze.plugin_settings`.
- `countAnalyzedEntities(string $entity_type_id, string $bundle): int` — default `0`; override for
  analyzers that persist results (used by batch reporting).

## Minimal example

```php
namespace Drupal\my_module\Plugin\Analyze;

use Drupal\Core\Entity\EntityInterface;
use Drupal\analyze\AnalyzePluginBase;

/**
 * @Analyze(
 *   id = "my_score",
 *   label = @Translation("My score"),
 *   description = @Translation("A demo analyzer.")
 * )
 */
final class MyScore extends AnalyzePluginBase {
  public function renderSummary(EntityInterface $entity): array {
    return [
      '#theme' => 'analyze_table',
      '#table_title' => 'My score',
      '#rows' => [['label' => 'Score', 'data' => 42]],
    ];
  }
}
```

Enable the module, then turn the analyzer on at Configuration > Content > Content Analysis (or the
bundle edit form). It appears on every enabled entity's Analyze tab. The route subscriber rebuilds
routes on cache clear, so run `drush cr` after adding a new plugin.
