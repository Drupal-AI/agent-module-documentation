<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Debugger (cache_debugger) — agent index

A single admin **config form** that turns Drupal's render/Twig **cache debug output** on or off by
managing `sites/default/services.yml` for you — no manual YAML edit. Dev-only tool. No core module
dependencies. Core requirement `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

- **The form, the config object, the route/permission, and exactly what it does to `services.yml`** →
  [config/settings.md](config/settings.md)

## What it actually is

- One form: `CacheDebugger` (`src/Form/CacheDebugger.php`), extending core `ConfigFormBase`. Form id
  `cache_debugger_settings_form`. **No plugins, no services, no hooks, no Drush, no submodules, no
  config schema, no `.install`.**
- One route: `cache_debugger.settings` at **`/admin/config/development/cache-debugger`**, permission
  **`administer cache debugger configuration`** (defined in `cache_debugger.permissions.yml`). Menu
  link under *Configuration → Development* (`cache_debugger.links.menu.yml`).
- One config object: **`cache_debugger.settings`** with a single boolean **`cache_debug`**
  (`getEditableConfigNames()`).

## Mechanism (from source)

- `buildForm()` shows a `#plain_text` warning ("only on development environments, never on
  production") and one `checkbox` **`cache_debug`**.
- `submitForm()` saves `cache_debug` to config, then calls `enableCacheDebug()` or
  `disableCacheDebug()`.
- `enableCacheDebug()` — **only if `sites/default/services.yml` does not already exist**: copies
  `default.services.yml` → `services.yml` (`prepareServicesYml()`), replaces the last `debug: false`
  with `debug: true` (`updateServicesYml()`, via `strrpos`/`substr` string splice — not user input),
  then `drupal_flush_all_caches()`.
- `disableCacheDebug()` — if the file exists: `removeServicesYml()` `unlink()`s it, then flushes.
- `prepareServicesYml()`/`removeServicesYml()` `chmod` `sites/default` to `0777` for the file op and
  back to `0555` afterward. Constants: `SERVICES_YML`, `DEFAULT_SERVICES_YML`, `SITES_DEFAULT_DIR`,
  `PERMISSION_WRITE=0777`, `PERMISSION_READ=0555`.

## Notes / caveats

- If a site already ships `sites/default/services.yml`, enabling is a **no-op** for the toggle (the
  `!file_exists` guard skips the copy/replace) — the box saves but the file is untouched.
- Disabling **deletes** `sites/default/services.yml` outright; any manual settings a site kept there
  are lost. It also leaves `sites/default` at `0555` (read-only), which is normal hardened perms.
- The only effect is Drupal core's own render-cache debug comments (cache tags/contexts/keys/max-age
  in HTML). The route is admin-permission gated; the form has standard Drupal CSRF protection.
