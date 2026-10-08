# Services & programmatic API

## `block_ajax.ajax_blocks` — `Drupal\block_ajax\AjaxBlocks`

Constructor deps: `config.factory`, `current_user`, `cache_tags.invalidator`, `date.formatter`,
`plugin.manager.block`, `renderer`, `entity_type.manager`, `block_ajax.block_view_builder`,
`current_route_match`.

| Method | Returns | Purpose |
|--------|---------|---------|
| `isAjaxBlock(BlockPluginInterface $block)` | bool | TRUE when `configuration['block_ajax']['is_ajax']` is set. Used by the block build/view alters. |
| `invalidateAjaxBlocks()` | void | Invalidates the `block_ajax` cache tag. Called on block save. |
| `getMaxAgeOptions()` | array | Interval → label options for the max-age select. |
| `getAjaxDefaults(array $blockConfig)` | array | Builds the `$.ajax` options (`type`, `timeout`, `async`, `cache`, `dataType`) attached as `drupalSettings.block_ajax.config`. |
| `getCurrentNodeId()` / `getCurrentUserId()` / `getCurrentTaxonomyTermId()` | int | Reads the current route entity id (0 if none) — feeds the context arguments. |
| `hasAccess(string $permission = 'administer ajax blocks')` | bool | Thin `currentUser->hasPermission()` wrapper. |

```php
$svc = \Drupal::service('block_ajax.ajax_blocks');
if ($svc->isAjaxBlock($blockPlugin)) { $svc->invalidateAjaxBlocks(); }
```

## `block_ajax.block_view_builder` — `Drupal\block_ajax\BlockViewBuilder`

`build(string $id, array $configuration = [], bool $wrapper = TRUE): array` — instantiates the block
plugin by id, injects runtime contexts for `ContextAwarePluginInterface` plugins, builds inside a
`#theme => 'block'` wrapper and attaches cache metadata + keys. Used by the controller's
config-entity render path.

## `block_ajax.route_subscriber` — `AjaxBlockRouteSubscriber`

Event subscriber that re-points `block.admin_display`'s controller to
`AjaxBlockListController::listing` (which flags Ajax-enabled blocks in the list).

## Refreshing a block from server or client

- **JS Ajax command:** `Drupal\block_ajax\Ajax\AjaxBlockRefreshCommand` (implements
  `CommandInterface`). Constructed with a CSS `$selector`; its `render()` emits
  `{command: 'AjaxBlockRefreshCommand', selector}`. The client command handler triggers the
  `RefreshAjaxBlock` DOM event on that selector, which re-fetches the block.

  ```php
  $response = new \Drupal\Core\Ajax\AjaxResponse();
  $response->addCommand(new \Drupal\block_ajax\Ajax\AjaxBlockRefreshCommand('#my-ajax-block'));
  ```

- **Pure client side:** `jQuery('[data-block-ajax-id]').trigger('RefreshAjaxBlock');`

## Trusted pre-render callback

`Drupal\block_ajax\AjaxBlockViewBuilder::preRender()` (a `TrustedCallbackInterface`) is an
alternative pre-render for the block-view alter (sets `#block_ajax_id`, attaches the library and
per-block `drupalSettings`). Note the active `block_ajax_block_view_alter()` uses an inline closure
rather than this class.
