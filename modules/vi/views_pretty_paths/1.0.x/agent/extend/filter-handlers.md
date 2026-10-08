<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding a custom filter handler

A view may use an exposed-filter plugin that Views Pretty Path doesn't handle yet. Add support from a custom module.

## Steps
1. Create a class implementing `Drupal\views_pretty_paths\FilterHandlers\ViewsPrettyPathFilterHandlerInterface` and extending `Drupal\views_pretty_paths\FilterHandlers\AbstractFilterHandler`.
2. Implement:
   - `getTargetedFilterPluginIds()` — return the Views **filter plugin IDs** this handler covers (e.g. `['taxonomy_index_tid']`).
   - `transformPathValueForViewsQuery($filter_value_string, $filter_data)` — pretty-path segment → the value(s) Views expects in `request->query` (inbound).
   - `transformSubmittedValueForUrl($value)` — submitted filter value → the URL path segment (outbound).
3. Register it as a service parented to `views_pretty_paths.filter_handlers.abstract` (which injects `@database`) and tag it `views_pretty_paths_filter_handler`:

```yaml
services:
  my_module.pretty_path.myfilter:
    class: Drupal\my_module\FilterHandlers\MyFilterHandler
    parent: views_pretty_paths.filter_handlers.abstract
    tags:
      - { name: 'views_pretty_paths_filter_handler' }
```

The path processor collects tagged handlers via `addFilterHandler()` and keys them by targeted plugin id.

## Helpers available on `AbstractFilterHandler`
- `encodeMultipleWordsForUrl($string, $delimiter='-')` / `encodeWordForUrl($word)` (uses `UrlHelper::encodePath`)
- `decodeUrlWord($word)`
- `$this->database` (the DB connection)

## Reference implementations
See `TaxonomyFilterHandler` (term name ↔ tid via a parameterized `escapeLike` `LIKE` query on `taxonomy_term_field_data`, filtered by `vid`), `BundleFilterHandler`, `TextFilterHandler`, `DateFilterHandler`. Follow the same pattern — use the query builder / bound conditions, never string concatenation, since inbound path values are untrusted request input.
