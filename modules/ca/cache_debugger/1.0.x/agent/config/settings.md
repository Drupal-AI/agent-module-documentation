<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Debugger — settings form & mechanism

Everything the module does lives in one class: `Drupal\cache_debugger\Form\CacheDebugger`
(`src/Form/CacheDebugger.php`), a core `ConfigFormBase`.

## Install / enable

- `composer require drupal/cache_debugger` then `drush en cache_debugger`. No dependencies beyond
  core. No `.install`, no config to import.
- Grant the permission **`administer cache debugger configuration`** to the roles that may toggle
  debug. It is the module's only permission (`cache_debugger.permissions.yml`). Keep it to trusted
  developer/admin roles — it lets a user rewrite/delete `sites/default/services.yml` and flush caches.

## Route & UI

- Route `cache_debugger.settings` (`cache_debugger.routing.yml`):
  - path `/admin/config/development/cache-debugger`
  - `_form: \Drupal\cache_debugger\Form\CacheDebugger`
  - `_permission: administer cache debugger configuration`
- Menu link `cache_debugger.settings` under `system.admin_config_development`
  (`cache_debugger.links.menu.yml`).

## Config object

- **`cache_debugger.settings`**, one key **`cache_debug`** (boolean). Declared editable in
  `getEditableConfigNames()`. Form id `cache_debugger_settings_form` (`getFormId()`).
- **No config schema ships** (no `config/schema/*.schema.yml`), so this key is schema-less; expect a
  "missing schema" notice under strict config checking / config inspection tools.

## What the form does (`buildForm` / `submitForm`)

1. `buildForm()`: a `#plain_text` description warning it is dev-only, plus a single `checkbox`
   `cache_debug` defaulted from config.
2. `submitForm()`: writes `cache_debug` into `cache_debugger.settings`, then branches:
   - checked → `enableCacheDebug()`
   - unchecked → `disableCacheDebug()`

### enableCacheDebug()

Runs **only if `sites/default/services.yml` does not already exist** (`!file_exists`):

- `prepareServicesYml()`: `chmod(sites/default, 0777)`, `touch()` + `copy(default.services.yml →
  services.yml)`, `chmod(sites/default, 0555)`.
- `updateServicesYml('debug: false', 'debug: true')`: reads the file, finds the **last** occurrence
  with `strrpos`, and splices in the replacement with `substr` concatenation. The search/replace
  strings are hard-coded constants — no request data is interpolated.
- `drupal_flush_all_caches()`.

If `services.yml` already exists, nothing is copied or edited (the toggle still saves in config, so
the checkbox can be "on" while the file is unchanged).

### disableCacheDebug()

If `sites/default/services.yml` exists:

- `removeServicesYml()`: `chmod(sites/default, 0777)`, `unlink(services.yml)`, `chmod(sites/default,
  0555)`.
- `drupal_flush_all_caches()`.

## Class constants

`SERVICES_YML = DRUPAL_ROOT.'/sites/default/services.yml'`,
`DEFAULT_SERVICES_YML = DRUPAL_ROOT.'/sites/default/default.services.yml'`,
`SITES_DEFAULT_DIR = DRUPAL_ROOT.'/sites/default'`, `PERMISSION_WRITE = 0777`,
`PERMISSION_READ = 0555`.

## Operating notes

- Effect of `debug: true` is core behavior: rendered elements get HTML-comment cache metadata (tags,
  contexts, keys, max-age). Turn it off before benchmarking or on production.
- The module needs the web user to be able to write `sites/default` and its `services.yml`; on a
  hardened host where `sites/default` is not writable, the `chmod`/`copy` may fail silently.
- Because disabling **removes** `services.yml`, do not rely on this module on a site that keeps custom
  service overrides in that file — they would be deleted.
