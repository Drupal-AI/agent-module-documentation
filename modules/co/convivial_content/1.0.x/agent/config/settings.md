<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Content — configuration, routes & permissions

## Install / enable
- `drush en convivial_content -y` (or Extend UI). Requires `convivial_core` (dependency in
  `convivial_content.info.yml`), which supplies the admin menu parent
  `convivial_core.admin_convivial` and the `access convivial administration pages` permission.
- Ships a default config on install: `config/install/convivial_content.settings.yml` sets
  `source_url: 'https://raw.githubusercontent.com/morpht/convivial-default-content/main/'`.

## Config object
- Name: `convivial_content.settings`. Schema: `config/schema/convivial_content.schema.yml`.
- Single key: `source_url` (type `string`) — base URL the importer appends filenames to
  (`index.yaml`, the dataset `file`, and `<schema>.yaml`). Must end in a trailing slash to form
  valid URLs (see `DataSourceManager::getFileContent`, which concatenates `$siteSource . $fileName`).

## Routes (`convivial_content.routing.yml`)
| Route | Path | Handler | Requirement |
|---|---|---|---|
| `convivial_content.settings` | `/admin/config/convivial/content/settings` | `Form\SettingsForm` | `_permission: access convivial administration pages` |
| `convivial_content.import` | `/admin/config/convivial/content` | `Form\ImportSettingsForm` | `_permission: access convivial administration pages` |

Both routes are gated by the same convivial admin permission (defined by `convivial_core`, not this
module). This module declares **no** permissions of its own. The FAQ note "import requires
high-level permissions — use the administrator role" reflects that imports create/delete entities
and rewrite `system.site`, so the acting account also needs the relevant entity/config access.

## Menu & tasks
- `convivial_content.links.menu.yml` — adds "Convivial Content" under `convivial_core.admin_convivial`
  (route `convivial_content.settings`).
- `convivial_content.links.task.yml` — two local tasks on `base_route: convivial_content.settings`:
  "Settings" (`convivial_content.settings`) and "Import Content" (`convivial_content.import`).

## SettingsForm (`Form\SettingsForm`, extends `ConfigFormBase`)
- Form id `convivial_content_settings_form`; editable config `convivial_content.settings`.
- One `url` element `source_url` (`#required`), default from config; example value shown is the
  Morpht GitHub raw path. `submitForm` saves `source_url`.

## hook_help
- `Hook\ConvivialContentHooks::help` (`#[Hook('help')]`, legacy shim in `convivial_content.module`)
  returns a short blurb on `help.page.convivial_content`.

## No config schema for datasets
- The imported YAML datasets are not Drupal config; they are remote data parsed with
  `Symfony\Component\Yaml\Yaml`. See `agent/api/importer.md`.
