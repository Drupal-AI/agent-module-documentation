# The AJAX render endpoint

An Ajax block is placed in its region as a placeholder (`templates/block-ajax-block.html.twig`,
theme hook `block_ajax_block`). The placeholder div carries `data-block-ajax-id`,
`data-block-ajax-plugin-id`, `data-block-ajax-provider`, plus placeholder/spinner data attributes.
The `block_ajax/ajax_blocks` library (`js/ajax_blocks.js`) then requests the real markup.

## Routes (`block_ajax.routing.yml`)

| Route name | Path | Controller method |
|-----------|------|--------------------|
| `block_ajax.ajax_block` | `/block/ajax/{block_id}` | `AjaxBlockController::loadBlock` |
| `block_ajax.ajax_block_node_context` | `/block/ajax/{block_id}/node/{node}` | `AjaxBlockController::loadBlockNodeContext` |
| `block_ajax.ajax_block_taxonomy_term_context` | `/block/ajax/{block_id}/taxonomy-term/{taxonomy_term}` | `AjaxBlockController::loadBlockTaxonomyTermContext` |
| `block_ajax.ajax_block_user_context` | `/block/ajax/{block_id}/user/{user}` | `AjaxBlockController::loadBlockUserContext` |

All four: `requirements._permission: 'access content'`, `options.no_cache: TRUE`,
`_admin_route: FALSE`. The context routes constrain the id to `\d+` and (node) upcast to
`entity:node` / `TermInterface` / `UserInterface`.

## Request parameters

The JS sends (via `$.ajax`, method from `ajax_defaults.method`, default POST):
- `plugin_id` — the block plugin id (from the placeholder's `data-block-ajax-plugin-id`).
- `config` — the full block settings object (`drupalSettings.block_ajax.blocks[blockId]`).

`{block_id}` in the path is either a **block config-entity machine name** or a **block plugin id**.

## What the controller returns

Each method returns an `AjaxBlockResponse` (a plain `JsonResponse`) shaped `{"content": "<html>"}`.
Common flow (`loadBlock` and the three context variants are near-identical):

1. `getBlockConfiguration($request)` = `$request->get('config', [])` run through
   `filterConfiguration()` (top-level scalars passed through `Xss::filter()`).
2. `getBlockInstance($request, $block_id, $configuration)` builds the render array:
   - If `$block_id` loads as a `block` config entity → adds the `block_ajax` cache tag, reads
     `plugin_id` from the request, and renders via `BlockViewBuilder::build($plugin_id, $configuration)`.
   - Otherwise it is treated as a **plugin id**: `blockManager->createInstance($block_id, $configuration)`,
     and the block is built.
3. `renderer->renderRoot()` renders it, then `token->replace()` runs — the context routes pass the
   route entity as token data (`['node' => $node]` / `['term' => $term]` / `['user' => $user]`), so
   `[node:*]` / `[term:*]` / `[user:*]` tokens in the markup resolve against it.
4. Occurrences of `/block/ajax/{block_id}` are stripped from the markup, response max-age is set
   from `config['block_ajax']['max_age']`, and the JSON is returned.

`BlockViewBuilder::build($id, $configuration, $wrapper)` (`src/BlockViewBuilder.php`) instantiates
the plugin, injects runtime contexts for context-aware plugins, renders inside a `#theme => 'block'`
wrapper, and sets cache keys/metadata.

## Client JS behavior (`js/ajax_blocks.js`)

- `Drupal.behaviors.block_ajax` runs once per `[data-block-ajax-id]` element.
- Load mode is chosen from settings: **button** (`load_button` → load on click of
  `#block-ajax-button-<id>`), **refresh** (`refresh_block` → load immediately then `setInterval` at
  `refresh_interval`), or **default** (load once on attach; also re-loads on the `RefreshAjaxBlock`
  DOM event).
- For a context block it appends `/{context_type}/{contextArgument}` to the URL using the attached
  `current_node` / `current_term` / `current_user` id.
- On success it replaces the placeholder's inner HTML with `data.content`, re-attaches behaviors,
  and moves contextual links inside.
