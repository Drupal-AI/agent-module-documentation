<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Advanced Container (ckeditor_advanced_container) — agent index

A **CKEditor 5 plugin** that adds a **flexbox `<div>`-based container / column layout** system to the
editor — a table-free way for editors to build responsive multi-column sections (heroes, feature
grids, side-by-side text/image, pricing rows) inside a rich-text field. Everything is stored in the
body field as plain `<div>`s carrying `data-*` attributes, so the layout is portable and survives
restrictive text filters. Package `CKEditor 5`. Core `^10 || ^11` (README also advertises D12
readiness). License GPL-2.0-or-later. Installed **1.1.1** (version dir `1.1.x`).

Client-only feature: **no PHP routes, no services, no permissions, no install/update hooks, no
submodules.** The only server code is the CKEditor 5 plugin class and its per-text-format settings
form. It depends solely on core `ckeditor5`.

## What it provides (from source)

- **CKEditor 5 plugin** `ckeditor_advanced_container_container`
  (`src/Plugin/CKEditor5Plugin/AdvancedContainer.php`, extends `CKEditor5PluginDefault`, implements
  `CKEditor5PluginConfigurableInterface` + `CKEditor5PluginElementsSubsetInterface`). CKEditor JS
  plugin `advancedContainer.AdvancedContainer`; toolbar item `advancedContainer`
  ("Advanced Container"). Declared via the `@CKEditor5Plugin` annotation (no `*.ckeditor5.yml`).
- **Per-text-format settings form** (7 settings: default columns, default gap, responsive default,
  auto-stack mobile/tablet, max nesting depth, click-to-insert) with server-side validation of the
  column count and the gap dimension. Config schema in
  `config/schema/ckeditor_advanced_container.schema.yml`
  (`ckeditor5.plugin.ckeditor_advanced_container_container`). → [config/settings.md](config/settings.md)
- **Elements subset** (`getElementsSubset()`) whitelisting the exact `data-*` attributes plus `class`
  and `id` on `div.advanced-container` / `div.advanced-column`, plus a `<div class>` wildcard so
  editor-chosen classes survive the format's HTML filter (same approach as core Style/Div plugins).
- **Editor JS** (`js/`, ~8 split files, load-order-sensitive — `container.utils.js` sets up the
  shared `CKEditor5.advancedContainer` namespace first): schema/converters, insert command, container
  & column properties balloons, contextual toolbar with live responsive preview, column commands
  (add/remove/move/duplicate/distribute), and CSS-value sanitizers/validators.
- **Frontend behavior** (`js/container.js`, library `container.frontend`): rebuilds inline styles and
  CSS custom properties from the `data-*` attributes when a text filter has stripped the inline
  `style`. Lazily attached only when rendered markup contains the string `advanced-container` — via
  `hook_entity_view` (cache-safe) with `hook_preprocess_field` / `hook_preprocess_block` fallbacks
  for Views fields, custom render arrays and block_content. → [reference/markup.md](reference/markup.md)
- **Editor stylesheet injection**: `hook_library_info_alter` merges this module's
  `ckeditor5-stylesheets` (`css/container.admin.css`) into core's internal CKEditor stylesheet library
  (core only reads that info key from themes, not modules), with a manual `?v=` cache-buster
  (`CKEDITOR_ADVANCED_CONTAINER_EDITOR_CSS_VERSION` in `.module`, kept in sync with the `admin`
  library version).
- **Assets**: `css/container.css` (frontend), `css/container.admin.css` (editor chrome),
  `icons/container.svg`, complete Spanish translation `translations/es.po`.

## Storage model (one-line)

Saved markup is `div.advanced-container > div.advanced-column`. Every option is emitted **twice** — as
an inline `style` (immediate render) and as a `data-*` attribute (source of truth). The full attribute
reference and the CSS custom-property contract are in [reference/markup.md](reference/markup.md).

## Install / use (one-line)

`drush en ckeditor_advanced_container`, then per text format at `/admin/config/content/formats` add the
**Advanced Container** toolbar button and review the plugin settings. If the format restricts HTML,
the elements subset already contributes the needed `<div>` signature. See
[config/settings.md](config/settings.md).

## Solution docs

- **Plugin settings, config schema, defaults, validation, install** → [config/settings.md](config/settings.md)
- **Stored markup contract: container/column `data-*` attributes, CSS custom properties, frontend
  fallback rebuild, editor stylesheet injection, library attachment** → [reference/markup.md](reference/markup.md)
