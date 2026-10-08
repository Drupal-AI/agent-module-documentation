<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Example analyzer (`example`) — a copy-paste Analyze plugin

`src/Plugin/Analyze/Example.php` — `final class Example extends AnalyzePluginBase`. This is a
**reference implementation**: copy it, change the namespace/id/label, and swap the placeholder data
for real logic. Per `README.md` it should not be enabled on a production site.

## Skeleton to copy

```php
namespace Drupal\analyze_plugin_example\Plugin\Analyze;

use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Url;
use Drupal\analyze\AnalyzePluginBase;

/**
 * @Analyze(
 *   id = "example",
 *   label = @Translation("Example Entity Reports"),
 *   description = @Translation("Provides an example plugin implementation for Analyzer.")
 * )
 */
final class Example extends AnalyzePluginBase { ... }
```

Discovery: annotation `@Analyze(...)` in a class under `src/Plugin/Analyze/`. That is all the base
Analyze module needs to pick the plugin up — no service, route or config registration. The base
auto-creates a **summary page for every entity with a canonical URL**, and a **full-report URL for
every enabled plugin that does not override `getFullReportUrl()`**.

## Methods it implements (what to override)

- `renderSummary(EntityInterface $entity): array` — returns an `analyze_table` with `#table_title`
  and up to **three** rows (`['label' => ..., 'data' => ...]`). The example shows `$entity->id()`
  and two literal `'Data'` values. Keep the summary to ≤3 items; put big data in the full report.
- `renderFullReport(EntityInterface $entity): array` — returns a render array shown on the plugin's
  auto-generated full-report page. The example returns a `#type => fieldset` wrapping an
  `analyze_gauge` (`#range_min`/`#range_max` 0..1, `#value` 0.5, `#display_value` '50%', min/mid/max
  labels). Base default (`AnalyzePluginBase::renderFullReport`) returns `[]`.
- `isApplicable(string $entity_type, ?string $bundle = NULL): bool` — the example returns TRUE only
  for `node` + bundle `article`, else FALSE. Controls which entity types/bundles may enable the
  plugin. Base default returns TRUE (all).
- `access(EntityInterface $entity): bool` — the example returns
  `$this->currentUser->hasPermission('access content')`. This is the per-plugin gate, layered on
  the parent Analyze route's `view analyze reports`. Base default returns TRUE.
- `extraSummaryLinks(EntityInterface $entity): array` — the example returns one entry
  `'global_report' => ['title' => t('Global Report'), 'url' => Url::fromUri('https://example.com/global-report')]`.
  Base default returns `[]`.

## Methods it inherits (does NOT override)

From `AnalyzePluginBase`: constructor/`create()` (injects `analyze.helper`, `current_user`,
`config.factory`), `label()`, `getFullReportUrl()` (auto-routes to
`analyze.<entity_type>.<plugin_id>` — so the example DOES get a full-report page), `isEnabled()`,
`fullReportUrlOverridden()`, `getConfigurableSettings()` (returns `[]` — no settings form here),
and the settings helpers. Note the example does **not** need a custom constructor/`create()`
because it injects no extra services (contrast `analyze_page_views`' `NodeViews`, which adds
`statistics.storage.node`).

## Try it on a dev site

1. `drush en analyze_plugin_example` (dev/training only — not for production).
2. Enable "Example Entity Reports" for the Article content type at Configuration > Content >
   Content Analysis (perm `administer analyze`); it is only applicable to `article` nodes.
3. Grant `view analyze reports` (parent tab) and `access content` (this plugin's `access()`).
4. Open an Article node → "Analyze" tab → "Example Table" summary, "Global Report" extra link, and
   a full-report page with the example gauge.

## Notes

- Purely illustrative: every value is a hard-coded placeholder; no external calls, no DB queries,
  no `eval`/debug endpoint, no configuration.
- `renderSummary` `data` values are cast to string and escaped by the `analyze_table` twig
  (`|t`); the gauge values are numeric — no user-markup surface.
- The `.info.yml` has `hidden: false`, so despite the README's "hidden from the module listing"
  wording the module does appear on `admin/modules`.
