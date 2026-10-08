<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The distribution-update UI (route, path, permission)

Config Distro's `configure` route is **`config_distro.import`**.

## Routes

| Route | Path | Handler |
|---|---|---|
| `config_distro.import` | `/admin/config/development/distro` | `ConfigDistroImportForm` (`_form`) |
| `config_distro.diff` | `/admin/config/development/distro/diff/{source_name}/{target_name}` | `ConfigDistroController::diff` |
| `config_distro.diff_collection` | `/admin/config/development/distro/diff_collection/{collection}/{source_name}/{target_name}` | `ConfigDistroController::diff` |

All three require the **`synchronize distro configuration`** permission (declared
`restrict access: true`, so it is security-sensitive). A menu link "Distribution Update" appears
under *Configuration › Development* (`system.admin_config_development`), with a "Synchronize" tab.

## The form

`ConfigDistroImportForm` (form id `config_distro_import_form`) extends core's `ConfigSync` but
swaps the sync storage for `config_distro.storage.distro` and uses a `NullStorage` snapshot (to
suppress snapshot messages). It lists the changes between the distro storage and active config
and, on submit, imports them — the same result as `drush config-distro-update`. `config_distro`
also swaps core's batch `finished` callback for `ConfigDistroConfigImporterBatch` via
`hook_batch_alter()`.

## There is no settings config

Config Distro has **no settings form and no config object of its own** — `configure` points at
the import screen, not a settings page. Behavior is driven by transform-event subscribers and
(optionally) the `config_distro_ignore` submodule's `config_distro_ignore.settings`.

## Permission reference

| Permission | Gates |
|---|---|
| `synchronize distro configuration` | The import form, the diff pages, and (via config_distro_ignore) the retain-config forms. |

Grant it in code:

```php
user_role_grant_permissions('administrator', ['synchronize distro configuration']);
```
