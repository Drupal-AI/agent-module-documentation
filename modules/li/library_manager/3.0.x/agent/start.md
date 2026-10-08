<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Library Manager (library_manager) — agent index

Admin UI over Drupal's asset-library system: `library_definition` **config entities**, in-browser
JS/CSS authoring (CodeMirror), and `hook_library_info_alter()`-based overrides of any extension's
libraries. Version **3.0.6**. Core `^10 || ^11`. Depends on `system` and `codemirror_editor`.
Package: none declared. License GPL-2.0-or-later.

## What it provides

- **Config entity** `library_definition` (`Drupal\library_manager\Entity\LibraryDefinition`,
  config prefix `library_manager.library_definition.`) — the stored library, with its JS/CSS
  files, dependencies, version, licence, visibility conditions and an override target.
- **Service** `library_manager.library_discovery`
  (`Drupal\library_manager\LibraryDiscovery`, extends core `\Drupal\Core\Asset\LibraryDiscovery`)
  — enumerates every library in every enabled extension and exports one as YAML.
- **Hooks** in `library_manager.module`: `hook_library_info_build()` (registers each definition
  under the `library_manager/…` extension), `hook_library_info_alter()` (applies overrides),
  `hook_page_attachments()` / `_alter()` (auto-attach / suppress by visibility), `hook_css_alter()`,
  `hook_codemirror_editor_assets_alter()`.
- **Permission** `administer libraries` (`restrict access: true`) — gates every route except the
  report. `access site reports` gates `/admin/reports/libraries`.
- **Drush** `lm:list`, `lm:export`, `lm:cache-clear`, `lm:check-assets` (aliases `lm-l`, `lm-e`,
  `lm-cc`, `lm-ca`).
- **Config object** `library_manager.settings` (single key `libraries_path`).

## Routes (all `administer libraries` unless noted)

- `/admin/structure/library` — library collection list + autocomplete.
- `/admin/structure/library/settings` — `SettingsForm`.
- `/admin/structure/library/definition` (+ `/add`, `/{id}/edit|delete|duplicate`) — definition CRUD.
- `/admin/structure/library/definition/{id}/js|css/...` — per-file JS/CSS add/edit/delete forms.
- `/admin/structure/library/library/{extension}/{library}` (+ `/build`, `/export`) — details, seed, YAML.
- `/admin/reports/libraries` — `AssetsCheckForm` (`access site reports`).

## Solution docs

- **Config entity, its forms, fields and how a definition becomes a library** →
  [entities/library_definition.md](entities/library_definition.md)
- **Settings form, config object/schema, install defaults** →
  [config/settings.md](config/settings.md)
- **Discovery service, the `library_info` hooks, page attachment / override mechanics** →
  [api/discovery-and-hooks.md](api/discovery-and-hooks.md)
- **Drush commands and the assets report** →
  [drush/commands.md](drush/commands.md)

## Notes

- Code authored here is **configuration, not repository code** — it exports and deploys, but it
  will not appear in a theme code review or a repo grep.
- `library_manager.drush.inc` is a legacy Drush 8 shim; the live commands are the annotated
  `LibraryManagerCommands` service (`drush.services.yml`).
