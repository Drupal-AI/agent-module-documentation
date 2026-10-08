<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attachment & renderer internals

## Mapping lookup
`dynamic_library_loader_get_library_mappings()` (`.module`) reads
`dynamic_library_loader.settings:entries`, keeps only entries with `enabled` truthy
and non-empty `rows`, and flattens their rows into a flat list of
`{context_type, context, theme, library}` mappings. Every preprocess/pre-render hook
calls this helper and iterates the mappings, appending `"{theme}/{library}"` to
`#attached['library']` on a match. No config caching beyond core's config cache; the
helper runs on each preprocess call.

## Per-context matching (`.module`)
- `hook_preprocess_node` — matches `content_type` against `$node->bundle()`; and
  `node_id` against `$node->id()` where `context` is a comma-separated list (trimmed,
  strict string compare via `in_array(..., TRUE)`).
- `hook_preprocess_paragraph` — matches `paragraph_type` against the paragraph bundle;
  and `paragraph_id` against `$paragraph->id()` (comma-separated list).
- `hook_preprocess_block` — only for `#base_plugin_id === 'block_content'`; matches
  `block_type` against the block content bundle (from
  `elements.content.#block_content`).
- `hook_preprocess_taxonomy_term` — matches `taxonomy_term` against `$term->bundle()`
  (the vocabulary machine name).
- `hook_views_pre_render(ViewExecutable $view)` — matches `view` when `context` equals
  either `$view->id()` or `"{$view->id()}:{$view->current_display}"`; attaches to
  `$view->element['#attached']['library']`.

The attached value is a standard Drupal library reference string; the library must
already be declared by the named theme/module (this module does not define or generate
libraries, and does not emit raw markup). Because attachment happens during preprocess,
the assets join normal aggregation rather than loading after the global aggregate.

## CSS/JS cache-bust renderer override
Two service providers, `DynamicLibraryLoaderServiceProvider` and
`AssetCacheBustServiceProvider` (`::alter(ContainerBuilder)`), both re-class the core
services `asset.css.collection_renderer` → `AssetCachingCSSCollectionRenderer` and
`asset.js.collection_renderer` → `AssetCachingJSCollectionRenderer` (the two providers
are redundant; the last to run wins, both set the same classes).

`AssetCachingCSSCollectionRenderer::render()` / `AssetCachingJSCollectionRenderer::render()`
call `parent::render()`, then read `\Drupal::state()->get('system.css_js_query_string', '0')`
and append it as a query-string parameter (`?` or `&` separator) to each element's
`href` / `src` — but only for **local** assets (`UrlHelper::isExternal()` false), so
external/CDN URLs are left untouched. The query value comes from core state, not from
user input.
