<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Standalone Styles (ckeditor_standalone_styles) — agent index

Moves management of the CKEditor 5 **"Styles" dropdown** out of the text-format/editor config form and
into a **standalone admin page**, storing each style as a `ckeditor_style` **config entity**. Lets a role
curate the styles list without holding the powerful text-format/allowed-HTML config. It also does something
core does not: it **auto-registers each style's CSS classes with the format's allowed-HTML filter** so the
classes survive filtering. Installed **2.1.0-beta3** (version dir `2.1.x`). Core `^10 || ^11`.
License GPL-2.0-or-later. Sole dependency: core `ckeditor5`.

## What it provides (from source)

- **Config entity type** `ckeditor_style` (`src/Entity/CKEditorStyle.php`) — fields `id`, `label`,
  `element` (one HTML tag, e.g. `p`, `h2`, `span`), `classes` (CSS classes, one per line), `weight`.
  Admin permission `administer ckeditor standalone styles`. Managed via a draggable list + add/edit/delete
  forms at `/admin/config/content/ckeditor_style` (menu link "CKEditor styles" under Content authoring).
  Installed by `hook_update_9200`; older textarea config migrated by
  `post_update_001_migrate_config`.
- **Helper service** `ckeditor_standalone_styles.helper` (`CKEditorStylesHelper`) — reads all style
  entities (sorted by weight) and builds the CKE4 `stylesSet` and CKE5 `style.definitions` arrays; exposes
  a `hook_ckeditor_standalone_styles_alter` alter hook on the CKE4 list.
- **CKE5 Style plugin override** (`src/Plugin/CKEditor5Plugin/Style.php`) — subclasses core's
  `ckeditor5_style` plugin (swapped in via `hook_ckeditor5_plugin_info_alter`) so the dropdown's
  definitions come from this module's entities, filtered to elements the editor's format actually allows.
- **filter_html override** (`src/Plugin/Filter/FilterHtmlCustom.php`) — swapped in via
  `hook_filter_info_alter`; adds each style's classes to the allowed-HTML restrictions, but **only for
  elements already allowed** by the filter (never adds new elements).
- **Two schema constraints removed** (`hook_config_schema_info_alter`) — the `NotBlank` on the style
  plugin's `styles` mapping, and the CKE5 `CKEditor5FundamentalCompatibility` constraint (a deliberate
  validation relaxation, noted as not ideal in the source).
- **Legacy settings form** `CkeditorStandaloneStylesSettingsForm` at
  `/admin/config/content/ckeditor-standalone-styles` — vestigial pre-2.1 textarea form; the current
  workflow is the config-entity UI above.
- **Permission** `administer ckeditor standalone styles`. **Config schema** for the entity. No JS/CSS
  libraries, no routes beyond the entity + legacy form, no Drush, no external calls.

## Solution docs

- **The `ckeditor_style` config entity, its fields, admin UI and forms** → [config/styles.md](config/styles.md)
- **How it wires into CKE5, the filter and validation (hooks, helper, allowed-HTML)** →
  [architecture/integration.md](architecture/integration.md)
