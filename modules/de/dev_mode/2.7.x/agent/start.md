<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Development Mode (dev_mode) — agent index

Enabling the module switches the site into development mode; uninstalling restores the previous
settings. **No configuration UI, no config entity, no permissions, no schema, no Drush** — the
whole feature lives in `hook_install()` / `hook_uninstall()`. Package `Development`. Core
`^8 || ^9 || ^10 || ^11`. GPL-2.0-or-later. Version 8.x-2.7. Depends only on Drupal core; the
install message says *"Do not enable on production sites!"*.

- **Enable/disable behaviour, every config value it rewrites, the settings.php + services.yml
  edits, and the runtime hooks** → [config/development-settings.md](config/development-settings.md)

## What it actually is

- A toggle module: `drush en dev_mode` turns dev mode on, `drush pmu dev_mode` turns it off.
- `dev_mode_install()` (in `dev_mode.install`) snapshots `system.performance` (`css`, `js`,
  `cache`) and `system.logging` (`error_level`) into **state** `dev_mode.config` (JSON), then
  sets css/js `gzip:0, preprocess:0`, `cache.page.max_age = 0`, `error_level = verbose`.
- It appends an `include` of `settings.dev_mode.php` to `settings.php` (only when that file
  `is_writable()`; otherwise logs a warning). When the settings.php append does not happen, a
  fallback path string-edits `sites/default/services.yml` (`debug`, `auto_reload`, `cache`
  tokens), setting the directory mode to 0777 for the write and back to 0555.
- `settings.dev_mode.php` adds `development.services.yml` to `$settings['container_yamls']` and
  re-asserts the performance/logging overrides, null render/page/dynamic caches,
  `rebuild_access`, `skip_permissions_hardening`, and `config_exclude_modules[] = dev_mode`.
- `development.services.yml` sets `http.response.debug_cacheability_headers: true`,
  `twig.config: {debug:true, auto_reload:true, cache:false}`, and registers `cache.backend.null`
  (`NullBackendFactory`).

## Runtime (dev_mode.module)

- `hook_preprocess_page()` → attaches library `dev_mode/dev-mode` (`js/dev_mode.js` warns in the
  console that dev mode is on).
- `hook_page_attachments_alter()` → injects `Cache-Control: no-cache, no-store, must-revalidate`,
  `Pragma: no-cache`, `Expires: 0` meta tags.
- `hook_help()` → module help text.

## Uninstall

`dev_mode_uninstall()` restores config from the `dev_mode.config` state snapshot, strips the
settings.php include (exact-match `str_replace`), and reverses the services.yml fallback edits.
The state snapshot is the only rollback record — do not delete it while the module is enabled.

## Operating notes

- Every effect requires the `administer modules` permission (enable/uninstall). There are **zero
  routes, controllers, forms, permissions, services, or plugin types** provided.
- Check `drush watchdog:show --type=dev_mode` after install/uninstall for file-writability
  warnings; inspect the snapshot with `drush sget dev_mode.config`.
