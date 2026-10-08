<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Tools configuration — the `cache_tools` parameter

There is **no admin UI and no config entity**. All settings live in the service-container **parameter
`cache_tools`**, declared with defaults in `cache_tools.services.yml` and injected into both services as
`%cache_tools%`. To change behavior, redeclare the whole `cache_tools` parameter in a site-level
`services.yml` (e.g. `sites/default/services.yml`) or an install profile's `<profile>.services.yml`, then
rebuild caches. The shipped defaults reference example content types (`article`, `recipe`, …) — treat them
as a template and replace with your own.

## Install / enable

`composer require drupal/cache_tools` (pulls `drunomics/service-utils`), then `drush en cache_tools`.
Ensure core **block** and **views** are enabled. Override the parameter, then `drush cr`.

## Two independent sections: `invalidate` and `sanitize`

```yaml
parameters:
  cache_tools:
    invalidate:            # used by CacheInvalidator (published-entity tags)
      node:
        - article          # bundle → precise entity/bundle tag participates
        - article:field_author          # bundle:field → field-value tag
        - article:field_topics:parents  # bundle:field:parents → taxonomy parents too
        - page
      taxonomy_term:
        - topics
    sanitize:              # used by CacheSanitizer (strip metadata)
      defaults:
        contexts: [route, url, url.query_args]   # stripped from every sanitized build
        tags: [node_list, taxonomy_term_list]    # stripped from every sanitized build
      block:               # per-block overrides, keyed by block config entity id
        food_theme_footer:
          contexts:
            include: [route.menu_active_trails:footer]
        exposedform_searchpage:
          contexts:
            exclude: [url.query_args]
```

### `invalidate` map (entity type → list of rules)

Each key is an entity type id; each list item is one of:
- `bundle` — the bundle participates in `entitytype_entitybundle_pub` invalidation.
- `bundle:field_name` — also emit/invalidate `entitytype_entitybundle_pub:field_name:value`.
- `bundle:field_name:parents` — for `taxonomy_term`-reference fields, also invalidate all ancestor tids
  (`CacheInvalidator::taxonomyGetParents()` → `loadAllParents()`).

Notes from source (`CacheInvalidator`): `invalidatePublishedEntity()` early-returns unless the entity type
key exists **and** `in_array($entity->bundle(), ...)` — so a plain `bundle` string must be present for the
`*_pub` tags to fire. Field rules are parsed by `getPublishedEntityFieldsCacheTags()` via
`explode(':', ...)`, requiring `count($parts) >= 2` and `$parts[0] == $bundle`.

### `sanitize.defaults`

`contexts` / `tags` here are the base sets stripped from any build the sanitizer touches. Consumed by
`CacheSanitizer::sanitizeCacheableContexts()` / `sanitizeCacheableTags()` (both read
`$settings['sanitize']['defaults'][...]` with `?? []`).

### `sanitize.block` (per-block, keyed by block entity id)

For the `block` entity type, `CacheSanitizer::sanitize()` looks up `sanitize.block.<block_id>`; only listed
blocks are sanitized. Per-block options:
- `contexts.include` / `tags.include` — added back **before** diffing (i.e. these override defaults,
  effectively kept — `array_merge` into the metadata, then `array_diff` removes the filter set).
- `contexts.exclude` / `tags.exclude` — added to the filter set so they are additionally stripped.

`filterCacheableMetadata()` logic: `include` is merged into the metadata, `exclude` is merged into the
strip-list, then `array_diff(metadata, strip-list)` is returned.

> Caveat: `CacheSanitizer::sanitize()` reads `$this->settings['sanitize'][$entity->getEntityTypeId()]`
> (e.g. `sanitize.block`) and calls `array_key_exists()` on it — if you enable the module and remove the
> `sanitize.block` key entirely while blocks still render through the cache-wise builder, expect a
> missing-key notice. Keep at least an empty `block: {}` under `sanitize` when overriding.

## Rebuild

Parameter changes require a container rebuild: `drush cr`.
