<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dev_mode — what enabling/disabling changes

There is **no settings form and no config entity** (`configure` is null, no `config/install`,
no `config/schema`). The whole feature is driven by `hook_install()` / `hook_uninstall()` in
`dev_mode.install`. Enable = dev mode on; uninstall = restore.

## Enable / disable

```
composer require --dev drupal/dev_mode   # suggested install
drush en dev_mode                        # activate dev mode
drush pmu dev_mode                        # uninstall = restore previous settings
```

`hook_install()` ends with `module_set_weight('dev_mode', 49)` and a status message:
*"Development mode enabled! … This module has no user editable configurations. Do not enable on
production sites!"*

## What `dev_mode_install()` does (dev_mode.install)

1. **Snapshot then override config.** Reads current `system.performance` keys `css`, `js`,
   `cache` and `system.logging` key `error_level`, JSON-encodes them into **state**
   `dev_mode.config` (the only record of prior values — inspect with `drush sget dev_mode.config`).
   Then via `configFactory()->getEditable()` it sets:
   - `system.performance:css = { gzip: 0, preprocess: 0 }`
   - `system.performance:js  = { gzip: 0, preprocess: 0 }`
   - `system.performance:cache = { page: { max_age: 0 } }`
   - `system.logging:error_level = 'verbose'`
2. **Append a settings.php include** (only when `is_writable($site_path.'/settings.php')`):
   `file_put_contents(..., FILE_APPEND | LOCK_EX)` adds a block that `include`s
   `modules/contrib/dev_mode/settings.dev_mode.php`. If not writable it logs a warning and
   expects the user to add the block manually (README documents the exact snippet).
3. **services.yml fallback** (only when the settings.php append did not happen): `touch()` and
   string-replace on `sites/default/services.yml` — `debug: false`→`debug: true`,
   `auto_reload: null`→`auto_reload: false`, `cache: true`→`cache: false`. The directory mode is
   set to 0777 for the `touch()` then back to 0555 (string-replace only matches those exact
   tokens, so a reformatted services.yml is left unchanged).
4. `drupal_flush_all_caches()`.

## settings.dev_mode.php (loaded via the settings.php include)

Adds `development.services.yml` to `$settings['container_yamls']` and (re)asserts, at bootstrap:
- `$config['system.logging']['error_level'] = 'verbose'`
- `$config['system.performance']['css'|'js']['preprocess'] = FALSE`
- `$settings['cache']['bins']['render'|'page'|'dynamic_page_cache'] = 'cache.backend.null'`
- `$settings['rebuild_access'] = TRUE`, `$settings['skip_permissions_hardening'] = TRUE`
- adds `dev_mode` to `$settings['config_exclude_modules']`
- `$config['config_split.config_split.config_dev']['status'] = TRUE`

## development.services.yml (the container override)

```yaml
parameters:
  http.response.debug_cacheability_headers: true
  twig.config: { debug: true, auto_reload: true, cache: false }
services:
  cache.backend.null:
    class: Drupal\Core\Cache\NullBackendFactory
```

## Runtime hooks (dev_mode.module)

- `hook_preprocess_page()` attaches library `dev_mode/dev-mode` (`js/dev_mode.js` — logs a
  `console.warn` that dev mode is on).
- `hook_page_attachments_alter()` injects three `<meta http-equiv>` tags:
  `Cache-Control: no-cache, no-store, must-revalidate`, `Pragma: no-cache`, `Expires: 0`.
- `hook_help()` provides the help page text.

## `dev_mode_uninstall()` (restore)

Reads state `dev_mode.config`, JSON-decodes, and writes each captured key back via
`getEditable(...)->set(...)->save()`. Then strips the settings.php include with `str_replace`
(the block must match exactly, or it is left behind), or in the fallback path reverses the
services.yml token edits. Ends with a logger `info` message (`hook_uninstall` cannot use
messenger) and `drupal_flush_all_caches()`.

## Operating notes

- No routes, controllers, permissions, services (beyond core's `NullBackendFactory`), Drush
  commands, or plugin types are provided. Every effect requires `administer modules`.
- The state snapshot is your only rollback record — do not delete `dev_mode.config` state while
  the module is enabled or uninstall cannot restore your prior values.
- After install/uninstall, check the dblog (`drush watchdog:show --type=dev_mode`) for the
  writability warnings, and confirm `sites/default`'s permission mode is what you expect.
