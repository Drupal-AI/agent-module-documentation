<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sort processor: `custom_widget_order` ("Sort by custom order")

`src/Plugin/facets/processor/CustomWidgetOrderProcessor.php`

```
@FacetsProcessor(
  id = "custom_widget_order",
  label = @Translation("Sort by custom order"),
  description = @Translation("Sorts the facet in a predifined custom order."),
  stages = { "sort" = 40 }
)
class CustomWidgetOrderProcessor
  extends SortProcessorPluginBase
  implements SortProcessorInterface
```

It also `use`s `UnchangingCacheableDependencyTrait`, so it declares no cache contexts/tags/max-age
of its own — the ordering is static config, not request-dependent.

## Configuration form
`buildConfigurationForm()` reads the facet's current processor config
(`$facet->getProcessors()[$this->getPluginId()]`) and renders two elements:

| Element | Type | Config key | Meaning |
|---|---|---|---|
| Custom order | `textarea` | `custom_order` | The sequence, **one item per line**. "All items not listed here get added at the end." |
| Use display values | `checkbox` | `display_values` | If checked, match lines against each result's **display value**; otherwise against its **raw value**. |

There is no submit/validate handler — Facets persists the element values into the processor
configuration directly. The config schema
(`plugin.plugin_configuration.facets_processor.custom_widget_order`) types `custom_order` as
`string`, `display_values` as `boolean`, and also lists a `sort` string that this plugin never
reads or writes (leftover from the generic sort-processor schema).

## Sorting logic
`sortResults(Result $a, Result $b)` is the `SortProcessorInterface` comparator Facets calls while
ordering the built facet:

```php
$order = $this->getOrder();   // rank map
$count = $this->getCount();   // number of listed lines
$a_value = $config['display_values'] ? $a->getDisplayValue() : $a->getRawValue();
$b_value = $config['display_values'] ? $b->getDisplayValue() : $b->getRawValue();
return ($order[$a_value] ?? $count) <=> ($order[$b_value] ?? $count);
```

- `getOrder()` builds the rank map once (memoised in `$this->order`):
  `array_flip(array_map('trim', explode(PHP_EOL, $config['custom_order'])))`. So the **line number
  (0-based) is the rank**, and a value's rank is looked up by exact string match after trimming.
- `getCount()` returns `count($this->order)` — the number of distinct listed lines — used as the
  rank for **any value not in the list**. All unlisted values share that one rank and therefore tie
  at the very end; their relative order is left to the sort's prior state (the doc text calls this
  "random").

## Behavioural notes / limits
- **Exact, trimmed, case-sensitive string match.** A line must equal the chosen value (display or
  raw) exactly after `trim()`. Trailing/leading spaces are stripped; internal differences,
  casing, or HTML entities in a display value are not normalised.
- **Raw vs display matters.** For taxonomy/entity-reference facets the raw value is usually an ID;
  to order by the human label you must tick "Use display values" and list labels.
- **No direction control.** The `sort` (ASC/DESC) schema key is inert here; reverse ordering is not
  supported — author the lines in final order.
- **`PHP_EOL` split.** Lines are split on the server's `PHP_EOL`. On a normal Linux/DDEV host
  (`\n`) textarea input works; the `trim()` on each line also removes a stray `\r`, so CRLF input is
  tolerated in practice.
- **Duplicate lines** collapse under `array_flip` — the last occurrence of a repeated value wins its
  rank.

## Verify on a running site
- List/confirm the plugin: `ddev drush php:eval "var_dump(\Drupal::service('plugin.manager.facets.processor')->hasDefinition('custom_widget_order'));"`
- The setting lives under a facet's config export at
  `processor_configs.custom_widget_order.settings.{custom_order,display_values}`.
