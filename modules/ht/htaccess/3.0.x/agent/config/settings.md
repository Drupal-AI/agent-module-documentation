<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# htaccess — settings form, config, and cron write

## Install / enable

`drush en htaccess -y`. No dependencies. `htaccess_install()` seeds `htaccess.settings` by reading
the current `DRUPAL_ROOT/.htaccess` (if readable) into the `content` key and setting
`configuraciones_extra: ''`, `reemplazar_automaticamente: FALSE`, `eliminar_robots_txt: FALSE`.

`htaccess_requirements($phase)` adds two runtime status-report checks:
- `htaccess_cleanurl` — `REQUIREMENT_ERROR` when `RequestHelper::isCleanUrl()` is false ("Clean
  URLs are mandatory for this module").
- `htaccess_write` — `REQUIREMENT_ERROR` when `DRUPAL_ROOT` is not writable.

## Route & permission

- `htaccess.admin_settings_form` — path `/admin/config/system/htaccess`,
  `_form: '\Drupal\htaccess\Form\HtaccessAdminSettingsForm'`, requirement
  `_permission: 'administer htaccess'`.
- `administer htaccess` is the module's only permission (`htaccess.permissions.yml`), marked
  `restrict access: true`. Menu link `htaccess.admin_settings_form` (parent
  `system.admin_config_system`); local task `htaccess.admin_settings_form_tab`.

## The form — `HtaccessAdminSettingsForm` (extends `ConfigFormBase`)

`getEditableConfigNames()` → `['htaccess.settings']`. Fields built in `buildForm()`:

| Field | Type | Backing config key |
|---|---|---|
| `default_htaccess_path` | textfield (required) | `default_htaccess_path` |
| `content` | textarea, `readonly` | (display only — file contents of the path above) |
| `configuraciones_extra` | textarea | `configuraciones_extra` |
| `reemplazar_automaticamente` | checkbox | `reemplazar_automaticamente` |

`buildForm()` reads the path (`file_get_contents()` when `file_exists() && is_readable()`, else a
placeholder message) and shows it in the read-only `content` textarea. `validateForm()` requires
the path to `file_exists()` and `is_readable()`.

`submitForm()` saves the three keys, then builds
`$full_content = file_get_contents($default_htaccess_path) . "\n\n" . $configuraciones_extra` and,
when the destination is writable, writes it via
`\Drupal::service('file_system')->saveData($full_content, DRUPAL_ROOT . '/.htaccess', FileSystemInterface::EXISTS_REPLACE)`;
otherwise it shows an error. Finally `Cache::invalidateTags(['htaccess'])`.

## Config object `htaccess.settings`

Install defaults (`config/install/htaccess.settings.yml`): `content: ''`,
`configuraciones_extra: ''`, `reemplazar_automaticamente: false`. Schema
(`config/schema/htaccess.schema.yml`, `type: config_object`) declares `content` (string),
`configuraciones_extra` (string), `reemplazar_automaticamente` (boolean).

- `default_htaccess_path` (default `core/assets/scaffold/files/htaccess`) is written by the form
  but is **not declared in the schema**.
- `content` is declared and seeded by `hook_install()` but the form never writes it; only the
  routeless `HtaccessController::content()` reads it.

## Cron — `htaccess_cron()`

When `reemplazar_automaticamente` is true, cron rebuilds the same
`default_content . "\n\n" . configuraciones_extra` string from config and writes it to
`DRUPAL_ROOT/.htaccess` (again guarded by a writability check). This keeps the file in sync with
config on every run. (robots.txt handling was moved to the `robotstxt_utils` submodule.)

## Update hook

`htaccess_update_10001()` does a one-off `str_replace('RewriteRule ^oldpath', 'RewriteRule ^newpath', …)`
on the stored `configuraciones_extra` — a demonstration/sample migration.

## Controller (unused)

`HtaccessController::content()` merges `htaccess.settings:content` with the results of
`invokeAll('htaccess')` and returns a `CacheableResponse` of `text/plain` tagged `htaccess`. No
routing entry points at it, so it is not reachable in 3.0.0.
