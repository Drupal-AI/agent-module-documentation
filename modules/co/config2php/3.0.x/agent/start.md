<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config2php — agent start

**Config Export to PHP array** (info.yml `name`). Developer utility that exports one config object as a
ready-to-use **PHP associative array** instead of core's YAML — for pasting into `hook_update_N()` /
`hook_install()` or config-override classes. Version **3.0.4**, core `>=8.7.7`, PHP `8.0`.
Dependencies: core `config` (`>=8.7`) and contrib **`service`** (`service:service`, DI-helper traits).
Package: Development.

## How it works
- Export page: route `config2php.export` at
  `/admin/config/development/configuration/single/export-to-php/{config_type}/{config_name}`,
  form `Config2PhpForm` (extends core `ConfigSingleExportForm`). Gated by core permission
  **`export configuration`**. Surfaces as a local task **"Single item to PHP"** under the core single-export
  tab (`config2php.links.task.yml`, parent `config.export`).
- Conversion: `Config2PhpHelper::convert()` (service `config2php.helper`) runs `var_export()` then cosmetic
  `preg_replace` passes → `[]` short arrays, `key => value` arrows, stripped numeric keys, uppercase
  `TRUE`/`FALSE`, trailing commas. Output is placed in the form's `export` textarea (`#value`) for copy —
  it is **not written to disk or executed**.
- On Drupal **≥ 11.3** a route subscriber (`Config2PhpRouteSubscriber`) swaps the form to
  `Config2PhpHtmxForm`, which rewrites HTMX `data-hx-post` / `hx-push-url` attributes to the `-to-php` path
  (live update without full reload). No functional/trust change.

## Settings
- Route `config2php.settings` at `/admin/config/development/config2php`, form `Config2PhpSettingsForm`,
  gated by module permission **`administer config2php`**. This IS the `configure` route (info.yml).
- Config object `config2php.settings` (schema `config2php.schema.yml`): two keys —
  - `override` (bool, default `false`): when on, `hook_menu_links_discovered_alter` +
    `hook_menu_local_tasks_alter` repoint the core **Export** tab/link to `config2php.export`.
  - `exclude` (sequence, default `_core, dependencies, langcode, status, uuid`): top-level keys removed from
    an export before display (convenience filter; hidden keys are noted under the textarea).

## Permissions
- `export configuration` — core permission; gates the PHP export form.
- `administer config2php` — module permission; gates the settings form.

## Files of note
- `src/Service/Config2PhpHelper.php` — the var_export→PHP-array formatter (`convert()`).
- `src/Form/Config2PhpForm.php` — export form (`updateExport()` reads config storage, applies `exclude`).
- `src/Form/Config2PhpSettingsForm.php` — settings (`override`, `exclude`).
- `config2php.install` — `update_8701` seeds `exclude`; `update_10001` installs the `service` module.

No Drush commands, no plugin types, no content/entity model. See sibling `usage.md` and `human-docs/`.
