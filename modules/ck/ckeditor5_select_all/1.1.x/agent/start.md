<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Select All (ckeditor5_select_all) — agent index

A pure-YAML CKEditor 5 plugin that adds a **Select All** toolbar button and enables the Ctrl/Cmd+A
shortcut scoped to the editor, by wiring a Drupal toolbar item to the `selectAll.SelectAll` plugin
that already ships with CKEditor 5 in Drupal core. There is no custom PHP class — the definition in
`ckeditor5_select_all.ckeditor5.yml` resolves to core's `CKEditor5PluginDefault`. The `.module` file
is a docblock only; the module has no routes, services, permissions, drush, hooks, config form, or
JavaScript of its own. It is enabled **per text format** through the CKEditor 5 toolbar
drag-and-drop UI, so which editors get the button is a text-format decision, not a site-wide one.
Depends on core `ckeditor5` only; targets `^10 || ^11`.

**Why it is more than a convenience:** Ctrl+A acts on the editor only when focus is already inside
the editing area; click outside and it selects the whole page. A toolbar button removes that
ambiguity and gives pointer-only and assistive-technology users an explicit control for an operation
that otherwise assumes a keyboard.

Facts:
- **Depends on:** `ckeditor5` (Drupal core).
- **Core:** `^10 || ^11`. **Package:** CKEditor 5. **License:** GPL-2.0-or-later.
- No settings page (`configure: ''` → null), no permissions, no services, no routes, no drush, no
  hooks, no plugin *types*, no custom JS.

## What you'd do → where

- **Add the Select All button to a text format's toolbar (the only setup step)** →
  [configure/toolbar.md](configure/toolbar.md)
- **Understand how the YAML-only CKEditor 5 plugin is registered (reusable pattern for wrapping a
  core-bundled CKEditor 5 feature)** → [plugins/ckeditor5-plugin.md](plugins/ckeditor5-plugin.md)

## Key facts (real machine names)

- **CKEditor 5 plugin id:** `ckeditor5_select_all_selectall` (the top-level key in
  `ckeditor5_select_all.ckeditor5.yml`). It binds the upstream CKEditor 5 plugin
  `selectAll.SelectAll` (bundled with core, not shipped by this module).
- **Toolbar item id:** `selectall` (label "Select All") — this is the string stored in a text
  format's `editor.editor.{format}` toolbar `items` array.
- **`elements: false`** — the plugin adds no HTML elements/tags, so no text-format filter or
  allowed-HTML changes are needed.
- **Admin library:** `ckeditor5_select_all/admin.selectall` — CSS only (`css/selectall.admin.css`),
  which sets the button icon `icons/marker.svg` via the `.ckeditor5-toolbar-button-selectAll` class.
- **Config schema key:** `ckeditor5.plugin.ckeditor5_select_all_selectall`
  (`config/schema/ckeditor5_select_all.schema.yml`) — an empty mapping; the plugin stores no settings.
- **Tests:** one kernel test, `SelectAllKernelTest` (`@group ckeditor5_select_all`), covering plugin
  discovery, toolbar-item registration, label, `elements: false`, `CKEditor5PluginDefault`
  instantiation, empty dynamic config, library + schema existence, and editor-entity persistence.
- **No security surface.**
