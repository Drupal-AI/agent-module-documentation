# Gutenberg Content Embed — endpoints & block processor

## JSON routes (editor-facing)

Both require permission `use gutenberg` and return `_format: json`
(`ContentController`, `src/Controller/ContentController.php`):

| Route | Path | Returns |
|---|---|---|
| `gutenberg_content_embed.search` | `GET /editor/search-content/{type}/{search}` | Array of `{id, title}` for published nodes of `{type}` whose title CONTAINS `{search}`, ordered by created desc. Entity query uses `accessCheck(TRUE)`. Optional `?per_page=N` (default 20). |
| `gutenberg_content_embed.load_single` | `GET /editor/content/load/{nid}/{viewmode}` | Rendered HTML of node `{nid}` in `{viewmode}` (default `default`), only if `$node->access('view')`; otherwise a "cannot view" / "unable to render" message. |

## Block processor contract

Service `gutenberg_content_embed.block_processor_drupal_content` = `DrupalContentProcessor` implements
`Drupal\gutenberg\BlockProcessor\GutenbergBlockProcessorInterface`, tagged
`gutenberg_block_processor` (priority 50). `processBlock(array &$block, &$block_content, $bubbleable_metadata)`:

- reads `$block['attrs']['nodeId']` (logs an error and returns if missing) and `attrs.viewMode` (default `default`),
- loads the node, and if `$node->access('view')` renders it via the view builder,
- wraps output in a container with classes `content-embed` + `Html::getClass(bundle-viewmode)` and, when
  `attrs.align` is set, an alignment class.

To add your own embeddable-content behavior, register another `gutenberg_block_processor`-tagged service
implementing the same interface. This module defines **no** plugin types, permissions, or Drush commands of
its own.
