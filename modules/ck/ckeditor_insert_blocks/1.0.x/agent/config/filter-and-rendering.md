<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config: the display-time filter, the fetch route, and rendering

## The `insert_block` filter — enable it for live re-rendering
`src/Plugin/Filter/InsertBlockFilter.php`, id `insert_block`, `TYPE_TRANSFORM_IRREVERSIBLE`. Enable
it on the **same text format** (`admin/config/content/formats/manage/<format>`, "Insert block"). If
you do not, the field shows only the insert-time snapshot — the block is never re-rendered per
viewer and never picks up later edits.

`process($text, $langcode)`:
- If the `Crawler` class is unavailable, it just renders the raw text through an `inline_template`
  and returns — **so the filter needs `symfony/dom-crawler`** (`composer require symfony/dom-crawler`
  on Drupal 10/11/12; Drupal 9 had it in core). Note the `class_exists('Crawler')` check uses the
  unqualified name, while the class is imported as `Symfony\Component\DomCrawler\Crawler` — the guard
  is effectively always false, so the crawler branch runs whenever the class is autoloadable.
- Builds a `Crawler($text)`, XPaths `//div[contains(@class,"insert-block") and @data-block-id]`, and
  for each node: reads `data-block-id`, calls `renderBlock($currentUser, $blockId)`, strips the div's
  children and appends the rendered block as an XML fragment (`appendXML`); collects `data-library`
  values.
- `renderBlock()` = `pluginManagerBlock->createInstance($delta, [])`, then **`$plugin_block->access($currentUser)`**
  (viewing user) before `build()` + `renderer->renderInIsolation()`. Views blocks with no results
  return FALSE (empty).
- Attaches `array_unique($lib)` libraries and re-renders in isolation.

## The fetch route/controller
`ckeditor_insert_blocks.get_block_content` → `/get-block-content/{block_id}` (default `block_id: ''`),
`_permission: 'access content'`. `InsertBlockController::showBlockContent()` returns `''` for an empty
id, else `renderBlock($currentUser, $block_id)` (same access-checked instantiate → build → render as
the filter) as a raw `Response`. This is the endpoint the editor JS calls at insert time.

## Config storage
Per-format editor config under the CKEditor 5 plugin id `ckeditor_insert_blocks_blocks`; schema
`ckeditor5.plugin.ckeditor_insert_blocks_blocks` = a `blocks` sequence of strings (checked block
plugin ids). No standalone config entity, no exported default config.

## Caching behaviour to be aware of
The filter renders each block with `renderInIsolation()`, which **does not bubble** the block's cache
tags, cache contexts, or max-age into the `FilterProcessResult`. Practical consequences:
- Block edits are not reflected until caches are cleared (the module's own filter tip says so).
- Because per-viewer cache **contexts** from the block (and its access result) are not merged into the
  host field's cacheability, a block whose output/access varies by user relies entirely on whatever
  contexts the host entity already carries. Treat inserted blocks that vary by viewer with care and
  verify the rendered field varies as expected before trusting it in cached output.
