<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets sort processor: content_type_or_other_sort

Class `Drupal\facets_content_type_or_other\Plugin\facets\processor\ContentTypeOrOtherSortOrder`
(`src/Plugin/facets/processor/ContentTypeOrOtherSortOrder.php`), extends `SortProcessorPluginBase`
and implements `SortProcessorInterface`.

## Plugin definition

`@FacetsProcessor` annotation: `id = "content_type_or_other_sort"`, label
*Content type or Other - Sort order*, `stages = { "sort" = 10 }`. Its description notes that the facet's
generic "Sort order" radio input is ignored when this processor is used.

## Sort logic

`getFirstOrderContentTypesSortOrder()` reads `facets_content_type_or_other.settings:first_order_config`,
collects each first-order row's `label_override` (in the stored order), and appends `'Other'` at the end —
producing an ordered array of the facet's display values (memoised on `$firstOrderContentTypes`).

`sortResults(Result $a, Result $b)` looks up each result's `getRawValue()` position in that ordered array
with `array_search()` and returns the spaceship comparison (`$a_pos <=> $b_pos`). Effect: first-order types
appear in the configured order and `'Other'` is always last.

## Configure / operate

1. Build a facet on the indexed `content_type_or_other` field (see
   [search-api-processor.md](search-api-processor.md)).
2. On the facet edit form → **Facet sorting**, enable **Content type or Other - Sort order** and
   **deselect all other sorting options** (multiple active sorts would fight this one).
3. Ordering follows the weights set in the settings form ([../config/settings.md](../config/settings.md));
   re-index after changing them.

Note: comparison is against the `label_override` strings from config, so if a subscriber to
`SetIndexedValue` rewrites indexed values to something not present in `first_order_config`, those results
sort as "not found" (position `false`) relative to the configured list.
