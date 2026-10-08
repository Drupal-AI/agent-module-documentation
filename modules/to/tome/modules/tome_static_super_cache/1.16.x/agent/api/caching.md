<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Static Super Cache — caching behavior

No config, no permissions, no Drush command. Everything is service decoration + a Views plugin.

## Decorated services (`tome_static_super_cache.services.yml`)
- `cache.tome_static` → `SuperStaticCache` — ignores ordinary full-cache-clears so the Tome
  Static cache bin is NOT wiped by `drush cr` / "Clear all caches". It is only cleared on a
  genuine full rebuild, flagged via `$GLOBALS[SuperStaticCache::REBUILD_KEY]` (set by
  `hook_cache_flush()`) / `FULL_REBUILD_KEY`.
- `cache_tags.invalidator` → `TomeStaticSuperCacheTagsInvalidator` — drops list-tag
  invalidations that would needlessly clear caches.

## Views cache plugin — "Smart tag based"
- Id: **`tome_static_super_cache_smart_tag`** (`@ViewsCache`), class `Plugin\views\cache\SmartTag`.
- Assign it as a display's caching plugin (Views UI → Advanced → Caching, or in the display's
  `display_options.cache.type`). It avoids list cache tags: on `hook_entity_insert` /
  `hook_entity_update` the module partially executes each View that uses this plugin, adding a
  WHERE on the saved entity's id, and only if the entity would appear in results clears that
  View's own cache tag (`$cache->getTagForView()`).

## Forcing a genuine full rebuild
- UI: "Fully clear caches" button added to `/admin/config/development/performance`
  (`hook_form_system_performance_settings_alter`) — sets `FULL_REBUILD_KEY` then
  `drupal_flush_all_caches()`.
- Code: set `$GLOBALS[SuperStaticCache::FULL_REBUILD_KEY] = TRUE;` then `drupal_flush_all_caches();`.
- `tome:super-cache-rebuild` / `tscr` (`TomeSuperCacheRebuildCommand`) does the same, but it is
  tagged only `console.command`/`drupal.command` (Drupal Console), **not** `drush.command`, so on
  a Drush-only site it is not available — use the button instead.
