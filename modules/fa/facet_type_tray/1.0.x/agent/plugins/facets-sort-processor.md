<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets sort processor: `type_tray_category` (Sort by Type Tray categories)

File: `src/Plugin/facets/processor/TypeTrayOrderProcessor.php`
Class: `Drupal\facet_type_tray\Plugin\facets\processor\TypeTrayOrderProcessor extends SortProcessorPluginBase`
implements `SortProcessorInterface, ContainerFactoryPluginInterface`.
Annotation: `@FacetsProcessor(id = "type_tray_category", label = "Sort by Type Tray categories", stages = {"sort" = 40})`.

Orders the facet's results to match the category order defined in Type Tray.

## What `sortResults()` does

`sortResults(Result $a, Result $b)` compares two results by their position in the Type Tray category
list:

```
$categories = array_keys($this->config->get('categories')); // type_tray.settings:categories
return array_search($a->getRawValue(), $categories) - array_search($b->getRawValue(), $categories);
```

So results are ordered by the index of their raw value within `type_tray.settings:categories` (the same
order shown on the "Add content" screen). Raw values not present in the category list return
`array_search() === FALSE` (treated as 0 in arithmetic), so uncategorised/compound values sort toward
the start; pair this with the hierarchy plugin and the build processor for a coherent widget.

## Dependencies

`config.factory`, injected via `create()`; the constructor loads `type_tray.settings` into
`$this->config`. No entity loads, no request/query input.

## Operate

Enable on the facet's Processors tab under the sort section. It only reorders existing results; it does
not change which results appear or their labels.
