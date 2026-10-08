<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PatchInfo (patchinfo) — agent index

Tracks which patches are applied to which modules/themes and surfaces them on the core **update**
module's admin pages, so an update doesn't silently drop the fixes layered on top of a project. On
every extension-info parse (`hook_system_info_alter`) it asks each enabled **`PatchInfoSource`**
plugin for patch records, caches them in a `patchinfo` DB table keyed by target module, and then
injects them — via form-alters, a theme-registry alter and preprocess hooks — into the update status
report (`/admin/reports/updates`) and the update manager form (`/admin/reports/updates/update`). Patch
records come from wherever a source plugin reads them: `composer.json` (`extra.patches`, cweagans
format), legacy `patches:` lists in `*.info.yml`, or drupal.org issue references. A `drush
patchinfo:list` command reports the same data on the CLI. It defines **no routes and no permissions of
its own** — every surface is an existing update-module admin page.

> **OBSOLETE lifecycle.** `patchinfo.info.yml` declares `lifecycle: obsolete`
> (`lifecycle_link: https://www.drupal.org/project/patchinfo/issues/3566867`). Drupal core refuses to
> install a module in the obsolete state, so it **cannot be freshly enabled** (confirmed: enable
> failed on this site); a site upgraded from an older release where it was already installed keeps
> working. Do not plan new work around it. The maintainers point to keeping patches recorded in
> `composer.json` (with an issue URL + comment per entry) as the durable replacement. This doc
> describes the real surface for sites that still carry it and for understanding the mechanism.

- Depends on: `drupal:update`. Core: `^10.1 || ^11`. Package: `Administration`. PHP `>=7.2`, `ext-json`.
- `configure` route: **`update.settings`** (it adds an "Exclude modules from update check" textarea to
  the update module's own settings form — it has no settings page of its own).
- Provides: config schema (`patchinfo.settings`), a DB table (`patchinfo`), drush commands, one plugin
  type (`PatchInfoSource`). No permissions. No own routes.
- Submodules (each also `lifecycle: obsolete`): **`patchinfo_source_info`** (info.yml patch source,
  plugin `patchinfo_info_yml`), **`patchinfo_source_composer`** (composer.json patch source, plugin
  `patchinfo_composer`), **`patchinfo_drupalorg`** (adds drupal.org issue metadata to the drush report
  via `patchinfo_drupalorg:list` + `PatchinfoDrupalorgService`). Enable one or both source submodules
  to actually collect anything.

## What you'd do → where

- **Understand how patches are collected, stored, rendered and queried; write a custom patch source;
  the plugin type, DB table, drush commands, hooks and config** → [api/patch-sources.md](api/patch-sources.md)
- **Record a patch** → add it to `composer.json` `extra.patches` (with `patchinfo_composer`) or a
  `patches:` list in the target's `*.info.yml` (with `patchinfo_info_yml`). See the api doc.
- **Exclude a module from the update check** → update settings form textarea → config
  `patchinfo.settings:exclude from update check`. See the api doc.
- **Report patches on the CLI** → `drush patchinfo:list` (alias `pil`). See the api doc.

## Key facts (real machine names)

- Plugin type: **`PatchInfoSource`** — manager `plugin.manager.patchinfo_source`
  (`PatchInfoSourceManager`), dir `Plugin/PatchInfo/Source`, interface `PatchInfoSourceInterface`,
  base `PatchInfoSourceBase`, annotation `@PatchInfoSource(id,label)`, alter hook
  `hook_patchinfo_source_alter`. Bundled ids: `patchinfo_info_yml`, `patchinfo_composer`.
- Services: `plugin.manager.patchinfo_source`; `patchinfo.commands` (drush);
  `patchinfo_drupalorg.patchinfo_drupalorg_service` (`PatchinfoDrupalorgService`, submodule).
- DB table: `patchinfo` (`module`, `id`, `url`, `info`, `source_module`, `source`; PK
  `source_module,module,id`). Helpers `_patchinfo_get_info()`, `_patchinfo_get_patches()`,
  `_patchinfo_process_module()`, `_patchinfo_clear_db()`.
- Hooks implemented: `hook_system_info_alter`, `hook_update_projects_alter`,
  `hook_form_update_manager_update_form_alter`, `hook_form_update_settings_alter`, `hook_theme`,
  `hook_theme_registry_alter`, `hook_preprocess_update_report`, `hook_preprocess_update_project_status`.
- Integrator hooks provided: `hook_patchinfo_source_alter`, `hook_patchinfo_list_row_alter`.
- Themes: `patchinfo_patches`, `patchinfo_excluded_modules`. Library: `patchinfo/patchinfo`
  (`css/patchinfo.css`).
- Config: `patchinfo.settings` → `exclude from update check` (sequence of module machine names).
- Drush: `patchinfo:list` (`pil`, `patchinfo-list`, `pi-list`); `patchinfo_drupalorg:list`
  (`patchinfo-do-list`, hidden); legacy `patchinfo.drush.inc`.
