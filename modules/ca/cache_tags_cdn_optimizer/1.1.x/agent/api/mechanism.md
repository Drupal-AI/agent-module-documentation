<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism — tag rewrite (response) & selective invalidation (hooks)

Two halves, both operating only on Drupal core cache tags. The module never contacts a CDN or any
external service itself; downstream purge/CDN tooling consumes the tags it produces.

## SettingsTrait (`src/SettingsTrait.php`)

- `$SETTINGS = 'cache_tags_cdn_optimizer.settings'`, `$CUSTOM_TAG_SUFFIX = 'reference'`,
  `$PATH_CACHE_TAG_PREFIX = 'url'`, `$DEFAULT_EVENT_PRIORITY = 1` (edit to re-order the subscriber
  relative to other response subscribers).
- `convertPathToTag(string $url)`: `strtr()` of a path into a tag-safe string
  (`/`→`:`, `?`→`~q~`, `&`→`~and~`, `=`→`~eq~`, `#`→`~hash~`, and `, {}()` + space → `_`), prefixed
  with `url`. e.g. `/my-page` → `url:my-page`.

## Response rewrite — `KernelResponseEventSubscriber::onKernelResponse`

Subscribes to `KernelEvents::RESPONSE` at priority 1. Steps:

1. Main request only; response must expose `getCacheableMetadata()` with `getCacheTags()`; bail if
   no cache tags.
2. If `path_cache_tag` on and the path length > 1, append `convertPathToTag($request->getPathInfo())`
   via `setCacheTags()` (deliberately set-not-add because a 404 returns early).
3. Resolve the "current" entity from request attributes `node` then `taxonomy_term`; if none, return
   (leaving tags as-is apart from the path tag).
4. Build a match pattern from the two `replace_*` toggles (`/^(node|taxonomy_term):(\d+)$/` etc.).
5. Blocklist pass: for any blocklist entry ending in `*`, keep only tags NOT starting with the
   prefix; then also skip any tag exactly in the blocklist.
6. For each remaining tag matching the pattern: if it is the currently-viewed entity, keep it
   verbatim; otherwise rewrite to `<type>:reference:<id>`. Non-matching tags pass through.
7. Append `<currentType>:<bundle>:purge_all` for the current entity.
8. `setCacheTags($newCacheTags)` back on the response.

Net effect: the page keeps normal invalidation for the entity it is *about*, but referenced
entities carry `:reference:` tags that core will not purge on a plain entity save.

## Selective invalidation — hooks in `cache_tags_cdn_optimizer.module`

Each hook grabs config through an anonymous class that `use`s `SettingsTrait`.

- **`hook_entity_insert`**:
  - `path_alias` insert + `path_cache_tag` on → invalidate `convertPathToTag($alias)` (purges a
    404 cached before the alias existed).
  - node/taxonomy insert with its replacement toggle on → for each *configured* field that holds
    entity references, invalidate the referenced entities' plain `type:id` tags.
- **`hook_entity_update`** (node/taxonomy only):
  - `path_cache_tag` on → invalidate the entity's own path tag.
  - Requires the type's replacement toggle on and configured fields for the bundle.
  - Compares each configured field's `$entity->original` value vs current, via `_normalizeFieldValue()`
    (flattens single/multi `value`/`target_id` arrays) with per-type casting (bool/decimal/integer).
    A differing field type, or any changed value, sets `$hasChanges` (in `debug_mode` it collects the
    full diff and logs it; otherwise it breaks on the first change).
  - If changed → `Cache::invalidateTags(['<type>:reference:<id>'])` — purging exactly the pages that
    reference this entity, nothing more.
- **`hook_entity_delete`** (node/taxonomy, replacement toggle on): invalidates both `type:id` and
  `type:reference:id`.

`_normalizeFieldValue()` is a module-level helper (not a hook) used only by the update comparison.

## Operating notes

- With both replacement toggles off and `path_cache_tag` off, the module does nothing.
- The manual-invalidate button on the settings form (`SettingsForm::invalidateCacheTagAjax`) is the
  only other path that calls `Cache::invalidateTags()`, gated by the form's
  `administer site configuration` route.
- Pair with a Cache-Tags-aware purge layer; on its own the module only marks tags for invalidation
  through core's cache-tag invalidator.
