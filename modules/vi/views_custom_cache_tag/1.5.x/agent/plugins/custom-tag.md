<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `custom_tag` Views cache plugin

Single plugin provided by the module.

- **Type:** Views cache plugin (`@ViewsCache`)
- **id:** `custom_tag`
- **title:** "Custom Tag based"
- **class:** `Drupal\views_custom_cache_tag\Plugin\views\cache\CustomTag`
- **extends:** `Drupal\views\Plugin\views\cache\Tag` (core's tag-based cache plugin)
- **help:** "Tag based caching of data. Caches will persist until any related cache tags are invalidated."

It is a Views *cache* plugin, so it appears in the **Caching** slot of a view display, not as a
filter/field/style. `$usesOptions = TRUE`, so it has an options form.

## Options (`defineOptions()`)
| Option | Default | Meaning |
|---|---|---|
| `custom_tag` | `''` | Newline-separated list of cache tags to attach to the view. Twig-tokenizable. |
| `custom_tag_output_lifespan` | `Cache::PERMANENT` (`"0"`) | Rendered-output TTL: `Cache::PERMANENT` = tag-based only; a preset second count; or `custom`. |
| `custom_tag_output_lifespan_expression` | `''` | `strtotime()` expression used when lifespan == `custom`. |

Config schema (`views.cache.custom_tag`): `custom_tag` (string), `custom_tag_output_lifespan`
(string), `custom_tag_output_lifespan_expression` (string).

## How the tags are computed (`getCacheTags()`)
1. Start from `parent::getCacheTags()` (the standard Views tag set).
2. For every entity type the view's query touches, **remove** that entity type's *list* cache
   tags (`getListCacheTags()`, e.g. `node_list`). This is the key difference from core Tag: the
   view is no longer invalidated by every save of that entity type.
3. Tokenize the `custom_tag` string via `$this->view->getStyle()->tokenizeValue(...)`, split on
   newlines, `trim()` + drop empties.
4. `Cache::mergeTags($custom_tags, $tags)` → the final tag set.

So the cached results/output persist until one of **your** custom tags (or a remaining non-list
tag) is invalidated.

## Lifespan / expiry
- `getLifespan()` returns `Cache::PERMANENT` for tag-only, the selected seconds, or
  `strtotime(expression) - REQUEST_TIME` for a `custom` expression.
- `cacheExpire()` / `cacheSetMaxAge()` / `getDefaultCacheMaxAge()` derive the results-cache
  expiry and the rendered max-age from that lifespan.
- `validateOptionsForm()` rejects a `custom` lifespan whose expression is empty or not in the
  future.

## `summaryTitle()` (what the Views UI shows)
- Tag-only → "Custom Tag"
- `custom` expression → "Custom tag (until %expression)"
- Preset seconds → "Custom tag (%ttl sec lifespan)"

## Debug hook
`cacheGet('results')` on a miss, when the state flag `views_custom_cache_tag.execute_debug` is
TRUE, prints a message naming the view/display/args and its cache tags — useful to see which
views actually execute (miss) vs. serve from cache. See
[../api/cache-invalidation.md](../api/cache-invalidation.md).
