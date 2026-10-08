<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Patches (webpatches) — agent index

Read-only admin **report** of the Composer patches (and ignored patches) declared for the site. It
does **not** apply, download or fetch patches — Composer does that via cweagans/composer-patches +
the webship/patches plugin. This module reads the same declarations on disk and applies the same
allowlist/ignore rules so the applied and filtered-out sets are visible in the UI.

- **Version:** 12.0.x. **Core:** `^11.4 || ^12`. **License:** GPL-2.0-or-later.
- **Composer/module dependencies:** none beyond Drupal core. Ships config + schema (`provides_config_schema`).
- **No** entities, plugins, drush commands, or submodules.

## Routes & permissions
- `webpatches.list` → `/admin/reports/webpatches` (Reports menu), permission **`view webpatches report`** (`restrict access: TRUE`). Controller `PatchesController::listPatches`.
- `webpatches.settings` → `/admin/config/development/webpatches` (Config → Development), permission **`administer webpatches`** (`restrict access: TRUE`). Form `WebpatchesSettingsForm`. This is the `configure` route.

## Services & classes
- `webpatches.collector` — `PatchesCollector` (implements `PatchesCollectorInterface`), args `%app.root%`, `@config.factory`, `@string_translation`. Reads composer files on disk; discovers sources, patches, ignored patches, dependency providers and `patches.lock.json` sync status.
- `PatchLinks` (static helpers) — derives drupal.org project, issue, package and merge-request URLs from patch strings; returns NULL when a string does not clearly encode a link.
- `Hook\WebpatchesHooks` — OOP `#[Hook('help')]` only (help.page.webpatches).

## Config
- `webpatches.settings`: `sources` (booleans: `root_composer`, `patches_composer`, `custom_file`, `dependency_packages`), `custom_file_path` (string), `only_installed_packages` (bool). Schema in `config/schema/webpatches.schema.yml`.

## Solution docs
- [agent/reports/patches-report.md](reports/patches-report.md) — the report page: route/permission, what each section shows, how `PatchesCollector` discovers declared/ignored patches, and `PatchLinks` behavior.
- [agent/config/settings.md](config/settings.md) — the settings form, config object + schema keys, source selection, custom file path.
