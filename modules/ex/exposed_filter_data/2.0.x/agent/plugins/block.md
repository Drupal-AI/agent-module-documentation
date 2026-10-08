<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: exposed_filters_data_block

Class `Drupal\exposed_filter_data\Plugin\Block\ExposedFilterDataBlock`
(`src/Plugin/Block/ExposedFilterDataBlock.php`). `@Block(id = "exposed_filters_data_block",
admin_label = "Exposed Filters Data")`, extends `BlockBase`, implements
`ContainerFactoryPluginInterface`.

## Install & enable
1. `drush en exposed_filter_data` (requires `views`).
2. Place the block **inside the View whose exposed filters it should describe**, not in a global region
   — it reflects the current request's query string, so it must render on the View's own page.
   Recommended: enable [Views Block Area](https://www.drupal.org/project/views_block_area), add a
   "Global: Block area" to the View **header**, and select the "Exposed Filters Data" block. (It can
   also be placed via Block Layout, but then it must be on the same route as the View.)
3. No settings form — the block has no configuration of its own.

## Dependencies (constructor / `create()`)
- `request_stack` → `getCurrentRequest()` stored as `$this->request`.
- `module_handler` stored as `$this->moduleHandler` (used to invoke the alter hook).

## build() flow (`build()`)
1. `$params = $this->request->query->all()` — ALL current URL query parameters. If empty, returns an
   empty render array (block renders nothing).
2. `$this->moduleHandler->alter('exposed_filter_data_params', $params)` — invokes
   `hook_exposed_filter_data_params_alter()` so sites can rewrite/relabel/remove parameters
   (see `../api/params_alter.md`).
3. Returns a render array: `#theme => 'exposed_filter_data_block'`, `#filters => $params`,
   `#attached['library'] => ['exposed_filter_data/exposed_filter_data.block']`.

## Rendering
- Theme hook `exposed_filter_data_block` (`hook_theme` in `exposed_filter_data.module`) → template
  `templates/block--exposed_filter_data.html.twig`, variable `filters`.
- Template wraps output in `.exposed_filter_data`, prints a "Filtered by:" title, then for each
  parameter with a truthy value a `.filter` row of `key:` / `value` (Twig auto-escapes both). It also
  renders a "Clear Filters" `<form method="post">` posting to `path('<current>')` (a plain reload of
  the current route with no query string; there is no server-side handler — it simply reloads).
- CSS only: `css/exposed_filter_data.css` (borders/spacing). Override the markup by placing your own
  `block--exposed_filter_data.html.twig` in your theme.

## Caching
- `getCacheMaxAge()` returns `0` — the block is never cached, so it always matches the current URL's
  query string. (No cache contexts/tags are declared; max-age 0 makes them moot.)

## Notes / gotchas
- It prints the RAW query keys/values (machine names like `field_category_target_id`, coded values like
  `status=1`). Use the alter hook to produce human-readable labels.
- It reflects the entire query string, not only Views exposed-filter keys — pagers, sort keys, or any
  stray query params also appear unless removed in the alter hook.
