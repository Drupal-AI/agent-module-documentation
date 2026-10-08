<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Views hooks reference

## Naming
For a core hook `hook_views_<suffix>`, implement in your module:
- `mymodule_extra_views_<VIEW_ID>_<suffix>` — fires for any display of that view.
- `mymodule_extra_views_<VIEW_ID>__<DISPLAY_ID>_<suffix>` — fires only for that display. `DISPLAY_ID` is the snake_case form (`page-1` → `page_1`).

Example: to alter the query of view `favorite_fruits`, display `page_1`:
```php
function mymodule_extra_views_favorite_fruits__page_1_query_alter(\Drupal\views\ViewExecutable $view, \Drupal\views\Plugin\views\query\QueryPluginBase $query) {
  // ...
}
```

## Supported hooks and signatures
Signatures mirror the core hooks (see `views_hooks_extras.api.php`):
- `..._query_substitutions(ViewExecutable $view)`
- `..._pre_view(ViewExecutable $view, $display_id, array &$args)`
- `..._pre_build(ViewExecutable $view)`
- `..._post_build(ViewExecutable $view)`
- `..._pre_execute(ViewExecutable $view)`
- `..._pre_render(ViewExecutable $view)`
- `..._post_render(ViewExecutable $view, array &$output, CachePluginBase $cache)`
- `..._query_alter(ViewExecutable $view, QueryPluginBase $query)`
- `..._preview_info_alter(array &$rows, ViewExecutable $view)`

## Notes
- Only `pre_view` receives an explicit `$display_id`; for the others the display is inferred from `$view->current_display`, so the display-scoped variant is dispatched when available.
- Reference parameters are passed through by reference, so you can alter args/output/rows.
- `field_views` / `plugin` hooks are scaffolded in code but not dispatched (no reliable way to derive the view/display ID).
