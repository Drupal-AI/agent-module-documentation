<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Widget Menu (ckeditor_widget_menu) — agent index

Purely a **CKEditor toolbar layout helper**. It collapses a run of toolbar buttons into a single
labelled dropdown ("Widget Blocks") so a toolbar carrying many widget/insert buttons stays on one
row. Version **1.1.0**, `core_version_requirement: ^8 || ^9 || ^10 || ^11`, package CKEditor,
GPL-2.0-or-later.

## What it is NOT
It does **not** insert a Drupal menu into content, provides **no** text-format filter, **no** routes
(`*.routing.yml` absent), **no** permissions (`*.permissions.yml` absent), **no** config schema, and
**no** services or entities. It renders nothing at display time. The word "Menu" refers to the
toolbar **dropdown**, not to a `menu` entity. Do not confuse it with menu-embedding modules.

## Real mechanism (CKEditor 5)
- `ckeditor_widget_menu.ckeditor5.yml` declares one toolbar item `widgetMenu` backed by a JS plugin
  `widget_menu.WidgetMenu`. That JS plugin (`js/build/widget_menu.js`, source
  `js/ckeditor5_plugins/widget_menu/src/widgetmenu.js`) is an **empty CKEditor 5 `Plugin` subclass**
  — it only declares `pluginName = 'WidgetMenu'` and does no editing/model work. Its presence just
  makes `widgetMenu` a registerable toolbar item.
- The actual grouping happens server-side in `ckeditor_widget_menu.module` →
  `hook_editor_js_settings_alter()`. For every text-format editor whose toolbar `items` array
  contains `widgetMenu`, it: finds the `widgetMenu` position, takes every item between it and the
  **next `|` separator**, splices those items out of the flat toolbar, and replaces them with a
  single nested-dropdown item `{ type: 'button', label: 'Widget Blocks', icon: <inline SVG>, items:
  [...those items...] }`. CKEditor 5's native toolbar then renders that as a dropdown. The SVG icon
  is read with `file_get_contents()` from the module's own
  `js/ckeditor5_plugins/widget_menu/theme/icons/widget_menu.svg`.
- So configuration is entirely "place `widgetMenu` in the toolbar, then place the buttons you want
  grouped to its right, ending the group with a `|`." No settings form, no per-format config.

## Legacy CKEditor 4 path (still shipped)
- `src/Plugin/CKEditorPlugin/CKEditorWidgetMenu.php` (`@CKEditorPlugin id="widget_menu"`) wires a
  CKEditor 4 button whose JS/icon come from an **external npm library** the site must install into
  `/libraries/widget_menu/` (`plugin.js`, `icons/widget_menu.png`) — see
  <https://www.npmjs.com/package/ckeditor-widgetmenu>. `getConfig()` returns `[]`.
- `src/Plugin/CKEditor4To5Upgrade/WidgetMenu.php` maps the CKE4 `widget_menu` button to the CKE5
  `widgetMenu` item during the core CKEditor 4→5 upgrade.

## Libraries / assets
- `ckeditor_widget_menu.libraries.yml`: `widget_menu` (the built JS, depends on `core/ckeditor5`)
  and `admin` (`css/widget_menu.admin.css`, loaded in the text-format config form to style the
  toolbar-config icon).

## Solution docs
- `editor/toolbar-grouping.md` — how to configure the dropdown, the exact separator rule, CKE5 vs
  CKE4, and the two operational things worth checking (keyboard operability, consistent grouping).
