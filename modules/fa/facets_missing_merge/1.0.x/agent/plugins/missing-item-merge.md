<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `missing_item_merge` facet processor

File: `src/Plugin/facets/processor/MissingItemMergeProcessor.php`
Class: `Drupal\facets_missing_merge\Plugin\facets\processor\MissingItemMergeProcessor`
extends `Drupal\facets\Processor\ProcessorPluginBase` implements `BuildProcessorInterface`
(uses `UnchangingCacheableDependencyTrait`).

## Plugin definition

`@FacetsProcessor(id = "missing_item_merge", label = @Translation("Merge missing item"), stages = { "build" = 5 })`.
Discovered by the **Facets** processor plugin manager; this module defines no plugin type of its own.
Because it runs in the `build` stage, it must be ordered **before the URL processor** (README) — it
edits missing-filter parameters that the URL processor later turns into facet links.

## Configuration

- `defaultConfiguration()` → `['target_item' => '']`.
- `buildConfigurationForm()` adds one element inside the facet's processor settings (reached through the
  Facets facet-edit form, so access-controlled by Facets' own `administer facets` permission — not a
  route this module declares):
  - `target_item` — `#type => textfield`, title *"Target item"*, description *"Title or value that
    should be used as the target to merge the missing item onto."*
- Config schema `config/schema/facets_missing_merge.processor.schema.yml` types the key as
  `plugin.plugin_configuration.facets_processor.missing_item_merge` → `target_item: string`.
  The value is stored in the facet entity's processor config, not a config object owned by this module.

## build() behaviour

`build(FacetInterface $facet, array $results)`:

1. Returns `$results` unchanged if `$facet->isMissing()` is FALSE (no-op unless the facet's "missing"
   option is enabled).
2. `getMissingFacetItemKey($results)` — first result where `$result->isMissing()` is TRUE.
3. `getTargetFacetItemKey($results)` — first result where `$result->getRawValue() == $target_item`
   **or** `$result->getDisplayValue() == $target_item` (target matched by raw value or label;
   `$target_item` is `trim()`-ed). Loose `==` comparison.
4. If either key is `null`, returns `$results` unchanged.
5. Merge, mutating the missing result object:
   - Removes the target's raw value from the missing result's missing filters via
     `array_filter(...getMissingFilters(), fn => $filter != $target->getRawValue())` then
     `setMissingFilters(array_values(...))`.
   - `setCount(missingCount + targetCount)` — sums the two counts.
   - `setDisplayValue((string) $this->t('@target (or @missing)', ['@target' => $targetLabel, '@missing' => $missingLabel]))`
     — the merged label; the two source labels come from each result's `getDisplayValue()`.
6. Places the (mutated) missing result at the target's position and `unset()`s the old missing
   position, so the list shrinks by one item and the target slot now shows the merged item.

Result: the target item is replaced by the merged "missing" item — same position, combined count,
combined filters, relabelled *"Target (or None)"*.

## Operating notes

- Enable the facet's **"missing"** option first, or the processor does nothing.
- If `target_item` matches no visible result (e.g. the target has zero results this request, or the
  string does not match any raw/display value), no merge happens.
- Order before the URL processor (build stage) so the rewritten missing filters produce correct links.
- Covered by the unit test `tests/src/Unit/MissingItemMergeProcessorTest.php` (raw-value and
  display-value target matching, count summing, filter removal, relabelling).
