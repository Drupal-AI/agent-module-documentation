<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings

Config object: **`advanced_file_destination.settings`** (config_object, has schema at `config/schema/advanced_file_destination.schema.yml`). Edited by `Form\AdvancedFileDestinationSettingsForm` at route `advanced_file_destination.settings` → `/admin/config/media/advanced-file-destination` (permission `administer advanced file destination`, `_admin_route`).

## Install defaults
`config/install/advanced_file_destination.settings.yml` ships only:
```yaml
enabled_entity_types:
  - node
  - media
```
`hook_install()` (`advanced_file_destination.install`) also creates starter folders `public://images|documents|videos|downloads` and the default directory, then flushes caches.

## Keys (read via `\Drupal::config('advanced_file_destination.settings')->get(...)`)
- `enabled_entity_types` (sequence<string>) — entity types whose upload forms get the selector. The widget/form alters bail early if the current entity type is not listed. Default `[node, media]`.
- `default_directory` (string) — site-wide fallback upload directory; helper `_advanced_file_destination_get_default_directory()` returns it or `public://`.
- `scan_filesystem` (bool) — when true, `AdvancedFileDestinationManager::getAvailableDirectories()` also lists existing subfolders found under each root via `FileSystem::scanDirectory()`.
- `use_private` (bool) — when true AND the user has `access advanced file destination private files`, `private://` is offered as a root.
- `widget_position` (string) — `before` / `after` / `inline`; read by `getWidgetDirectoryPosition()`.
- `display_style` (string) — presentation preference.
- `license_key` (string) — stored value only; not transmitted anywhere.

## Undeclared keys the code also reads (schema drift — declare if you export config)
The settings form and manager also read `include_public`, `include_private`, `include_assets`, `include_temporary`, `include_s3`, `stream_wrapper`, `subdirectory`, and `directory_permissions`. These are **not** in the schema mapping above; `include_*` drive `getValidStreamWrappers()` (which schemes are considered valid, default `public://`), and `directory_permissions` maps a directory key to a required permission in `filterDirectoriesByPermission()`.

## Config schema note
The schema file also defines several `config_entity`-style mappings (`advanced_file_destination_directory.*`, `advanced_file_destination.afd_directory.*`, `advanced_file_destination.entity.afd_directory`). These are legacy: as of `hook_update_8201()` the directory is a **content** entity (`afd_directory`), so the runtime directory data lives in the `afd_directory`/`afd_directory_revision` tables, not in config. `config/install/advanced_file_destination.entity.afd_directory.yml` is a leftover seed for the old config-entity shape.
