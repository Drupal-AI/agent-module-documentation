<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Processor plugin `range_input` (RangeInputProcessor)

File: `src/Plugin/facets/processor/RangeInputProcessor.php`
Class: `Drupal\facets_range_input\Plugin\facets\processor\RangeInputProcessor extends ProcessorPluginBase implements PreQueryProcessorInterface, PostQueryProcessorInterface, BuildProcessorInterface`
Annotation: `@FacetsProcessor(id = "range_input", ...)` with stages `pre_query = 60`, `post_query = 60`, `build = 20`.

Enable it on the same facet that uses the Range Input widget. It runs at three Facets stages.

## preQuery(FacetInterface $facet)

Reads `$facet->getActiveItems()` and rewrites each one:

```
preg_match('/\(min:((?:-)?[\d\.]+),max:((?:-)?[\d\.]+)\)/i', $item, $matches)
```

- On match, the item becomes `[$matches[1], $matches[2]]` — the captured min/max.
- On no match, the item becomes `NULL`.

The capture groups accept only an optional leading `-`, digits and dots, so a **non-numeric** submitted bound
cannot match and is discarded (item set to NULL) rather than reaching the query. The resulting numeric pair is
what the Facets `range` query type consumes to build the (parameterized) index condition; this module writes no
query string itself.

## build(FacetInterface $facet, array $results)

Rewrites each result URL so it carries a **placeholder** range token:

1. Gets active filters from the facet's `url_processor_handler` → `getProcessor()->getActiveFilters()`.
2. For each result, removes this facet's own filter and appends
   `'(min:__range_input_min__,max:__range_input_max__)'`.
3. Builds the URL with `\Drupal::service('facets.utility.url_generator')->getUrl($new_active_filters, FALSE)` and
   `$result->setUrl($url)`.

The two `__range_input_min__` / `__range_input_max__` tokens are later replaced with the visitor's numeric values
client-side by `js/range-input.js` (`facetsRangeInputFilter`). The base URL is produced by the Facets URL
generator, i.e. the facet's own route.

## postQuery(FacetInterface $facet)

Synthesises a continuous set of results:

1. Collects each existing result's `(float) getRawValue()` + `(int) getCount()` into `$simple_results`, sorted
   ascending.
2. Takes `$min` (first) and `$max` (last), defaulting to 0.
3. Loops `for ($i = $min; $i <= $max; $i++)`, creating a `new Result($facet, (float) $i, (float) $i, $count)` for
   every integer step (count 0 where none exists), each with active state = whether the facet has active items.
4. `$facet->setResults($new_results)` overwrites the facet's results with the generated series (this is what
   `RangeInputWidget::build()` then iterates for its base URL). Note: on large min–max spans this integer loop can
   generate many Result objects.
