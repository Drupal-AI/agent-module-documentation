<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Discovery service, libraries hooks & page attachment

## The discovery service

`library_manager.library_discovery` → `Drupal\library_manager\LibraryDiscovery`, which **extends**
core `\Drupal\Core\Asset\LibraryDiscovery` and implements `LibraryDiscoveryInterface` (extends the
core interface). Constructor args (`services.yml`): `@library.discovery.collector`,
`@module_handler`, `@theme_handler`, `%app.root%`. Methods beyond core:

- `getLibraries()` — walks every enabled extension (`getEnabledExtensions()` uses an
  `ExtensionDiscovery` scan of modules + profiles + themes plus `core`) and returns every library
  keyed `extension/name`, each entry annotated with `extension` and `name`.
- `exportLibraryByName($extension, $library)` — reads the extension's `*.libraries.yml`, merges any
  `hook_library_info_build()` output, applies `hook_library_info_alter()`, and returns the raw
  (pre-parsed) definition for that library, or `FALSE`. Used by the details/export/build flows and
  `drush lm:export`.
- `getExtensionPath($extension)` / `processLibraryVersion($version)` — path helper and version
  normaliser (`VERSION` → `\Drupal::VERSION`, strips a leading `v`).

Consumed by: `LibraryCollectionController` (list + autocomplete), `LibraryDetailsController`
(details + YAML export), `LibraryDefinitionBuildForm` (seed), `SettingsForm` (cache clear),
`AssetsCheckForm` and the Drush commands.

## How a definition becomes a real library

All in `library_manager.module`:

### `hook_library_info_build()`

Registers every enabled definition under the **`library_manager`** extension. It calls
`library_manager_build_libraries()`, whose `libraries` array is returned (plus it self-registers
the module's own `library_manager` UI library: `js/library-manager.js` + `core/jquery`,
`core/once`, `core/drupal.debounce`).

### `library_manager_build_libraries()` (the core builder, `drupal_static`-cached)

For each definition with `status = TRUE`:

- Reads `libraries_path` from config; deletes then rebuilds the definition's on-disk folder.
- **JS**: for each file — `external` → keyed by its `url` with `type: external`; `code_type ==
  file_upload` → loads the managed `File`, resolves a served path via `file_url_generator`;
  otherwise **inline code** is written to `libraries_path/{id}/{file_name}` with
  `library_manager_save_file()` (which `prepareDirectory()` + `saveData(EXISTS_REPLACE)`), keyed by
  the local path. Options carry `minified`, `preprocess`, optional `weight`, `header`, and custom
  `attributes` (including `nomodule`).
- **CSS**: same three cases, grouped under the file's `group` (`base`/`layout`/`component`/`state`/
  `theme`); options carry `minified`, `preprocess`, `weight`.
- Adds `library_dependencies` as `dependencies`.
- Routing of the result: if the definition has a `target` **and** `override_by_visibility`, it goes
  into `libraries` (so it registers as `library_manager/{id}` and is swapped in per-page); if it has
  a `target` without override-by-visibility, it goes into `overrides[target]`; a definition with no
  target always goes into `libraries`.

### `hook_library_info_alter()`

Replaces any library whose `extension/library` id matches an entry in the builder's `overrides`
map — this is how the module overrides libraries declared by core, modules and themes.

### `hook_page_attachments()` / `hook_page_attachments_alter()`

- `hook_page_attachments()` loads enabled definitions that are either **new libraries with
  `load = TRUE`** (no target) or **override-by-visibility** definitions, evaluates each definition's
  visibility conditions (applying context via `context.repository` + `context.handler`, catching
  `ContextException` as a missing context), and — when every condition passes — attaches
  `library_manager/{id}`.
- `hook_page_attachments_alter()` handles the override-by-visibility case in reverse: when such a
  definition's conditions pass, it **removes** the original `target` library from the page's
  attachments so the override (attached above) takes its place only on the matching pages.

### Other hooks

- `hook_css_alter()` re-groups a definition's CSS into `CSS_AGGREGATE_THEME` vs
  `CSS_AGGREGATE_DEFAULT` based on the file's group.
- `hook_codemirror_editor_assets_alter()` adds the CodeMirror `javascript`, `css` and `yaml` mode
  assets so the editor highlights all three.

## Controllers

- `LibraryCollectionController::buildCollection()` — the `/admin/structure/library` table (name,
  version, licence, definition link, Export/Create-definition ops); `buildAutocomplete()` powers the
  `library_manager.library_autocomplete` route (substring match over library ids), used by the
  override-target and dependency autocompletes.
- `LibraryDetailsController::details()` — a single library page (remote, version, licence, JS/CSS
  file links, dependencies, and a "Required by" reverse-dependency list). `export()` renders the
  library's YAML in a read-only CodeMirror textarea.
