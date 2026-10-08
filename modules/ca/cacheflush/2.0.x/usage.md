CacheFlush lets you build reusable "presets" that clear exactly the cache bins and cache-clearing functions you choose, instead of always flushing everything — giving fine-grained, repeatable cache clears for development and production.

---

The base `cacheflush` module provides the cache-clearing engine and a couple of ready-made routes; the actual preset-building UI lives in the `cacheflush_ui` submodule and the preset storage in the required `cacheflush_entity` submodule. Its controller/service `cacheflush.api` (`CacheflushApi`) exposes `clearAll()` (wraps `drupal_flush_all_caches()`), `clearById()` / `clearPresetCache()` (run a preset's stored functions), and low-level helpers `clearBinCache($service_id, $function = 'deleteAll', $cid = NULL)`, `clearStorageCache($type)` (PhpStorage, e.g. Twig), `clearModuleCache()`, and `clearCacheTags($tags)`. `getOptionList()` builds the catalog of clearable things by combining every registered cache bin (`cache_bins` container parameter) with options contributed via `hook_cacheflush_tabs_options()` — the base module itself contributes `static`, `asset`, `kernel`, `twig`, `plugin`, `module`, and `router` options. A preset is a `cacheflush` content entity whose `data` stores the selected options as callable `#name`/`#params` function definitions; clearing a preset iterates and calls them. Two routes ship out of the box: `/admin/cacheflush/clear/all` and `/admin/cacheflush/clear/{cacheflush}`, both gated by the `cacheflush clear cache` permission, and the module invokes `hook_cacheflush_before_clear()` / `hook_cacheflush_after_clear()` around each preset run and logs clears. It provides no config schema, no Drush (see `cacheflush_drush`), and no plugin types.

---

- Clear only the render cache after changing a template, without a full cache rebuild.
- Build a "front-end dev" preset that flushes Twig, asset, and render caches only.
- Create a preset that rebuilds the router after adding routes, skipping unrelated bins.
- Give editors a one-click "clear page cache" preset via the admin menu.
- Clear a specific contrib module's cache bin without touching core caches.
- Provide a "clear all" link at `/admin/cacheflush/clear/all` for quick full flushes.
- Run a preset by id at `/admin/cacheflush/clear/{id}` from a bookmark or script.
- Reduce wait time on large sites by flushing just the caches that changed.
- Limit who can clear caches with the `cacheflush clear cache` permission.
- Log every full cache clear (with the username) to the Drupal log.
- Compose a preset mixing core bins and custom cache-clearing functions.
- Wipe the Twig PHP storage cache to pick up template changes fast.
- Invalidate specific cache tags as part of a preset (with cacheflush_advanced).
- Rebuild module/theme data via a preset when code changes.
- Reset all static caches within a request-scoped clear.
- Offer separate presets for production vs development cache strategies.
- Trigger a preset from cron (with cacheflush_cron) on a schedule.
- Clear caches from the command line by preset id (with cacheflush_drush).
- Expose frequently used presets as items under the Cacheflush admin menu.
- Let other modules add their own clearable options via hook_cacheflush_tabs_options().
- React to preset clears with hook_cacheflush_before_clear()/after_clear() (e.g. warm caches).
- Clear the plugin definition caches selectively after adding a plugin.
- Standardise cache-clear procedures across a team as named presets.
- Avoid `drush cr` overkill by clearing only the bin you actually changed.
