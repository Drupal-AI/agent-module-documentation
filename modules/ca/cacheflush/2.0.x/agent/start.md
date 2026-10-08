# CacheFlush — agent index

Build reusable **presets** that clear exactly the caches you pick. The base module is the
clear engine + two routes; the UI is in `cacheflush_ui`, storage in the required
`cacheflush_entity`. `configure` route = `cacheflush.presets` (`/admin/cacheflush`).

Core facts:
- Service/controller **`cacheflush.api`** (`Drupal\cacheflush\Controller\CacheflushApi`).
- Ready routes: `/admin/cacheflush/clear/all` (`clearAll`) and
  `/admin/cacheflush/clear/{cacheflush}` (`clearById`) — both need permission
  **`cacheflush clear cache`** (this module's only permission).
- A **preset** is a `cacheflush` content entity; its `data` holds selected options as callable
  `#name`/`#params` function definitions. Clearing a preset runs them in order.
- Option catalog = every cache bin (`cache_bins` param) + `hook_cacheflush_tabs_options()`
  contributions. Base module adds: `static`, `asset`, `kernel`, `twig`, `plugin`, `module`, `router`.

Submodules (documented separately under `../modules/`): `cacheflush_entity` (the entity, **required**),
`cacheflush_ui` (preset admin UI + the granular permissions), `cacheflush_advanced` (custom cid /
cache-tag clears), `cacheflush_cron` (run presets via ultimate_cron), `cacheflush_drush`
(`drush cf` — note: broken on this site's Drush, see its docs).

Docs:
- **Presets, the clear routes, the option→functions model, building a preset** →
  [configure/presets.md](configure/presets.md)
- **`cacheflush.api` service methods** → [api/service.md](api/service.md)
- **Hooks: `cacheflush_tabs_options`, `cacheflush_before_clear`, `cacheflush_after_clear`** →
  [hooks/hooks.md](hooks/hooks.md)
