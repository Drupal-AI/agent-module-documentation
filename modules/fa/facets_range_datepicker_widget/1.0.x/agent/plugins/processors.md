<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets processors: `datepicker` and `range_datepicker`

Files: `src/Plugin/facets/processor/DatepickerProcessor.php`,
`src/Plugin/facets/processor/RangeDatepickerProcessor.php`. Both extend
`Drupal\facets\Processor\ProcessorPluginBase` and implement `PreQueryProcessorInterface` +
`BuildProcessorInterface`. Both run at stages `pre_query = 60` and `build = 20`. Each is the mandatory companion
of the widget of the same id (enforced by the widget's `isPropertyRequired()`, see [widgets.md](widgets.md)).

## `DatepickerProcessor` (id `datepicker`)

`@FacetsProcessor(id = "datepicker", label = "Datepicker", description = "Add results for selected day.")`

- `build(FacetInterface $facet, array $results)`: reads the active filters from the URL processor
  (`facet->getProcessors()['url_processor_handler']->getProcessor()->getActiveFilters()`), drops the empty-key
  entry, and for each result (only when the facet widget type is `datepicker`) rebuilds the filter set without
  this facet and appends **one generic placeholder filter** `'(min:__datepicker_min__)'`, then sets the result
  URL via `\Drupal::service('facets.utility.url_generator')->getUrl($new_active_filters, FALSE)`. The widget hands
  this token URL to the JS, which replaces `__datepicker_min__` with the chosen timestamp.
- `preQuery(FacetInterface $facet)`: when the widget type is `datepicker`, walks the active items and, for each,
  matches `'/\(min:((?:-)?[\d\.]+)/i'`. On match it rewrites the item to
  `['min' => $matches[1], (string)($matches[1] + 86399)]` — i.e. the selected day start plus 86399 seconds (the
  whole day). No match → the item is set to `NULL`. Then `setActiveItems()`.
- `supportsFacet()`: TRUE only when the facet source field is a `FieldItemDataDefinition` whose storage type is
  one of `datetime`, `created`, `changed`.

## `RangeDatepickerProcessor` (id `range_datepicker`)

`@FacetsProcessor(id = "range_datepicker", label = "Range Datepicker", description = "Add results for all the
steps between min and max range.")`

- `build()`: same structure, but the appended placeholder filter is
  `'(min:__range_datepicker_min__,max:__range_datepicker_max__)'`, and it acts only when the widget type is
  `range_datepicker`.
- `preQuery()`: for each active item tries, in order:
  - `'/\(min:((?:-)?[\d\.]+),max:((?:-)?[\d\.]+)\)/i'` → `['min' => $matches[1], 'max' => $matches[2]]`;
  - else `'/\(min:((?:-)?[\d\.]+)/i'` (min only) → `['min' => $matches[1], date('U', strtotime('+100 years'))]`
    (open upper bound);
  - else `'/max:((?:-)?[\d\.]+)\)/i'` (max only) → `[date('U', 0), 'max' => $matches[1]]` (lower bound = epoch);
  - else → `[]` (empty item).
- `supportsFacet()`: TRUE only when the field storage type is `datetime`, `created`, `updated`.

## Behavior summary

The value parsed from the facet query is strictly numeric (optionally leading `-`, digits and dots only), and is
handed to Facets' `range` query type as `min`/`max` bounds — the processors never concatenate the parsed value
into a raw query string. A facet param that does not match the regex yields `NULL`/`[]` rather than a bound.
