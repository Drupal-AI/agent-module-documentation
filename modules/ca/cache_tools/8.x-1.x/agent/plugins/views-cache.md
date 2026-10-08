<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block sanitizing & the ViewsCache plugins

Two mechanisms strip generic cache metadata and add precise `*_pub` tags: the cache-wise block view
builder, and two ViewsCache plugins. Both delegate to `Service\CacheSanitizer` (service
`cache_tools.cache.sanitizer`, args `@cache_tools.cache.invalidator`, `%cache_tools%`).

## Block sanitizing — `CachewiseBlockViewBuilder`

`cache_tools_entity_type_alter()` sets the `block` entity's view builder to
`Drupal\cache_tools\CachewiseBlockViewBuilder` (extends core `BlockViewBuilder`). It sanitizes twice:
- `viewMultiple()` — after `parent::viewMultiple()`, calls `cacheSanitizer->sanitize($block, $build[id])`
  for each block.
- `preRender()` (static) — re-sanitizes after `parent::preRender()` so a views block cannot re-add
  undesired metadata late (uses a static-cached sanitizer service).

`CacheSanitizer::sanitize()` only acts on blocks whose id is a key under `sanitize.block`
(`array_key_exists` on `sanitize[block]`). `sanitizeBuild()` strips `#cache.contexts` / `#cache.tags` on
both `$build` and `$build['content']`, applying the per-block `contexts`/`tags` include/exclude options.

## `CacheSanitizer` filtering rules

- `sanitizeCacheableContexts($contexts, $options)` and `sanitizeCacheableTags($tags, $options)` start from
  `sanitize.defaults.contexts` / `.tags`.
- `filterCacheableMetadata($filter, $metadata, $options)`: `options.include` is `array_merge`d into
  `$metadata` (kept), `options.exclude` is `array_merge`d into `$filter` (also stripped), result is
  `array_diff($metadata, $filter)`.
- Deprecated pass-throughs (`getPublishedEntityCacheTag`, `getPublishedEntityTypeCacheTag`,
  `invalidatePublishedEntity`) exist on `CacheSanitizer` but delegate to `CacheInvalidator` — use the
  invalidator directly.

## ViewsCache plugin 1 — `SanitizedCacheTag`

- Plugin id **`cache_tools_sanitized_cache_tag`**, title "Sanitized cache tag". Extends core
  `views\Plugin\views\cache\Tag`. Selectable per view display under **Advanced → Caching**.
- `getCacheTags()`: `parent::getCacheTags()` + `extractPublishedTagsFromView()`, then run through
  `sanitizeCacheableTags()`.
- `extractPublishedTagsFromView()` inspects the display's **filter** handlers of class
  `views\Plugin\views\filter\Bundle` and **argument** handlers of class
  `node\Plugin\views\argument\Type`; for each bundle value it emits `createTag()` →
  `"{entity_type}_{bundle}_pub"`. If none found, falls back to
  `getPublishedEntityTypeCacheTag($view->getBaseEntityType())` (e.g. `node_pub`).
- **Auto-invalidated**: the tags it places match those `CacheInvalidator` invalidates on entity ops, so no
  extra code is needed (provided the bundle is listed in `invalidate`).

## ViewsCache plugin 2 — `SanitizedCacheFieldTag`

- Plugin id **`cache_tools_sanitized_cache_field_tag`**, title "Sanitized cache field tag". Extends
  `SanitizedCacheTag`; `usesOptions = TRUE`. Extra ctor deps: `entity_type.manager`,
  `entity_field.manager`, `current_route_match`.
- `buildOptionsForm()` adds a **Field** select, populated from every node bundle's field definitions that
  have a target bundle (`getTargetBundle()`). This is a Views admin options form — reachable only by users
  who can edit that view (Views UI access); not an anonymous surface.
- `createTag()` appends `:{field}` and, by matching a view **argument** whose `relationship` equals the
  chosen field and reading `$this->view->args[$arg_index]`, appends `:{arg_value}` →
  `"{type}_{bundle}_pub:{field}:{value}"`. If it cannot fully build the tag it returns `''` (empty) rather
  than a too-general tag.
- **NOT auto-invalidated**: the plugin only *places* the field tag; you must invalidate it yourself (e.g.
  via `CacheInvalidator::invalidatePublishedEntityFields()` driven by a matching `invalidate` field rule,
  or a custom module). The plugin's own help text and the field description say as much.

## Operating

Configure per view: edit the view → *Advanced* → *Caching* → choose "Sanitized cache tag" (or the field
variant, then pick a field). Ensure the relevant bundles/fields are declared in the `cache_tools`
parameter's `invalidate` map for automatic invalidation. `drush cr` after parameter changes.
