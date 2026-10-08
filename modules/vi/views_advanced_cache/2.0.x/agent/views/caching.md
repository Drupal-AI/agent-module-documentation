<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Caching — the `advanced_views_cache` Views cache plugin

The module contributes exactly one Views cache plugin,
`Drupal\views_advanced_cache\Plugin\views\cache\AdvancedViewsCache` (`extends CachePluginBase`,
`#[ViewsCache(id: 'advanced_views_cache', title: 'Advanced Caching')]`, `usesOptions = TRUE`). It
replaces core's *Tag based* / *Time based* Views caching with one plugin that lets you edit the
display's cache **tags**, **contexts**, and **max-age / results lifetime** from the Views UI. Select
it per display under **Advanced → Other → Caching**.

## Options form (three fieldsets)

**Cache Tags** (`buildCacheTagOptions()`)
- *Also apply modifications to each views row* → `cache_tags_for_row` (checkbox).
- *Cache tags to add* → `cache_tags` (textarea, one tag per line). Pre-filled with the view's
  default list tags (e.g. `node_list`) minus `extensions` and `config:views.view.<id>`.
- *Cache tags to exclude* → `cache_tags_exclude` (exact-match removal).
- *Cache tags to exclude via regular expression* → `cache_tags_exclude_regex` (e.g. `/node\:[0-9]+/`).
- A token list is shown: `[current-user:uid]`, and per-argument `{{ arguments.NAME }}` /
  `{{ raw_arguments.NAME }}`.

**Cache Contexts** (`buildCacheContextOptions()`)
- *Cache contexts to add* → `cache_contexts`.
- *Cache contexts to exclude* → `cache_contexts_exclude`.

**Max-Age and Results Cache** (`buildLifespanOptions()`)
- *Query results* → `results_lifespan` (+ `results_lifespan_custom` when set to *Custom*): how long
  raw query results are cached.
- *Rendered output* → `output_lifespan` (+ `output_lifespan_custom`): how long rendered HTML is
  cached; this value also becomes the view's **max-age** (`getDefaultCacheMaxAge()`).
- Preset options: `-1` *Always cache* (→ `Cache::PERMANENT`), `0` *Never cache*, 60s…7d, or *Custom*.
- Validation (`validateOptionsForm()`): custom values must be numeric; **output lifespan must not
  exceed results lifespan**; each exclude regex must compile (`@preg_match`).

Textareas are normalized to arrays in `processTextboxIntoArray()` (split on newlines, `trim`,
drop empties). `submitOptionsForm()` flattens the three fieldsets back onto `cache_options`.

## Runtime behaviour

- `getCacheTags()`: base = configured `cache_tags` (or the view's default tags when empty); merges
  the tags of any display plugin implementing `CacheableDependencyInterface`; runs each tag through
  `tokenizeValue()` + `token->replace()` (so `{{ arguments.* }}` / `[current-user:uid]` resolve);
  merges parent tags; then `excludeCacheTags()` strips exact and regex matches.
- `getRowCacheTags(ResultRow $row)`: identical add/exclude logic, applied **only** when
  `cache_tags_for_row` is TRUE; otherwise returns the parent row tags unchanged.
- `alterCacheMetadata(CacheableMetadata $m)`: `addCacheContexts($cache_contexts)` then, for the
  exclude list, `setCacheContexts(array_diff($existing, $cache_contexts_exclude))`.
- `cacheExpire($type)` / `cacheSetMaxAge($type)`: convert the lifespan to a cutoff time / max-age;
  `-1` means permanent (no expiry).
- `summaryTitle()`: shows counts of tags/contexts and the results/output lifespans, or "Always cache".

**Important:** the module does **not** invalidate the custom tags you add — you must invalidate them
yourself (e.g. in a `hook_ENTITY_TYPE_presave()` calling `Cache::invalidateTags()`).

## Recipe: replace the broad `node_list` tag with a bundle-specific one
Goal: stop a node listing from being invalidated every time *any* node is saved.
- *Cache tags to add*: `my_custom:node_list:page`
- *Cache tags to exclude*: `node_list`
- In code, invalidate `my_custom:node_list:<bundle>` on save:
  ```php
  function my_module_node_presave(NodeInterface $node) {
    Cache::invalidateTags(['my_custom:node_list:' . $node->getType()]);
  }
  ```

## Recipe: cache a list "forever", ignoring per-node edits
Add `my_custom:node_list:page`, exclude `node_list`, and add exclude-regex `/node\:[0-9]+/` to strip
the per-row `node:NID` tags. The view then survives node edits until max-age or a manual flush, but
your custom tag still invalidates it on demand.

## Recipe: scope a REST/pager view's `url.query_args` context
On a `rest_export`/page display that varies by too many query args, add only the args that matter
(`url.query_args:page`, `url.query_args:items_per_page`, `url.query_args:offset`,
`url.query_args:my_custom_filter`) and **exclude** the blanket `url.query_args`. Improves HIT rate.

## Cache-context safety (read before excluding any context)
`cache_contexts_exclude` removes **any** context with no guard. Never remove a context an
access-varying view depends on:
- Views filtered by ownership, group/organic-group membership, or role, or subject to **node
  access**, vary by the viewer. The contexts that capture that (`user`, `user.permissions`,
  `user.roles`, `user.node_grants:view`, `user.is_anonymous`) must **stay**.
- If one of those is removed, cached results from an earlier viewer can be reused for later viewers,
  so each account no longer necessarily gets its own rows. Keep those contexts on any access-varying
  view; excluding a **tag** only risks stale content, but excluding a needed access **context**
  changes which results a viewer receives.
- Always verify with two accounts that should see different rows, requesting in both orders, and
  confirm each sees only their own.
