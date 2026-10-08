<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins: Views filter + Search API processor

The module ships two plugin instances that share one service. Both do the same thing — drop the
site's front-page node from a result set — one for Views queries, one for Search API indexing.

## Shared service: `views_filter_not_front.frontpage_node`

- Class: `Drupal\views_filter_not_front\Service\FrontPageNode` (`src/Service/FrontPageNode.php`).
- Constructor args (`views_filter_not_front.services.yml`): `@config.factory`, `@router.no_access_checks`.
- Public API: `getFrontpageNode(): \Drupal\node\Entity\Node|false`.
- Mechanism (resolved once, in the constructor): reads `system.site:page.front`, then
  `$router->match($frontpageUrl)`. If the matched route carries a `node` upcast to a `Node`, that
  node is cached and returned; otherwise `getFrontpageNode()` returns `FALSE`. Any exception in the
  match also yields `FALSE`.
- Consequence: the front page is resolved through the router, so it works whether `page.front` is
  `/node/N`, a path alias, or any path that resolves to a node route — not just literal `/node/N`.
  If the front page is a view or a non-node route, the result is `FALSE` and both plugins become
  no-ops.

## Views filter plugin `not_front`

- Class: `Drupal\views_filter_not_front\Plugin\views\filter\NotFront` (`FilterPluginBase`),
  `src/Plugin/views/filter/NotFront.php`, annotation `@ViewsFilter("not_front")`.
- Registered by `views_filter_not_front_views_data()` in `views_filter_not_front.views.inc` as
  `node_field_data['not_front_filter']`: title **"Not front page"**, help "if front page is a node",
  `filter => { field: nid, id: not_front }`. In the Views UI it is added under the
  **`node_field_data`** table (label the corpus/UI surfaces as "Exclude frontpage node").
- `init()` (`NotFront.php:48`): sets `$this->value = FALSE`, `$this->operator = "<>"`,
  `$this->no_operator = TRUE`; if a front-page node exists, `$this->value = <front nid>`.
- `canExpose()` returns **FALSE** — the filter cannot be exposed to visitors (there is nothing to
  choose), so it is either applied or not.
- `query()` (`NotFront.php:70`): calls `parent::query()` **only when `$this->value` is truthy**, i.e.
  a front-page node was resolved. That adds `node_field_data.nid <> <front nid>` to the WHERE clause.
  If no front-page node, `query()` does nothing — the filter is a silent no-op.

Config export shape (a filter row on a view display):

```yaml
display.default.display_options.filters.not_front_filter:
  id: not_front_filter
  table: node_field_data
  field: not_front_filter   # the hook_views_data key
  plugin_id: not_front      # the @ViewsFilter id
  # no exposed settings; operator/value are set in init(), not stored
```

## Search API processor `exclude_front_page_node`

- Class: `Drupal\views_filter_not_front\Plugin\search_api\processor\ExcludeFrontPage`
  (`ProcessorPluginBase`), `src/Plugin/search_api/processor/ExcludeFrontPage.php`,
  `@SearchApiProcessor(id = "exclude_front_page_node", stages = { "alter_items" = 0 })`.
- Requires the **Search API** module (`drupal/search_api`) to be installed — it is NOT a dependency
  in `info.yml`, so on a site without Search API this plugin is simply absent. Enable it per index on
  the index's **Processors** tab.
- `supportsIndex()` returns TRUE only if the index has at least one datasource whose entity type is
  `node`; otherwise the processor is not offered.
- `alterIndexedItems(array &$items)`: for each item, `getOriginalObject()->getValue()`; if it is a
  `NodeInterface` and its id equals the front-page node id (from the shared service), the item is
  `unset()` from `$items` so it is never indexed.
- Service wiring: injected in `create()` via `setNotFrontService()`; `getNotFrontService()` falls
  back to `\Drupal::service('views_filter_not_front.frontpage_node')` if unset.
