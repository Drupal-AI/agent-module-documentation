<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Cleanup services

Each service operates over a `$view_ids` array; passing `NULL` targets **all** views.

- **`views_cleanup.filter_cleanup`** —
  `cleanupViewsFiltersByFilterCheckOptions($filter_check_options, $view_ids)`
  removes filters matching e.g. `['entity_field' => 'field_is_shared', 'operator' => '!=']`.
- **`views_cleanup.filter_replacement`** — replace a filter across views.
- **`views_cleanup.filter_add`** — add a filter to views.
- **`views_cleanup.aggregate_views_filter_option`** — adjust aggregate filter options.
- **`views_cleanup.denpendencies`** —
  `cleanupViewsDependencyModule($modules, $view_ids)` strips module dependencies.
- **`views_cleanup.fields_cleanup`** — remove orphaned fields.

## Usage
```php
$opts = ['entity_field' => 'field_is_shared', 'operator' => '!='];
\Drupal::service('views_cleanup.filter_cleanup')
  ->cleanupViewsFiltersByFilterCheckOptions($opts, ['view_id1','view_id2']);
```
Also available via the `ViewsCleanupCommands` Drush command. Export config afterwards.
